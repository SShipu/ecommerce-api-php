<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class MfgOrdersV2Repository extends EntityRepository {

    function save($data, $userId) {
        $em1 = getEntityManager();

        $user = $em1->find('User', $userId);

        date_default_timezone_set("Asia/Dhaka");
        $t = microtime(true);
        $micro = sprintf("%06d",($t - floor($t)) * 1000000);
        $dateMicroSec = "'". date('Ymdhis'.$micro, $t) ."'";
        $orderId = 'ORD-'. strtoupper(base_convert($dateMicroSec, 10, 36)) . '-' . $userId . '-' . $data->factoryId;

        $order = new MfgOrderV2();
        $order->setId($orderId);
        $order->setCurrentState('PLACED');
        $order->setCreatedTime(new \DateTime('now'));
        
        $branch = $em1->find('Branch', $data->factoryId);
        if ($branch != null)
            $order->setBranch($branch);

        $em1->persist($order);

        $state = new MfgOrderStateV2($order, 'PLACED');
        $state->setPerformedBy($user);
        $state->setCreatedTime(new \DateTime('now'));
        $em1->persist($state);


        $skus = array();
        $orderData = array();
        $shipmentData = array();

        foreach($data->items as $item) {
            $sku = null;
            if (array_key_exists($item->sku, $skus)) { //', $skus' was missing
                $sku = $skus[$item->sku];
            } else {
                $sku = $em1->find('SKU', $item->sku);
            }

            if ($sku == null) continue;

            if (array_key_exists($item->sku, $orderData)) {
                $orderData[$item->sku]['quantity'] += $item->quantity;
            } else {
                $orderData[$item->sku] = array('sku' => $sku, 'quantity' => $item->quantity);
            }

            if (array_key_exists($item->branchId, $shipmentData)) {
                array_push($shipmentData[$item->branchId], array('sku' => $sku, 'quantity' => $item->quantity));
            } else {
                $arr = array();
                array_push($arr, array('sku' => $sku, 'quantity' => $item->quantity));
                $shipmentData[$item->branchId] = $arr;
            }
        }

        $seq = 1;
        foreach($orderData as $orderItem) {
            $mfgOrderItem = new MfgOrderItemV2($order, $orderItem['sku'], $seq);
            $mfgOrderItem->setQuantity($orderItem['quantity']);
            $em1->persist($mfgOrderItem);
            $seq++;
        }

        foreach($shipmentData as $key => $value) {
            $destinationBranch = $em1->find('Branch', $key);
            if ($destinationBranch == null)
                continue;

            date_default_timezone_set("Asia/Dhaka");
            $t = microtime(true);
            $micro = sprintf("%06d",($t - floor($t)) * 1000000);
            $dateMicroSec = "'". date('Ymdhis'.$micro, $t) ."'";
            $shipmentId = 'SHP-'. strtoupper(base_convert($dateMicroSec, 10, 36)) . '-' . $data->factoryId . '-' . $key;
            $shipment = new ShipmentV2();
            $shipment->setId($shipmentId);
            $shipment->setType('FACTORY_DISTRIBUTION');
            $shipment->setCurrentState('PROCESSING');
            $shipment->setSourceBranch($branch);
            $shipment->setDestinationBranch($destinationBranch);
            $shipment->setCreatedTime(new \DateTime('now'));
            $shipment->setOrder($order);
            $em1->persist($shipment);

            $shipmentState = new ShipmentStateV2($shipment, 'PROCESSING');
            $shipmentState->setPerformedBy($user);
            $shipmentState->setCreatedTime(new \DateTime('now'));
            $em1->persist($shipmentState);

            $seq = 0;
            foreach($value as $shipmentItemData) {
                $shipmentItem = new ShipmentItemV2($seq, $shipment);
                $shipmentItem->setSku($shipmentItemData['sku']);
                $shipmentItem->setQuantity($shipmentItemData['quantity']);
                $em1->persist($shipmentItem);
                $seq++;
            }
        }

        try {
            $em1->flush();
        } catch(Exception $ex) {
            echo $ex->getMessage();
        }
        
        return $order->getId();
    }
    
    public function processOrder($data, $branchId, $sellerId) {
        $em1 = getEntityManager();

        $user = $em1->find('User', $sellerId);

        $order = $em1->find('MfgOrderV2', $data->id);
        if ($order == null) {
            throw new NotFoundException();
        }
        if ($order->getCurrentState() != "PLACED") {
            throw new PreconditionFailedException();
        }
        if ($branchId != -1 && $order->getBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }

        $order->setCurrentState('PROCESSING');
        $em1->persist($order);

        $state = new MfgOrderStateV2($order, $order->getCurrentState());
        $state->setPerformedBy($user);
        $state->setCreatedTime(new \DateTime('now'));
        $em1->persist($state);

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function completeOrder($data, $branchId, $sellerId) {
        $em1 = getEntityManager();

        $user = $em1->find('User', $sellerId);
        $order = $em1->find('MfgOrderV2', $data->id);
        
        if ($order == null) {
            throw new NotFoundException();
        }
        if ($order->getCurrentState() != "PROCESSING") {
            throw new PreconditionFailedException();
        }


        if ($branchId != -1 && $order->getBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }
        
        $order->setCurrentState('COMPLETE');
        $em1->persist($order);

        $state = new MfgOrderStateV2($order, $order->getCurrentState());
        $state->setPerformedBy($user);
        $state->setCreatedTime(new \DateTime('now'));
        $em1->persist($state);
        
        foreach ($order->getShipments() as $shipment) {
            if ($shipment == null) {
                throw new NotFoundException();
            }
            if ($shipment->getCurrentState() != "PROCESSING") {
                throw new PreconditionFailedException();
            }
            // if ($branchId != -1 && $shipment->getDestinationBranch()->getId() != $branchId) {
            //     throw new ResourceLockedException();
            // }

            $shipment->setCurrentState('READY');
            $em1->persist($shipment);

            $state = new ShipmentStateV2($shipment, $shipment->getCurrentState());
            $state->setPerformedBy($user);
            $state->setCreatedTime(new \DateTime('now'));
            $em1->persist($state);
        }
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function findAllPaginated($branchId, $limit, $startIndex) {
        if ($branchId == -1 )
            $dql = "SELECT m FROM MfgOrderV2 m ORDER BY m.createdTime DESC";
        else
            $dql = "SELECT m FROM MfgOrderV2 JOIN m.branch b WHERE b.id = $branchId ORDER BY m.createdTime DESC";

        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function listMfgOrderV2($branchId, $status, $startDate, $endDate, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('m')
            ->from('MfgOrderV2', 'm');

        if ($branchId != -1 && $status != null){
            $qb->join('m.branch', 'b')
                ->where("b.id  = $branchId")
                ->andWhere("m.currentState = '$status'");
        } else if ($branchId != -1) {
            $qb->join('m.branch', 'b')
                ->where("b.id  = $branchId");
        } else if ($status != null){
            $qb->where("m.currentState = '$status'");
        }

        if ($startDate != null && $endDate != null) {
            $startTime = $startDate . " 00:00:00";
            $endTime = $endDate . " 23:59:59";
            $qb->andWhere("m.createdTime between '$startTime' AND '$endTime'");
        }

        $qb->orderBy('m.createdTime', 'DESC');

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    public function totalPlaced($branchId) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        
        $qb->select( 'COUNT(DISTINCT i.mfgOrder) as order', 'o.currentState',
             'b.id as branchId', 'COUNT(DISTINCT i.sku) as sku',
             'SUM(i.quantity) as quantity')
            ->from('MfgOrderItemV2', 'i')
            ->join('i.mfgOrder', 'o')
            ->join('o.branch', 'b')
            ->addGroupBy('b.id')
            ->addGroupBy('o.currentState');
                
       if ($branchId != -1) {
          $qb->andWhere("b.id = $branchId");
       }
       return $qb->getQuery()->getResult();
    }

    public function totalAdminPlaced($branchId) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();

        $qb->select(
            'COUNT(DISTINCT i.mfgOrder) as order', 'o.currentState','b.id as branchId',
            'COUNT(DISTINCT i.sku) as sku','SUM(i.quantity) as quantity')
            ->from('MfgOrderItemV2', 'i')
            ->join('i.mfgOrder', 'o')
            ->join('o.branch', 'b')
            ->addGroupBy('o.currentState')
            ->addGroupBy('b.id');

       if ($branchId != -1) {
          $qb->andWhere("b.id = $branchId");
       }
       return $qb->getQuery()->getResult();
    }

    public function findByOrderId($id) {
        return getEntityManager()->find('MfgOrderV2', $id);
    }

}

$mfgOrdersV2Repository = $em->getRepository('MfgOrderV2');