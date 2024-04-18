<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class ShipmentsRepository extends EntityRepository
{

    public function createShipment($data) {
        $em1 = getEntityManager();

        date_default_timezone_set("Asia/Dhaka");
        $t = microtime(true);
        $micro = sprintf("%06d",($t - floor($t)) * 1000000);
        $dateMicroSec = "'". date('Ymdhis'.$micro, $t) ."'";
        $shipmentId = 'SHP-'. strtoupper(base_convert($dateMicroSec, 10, 36)) . '-' . $data->sourceId . '-' . $data->destinationId;

        $shipment = new Shipment();
        $shipment->setId($shipmentId);
        $shipment->setType('FACTORY_DISTRIBUTION');
        $shipment->setStatus('DISPATCHED');
        $shipment->setDispatchDate(new \DateTime('now'));

        $branch = $em1->find('Branch', $data->sourceId);
        if ($branch != null)
        $shipment->setSourceBranch($branch);

        $branch1 = $em1->find('Branch', $data->destinationId);

        $shipment->setDestinationBranch($branch1);


        global $stocksV2Repository;

        for ($i = 0; $i < count($data->skus); $i++) {
            $skuData = $data->skus[$i];
            $item = new ShipmentItem($i, $shipment);
            $item->setSku($skuData->code);
            $item->setQuantity($skuData->quantity);


            $sku = $em1->find('SKU', $skuData->code);
            if ($sku != null) {
                $item->setSku($sku);
            }
            $em1->persist($item);
            $stocksV2Repository->saleStock($em1, $skuData->code, $data->sourceId, $skuData->quantity);
        }

        $em1->persist($shipment);
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            echo $ex->getMessage();die();
            throw new ConflictException();
        }
        return $shipmentId;

    }

    public function receivedShipment($data, $branchId) {

        $em1 = getEntityManager();

        $shipment = $em1->find('Shipment', $data->shipmentId);
        if ($shipment == null)
            throw new NotFoundException();

        if ($shipment->getStatus() != "DISPATCHED")
            throw new PreconditionFailedException();

        if ($shipment->getDestinationBranch() == null || $shipment->getDestinationBranch()->getId() != $branchId)
            throw new ResourceLockedException();

        foreach ($shipment->getItems() as $item) {
            $stock = $em1->find("StockV2", array("sku" =>  $item->getSku()->getCode(), "branch" => $branchId));

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
        $shipment->setStatus('RECEIVED');
        $shipment->setReceiveDate(new \DateTime('now'));
        $em1->persist($shipment);

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function update($data) {
        $em1 = getEntityManager();
        $shipment = $em1->find('Shipment', $data->code);
        if ($shipment != null) {
            $shipment->setPrice($data->price);
            $shipment->setDiscountPrice($data->discountPrice);

            $em1->persist($shipment);
            try {
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                throw new ConflictException();
            }
        } else {
            throw new NotFoundException();
        }
        return $shipment->getCode();
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
        return getEntityManager()->find('Shipment', $id);
    }

    // public function findByDispatchDates($startDate, $endDate, $limit, $startIndex) {
    //     $dql = "SELECT s FROM Shipment s WHERE s.dispatchDate between '$startDate 00:00:00' AND '$endDate 23:59:59' ORDER BY s.dispatchDate DESC";
    //     $query = getEntityManager()->createQuery($dql)
    //                                ->setMaxResults($limit)
    //                                ->setFirstResult($startIndex);
    //     return $query->getResult();
    // }

    // public function findBySourceBranchDates($branch, $startDate, $endDate, $limit, $startIndex) {
    //     $dql = "SELECT s FROM Shipment s WHERE s.sourceBranch = $branch AND s.dispatchDate between '$startDate 00:00:00' AND '$endDate 23:59:59' ORDER BY s.dispatchDate DESC";
    //     $query = getEntityManager()->createQuery($dql)
    //                                ->setMaxResults($limit)
    //                                ->setFirstResult($startIndex);
    //     return $query->getResult();
    // }

    // public function findBySourceBranch($branchId, $limit, $startIndex) {
    //     $dql = "SELECT s FROM Shipment s WHERE s.sourceBranch = $branchId ORDER BY s.dispatchDate DESC";
    //     $query = getEntityManager()->createQuery($dql)
    //                                ->setMaxResults($limit)
    //                                ->setFirstResult($startIndex);
    //     return $query->getResult();
    // }

    // public function findByDestinationBranchDates($branch, $startDate, $endDate, $limit, $startIndex) {
    //     $dql = "SELECT s FROM Shipment s WHERE s.destinationBranch = $branch AND s.dispatchDate between '$startDate 00:00:00' AND '$endDate 23:59:59' ORDER BY s.dispatchDate DESC";
    //     $query = getEntityManager()->createQuery($dql)
    //                                ->setMaxResults($limit)
    //                                ->setFirstResult($startIndex);
    //     return $query->getResult();
    // }

    // public function findByDestinationBranch($branchId, $limit, $startIndex) {
    //     $dql = "SELECT s FROM Shipment s WHERE s.destinationBranch = $branchId ORDER BY s.dispatchDate DESC";
    //     $query = getEntityManager()->createQuery($dql)
    //                                ->setMaxResults($limit)
    //                                ->setFirstResult($startIndex);
    //     return $query->getResult();
    // }

    public function listShipment($sourceId, $destinationId, $id, $startDate, $endDate, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();

        $qb->select('s')
            ->from('Shipment', 's');

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

        // if ($id != null) {
        //     $qb->Where("s.id = '$id'");
        // }

        if ($startDate != null && $endDate != null) {
            $startTime = $startDate . " 00:00:00";
            $endTime = $endDate . " 23:59:59";
            $qb->andWhere("s.dispatchDate between '$startTime' AND '$endTime'");
        }

        $qb->orderBy('s.dispatchDate', 'DESC');

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

$shipmentsRepository = $em->getRepository('Shipment');
