<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class ShipmentsV2Repository extends EntityRepository
{
    public function dispatchedOrder($data, $branchId, $sellerId) {
        $em1 = getEntityManager();

        $user = $em1->find('User', $sellerId);
        $shipment = $em1->find('ShipmentV2', $data->id);
        
        if ($shipment == null) {
            throw new NotFoundException();
        }
        if ($shipment->getCurrentState() != "READY") {
            throw new PreconditionFailedException();
        }
        if ($branchId != -1 && $shipment->getSourceBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }

        $shipment->setCurrentState('DISPATCHED');
        $em1->persist($shipment);

        $state = new ShipmentStateV2($shipment, $shipment->getCurrentState());
        $state->setPerformedBy($user);
        $state->setCreatedTime(new \DateTime('now'));
        $em1->persist($state);
        
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function receivedShipment($data, $branchId, $sellerId) {

        $em1 = getEntityManager();

        $user = $em1->find('User', $sellerId);
        $shipment = $em1->find('ShipmentV2', $data->id);
        
        if ($shipment == null) {
            throw new NotFoundException();
        }
        if ($shipment->getCurrentState() != "DISPATCHED") {
            throw new PreconditionFailedException();
        }
        if ($branchId != -1 && $shipment->getDestinationBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }

        foreach ($shipment->getItems() as $item) {
            $stock = $em1->find("StockV2", array("sku" =>  $item->getSku()->getCode(), "branch" => $shipment->getDestinationBranch()->getId()));
            if ($stock == null) {
                $stock = new StockV2($item->getSku(), $shipment->getDestinationBranch());
                $stock->setTotal($item->getQuantity());
                $stock->setDamaged(0);
                $stock->setSalesBooked(0);
                $stock->setOnHold(0);
            }else {
                $stock->setTotal($stock->getTotal() + $item->getQuantity());
            }
            $em1->persist($stock);
        }

        $shipment->setCurrentState('RECEIVED');
        $em1->persist($shipment);

        $state = new ShipmentStateV2($shipment, $shipment->getCurrentState());
        $state->setPerformedBy($user);
        $state->setCreatedTime(new \DateTime('now'));
        $em1->persist($state);

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function totalPlaced($sourceId, $destinationId) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        
        $qb->select( 'COUNT(DISTINCT s.shipment) as order', 'o.currentState',
        'COUNT(DISTINCT s.sku) as sku','SUM(s.quantity) as quantity')
            ->from('ShipmentItemV2', 's')
            ->join('s.shipment', 'o')
            ->addGroupBy('o.currentState');
            
        if ($sourceId == -1 && $destinationId == -1) {
            $qb->addSelect('sb.id as sourceId','db.id as destinationId')
                ->join('o.sourceBranch', 'sb')
                ->join('o.destinationBranch', 'db')
                ->addGroupBy('sb.id')
                ->addGroupBy('db.id');
        } else if ($sourceId != -1 && $destinationId != -1) {
            $qb->addSelect('sb.id as sourceId','db.id as destinationId')
                ->join('o.sourceBranch', 'sb')
                ->join('o.destinationBranch', 'db')
                ->addGroupBy('sb.id')
                ->addGroupBy('db.id')
                ->Where("sb.id = $sourceId")
                ->andWhere("db.id = $destinationId");
        } else if ($sourceId != -1) {
            $qb->addSelect('sb.id as sourceId')
                ->join('o.sourceBranch', 'sb')
                ->addGroupBy('sb.id')
                ->Where("sb.id  = $sourceId");
        } else if ($destinationId != -1){
            $qb->addSelect('db.id as destinationId')
                ->join('o.destinationBranch', 'db')
                ->addGroupBy('db.id')
                ->Where("db.id = $destinationId");
        }
       return $qb->getQuery()->getResult();
    }

    public function findAllPaginated($limit, $startIndex) {
        $dql = "SELECT s FROM Shipment s ORDER BY s.dispatchDate DESC";

        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findByDays() {
        $dql = "SELECT s FROM Shipment s WHERE s.createdTime >= DATEADD(day,-7, GETDATE())";
        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(120);
        return $query->getResult();
    }

    public function findByShipmentId($id) {
        return getEntityManager()->find('ShipmentV2', $id);
    }

    
    public function listShipmentV2($sourceId, $destinationId, $status, $startDate, $endDate, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();

        $qb->select('s')
            ->from('ShipmentV2', 's');

        if ($sourceId != -1 && $destinationId != -1) {
            $qb->join('s.sourceBranch', 'sb')
                ->join('s.destinationBranch', 'db')
                ->Where("sb.id = $sourceId")
                ->andWhere("db.id = $destinationId");
        }else if ($sourceId != -1) {
            $qb->join('s.sourceBranch', 'sb')
                ->Where("sb.id  = $sourceId");
        }else if ($destinationId != -1){
            $qb->join('s.destinationBranch', 'db')
                ->Where("db.id = $destinationId");
        }

        if ($status != null) {
            $qb->andWhere("s.currentState = '$status'");
        }

        if ($startDate != null && $endDate != null) {
            $startTime = $startDate . " 00:00:00";
            $endTime = $endDate . " 23:59:59";
            $qb->andWhere("s.createdTime between '$startTime' AND '$endTime'");
        }

        $qb->orderBy('s.createdTime', 'DESC');

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    public function findOne($id, $limit, $startIndex) {
        $dql = "SELECT s FROM Shipment s WHERE s.id = '$id' ORDER BY s.dispatchDate desc";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function delete($code) {
        $dql = "DELETE Shipment s WHERE s.code = $code";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }
}

$shipmentsV2Repository = $em->getRepository('ShipmentV2');