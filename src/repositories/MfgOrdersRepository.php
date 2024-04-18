<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class MfgOrdersRepository extends EntityRepository {

    function save($data, $sellerId) {
        $em1 = getEntityManager();

        $user = $em1->find('User', $sellerId);

        date_default_timezone_set("Asia/Dhaka");
        $t = microtime(true);
        $micro = sprintf("%06d",($t - floor($t)) * 1000000);
        $dateMicroSec = "'". date('Ymdhis'.$micro, $t) ."'";
        $orderId = 'ORD-'. strtoupper(base_convert($dateMicroSec, 10, 36)) . '-' . $sellerId . '-' . $data->branchId;

        $order = new MfgOrder();
        $order->setId($orderId);
        $order->setCurrentState('PLACED');
        $order->setCreatedTime(new \DateTime('now'));

        $branch = $em1->find('Branch', $data->branchId);
        if ($branch != null)
            $order->setBranch($branch);

        $sedId = $em1->find('MfgOrderSet', $data->setId);
        if ($sedId != null)
            $order->setSet($sedId);

        try {
            $em1->persist($order);
        } catch (PDOException $ex) {
            echo "h2";
            print_r($ex);
        } catch (DBALException $ex) {
          echo "h3";
          print_r($ex);
        } catch(ORMException $ex) {
          echo "h4";
          print_r($ex);
        } catch(Exception $ex) {
          echo "h5";
          print_r($ex);
        }

        $state = new MfgOrderState($order, $order->getCurrentState());
        // $state->setStateName('PLACED');
        $state->setPerformedBy($user);
        $state->setCreatedTime(new \DateTime('now'));
        $em1->persist($state);

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            /* error code should always be 1062 here */
            throw new ConflictException();
        }

        return $order->getId();
    }

    public function completeOrder($data, $branchId, $sellerId) {
        $em1 = getEntityManager();

        $user = $em1->find('User', $sellerId);

        $order = $em1->find('MfgOrder', $data->id);
        if ($order == null) {
            throw new NotFoundException();
        }
        if ($order->getCurrentState() != "PLACED") {
            throw new PreconditionFailedException();
        }
        if ($branchId != -1 && $order->getBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }

        foreach ($order->getSet()->getItems() as $item) {
            $stock = $em1->find("StockV2", array("sku" =>  $item->getSku()->getCode(), "branch" => $order->getBranch()));

            if ($stock == null) {
                $stock = new StockV2($item->getSku(), $order->getBranch());
                $stock->setTotal($item->getQuantity());
                $stock->setDamaged(0);
                $stock->setSalesBooked(0);
                $stock->setOnHold(0);
            }else {
                $stock->setTotal($stock->getTotal() + $item->getQuantity());
            }
            $em1->persist($stock);
        }

        $order->setCurrentState('COMPLETE');
        $em1->persist($order);

        $state = new MfgOrderState($order, $order->getCurrentState());
        $state->setStateName('COMPLETE');
        $state->setPerformedBy($user);
        $state->setCreatedTime(new \DateTime('now'));
        $em1->persist($state);

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            /* error code should always be 1062 here */
            throw new ConflictException();
        }
    }

    public function findAllPaginated($branchId, $limit, $startIndex) {
        if ($branchId == -1 )
            $dql = "SELECT m FROM MfgOrder m ORDER BY m.createdTime DESC";
        else
            $dql = "SELECT m FROM MfgOrder JOIN m.branch b WHERE b.id = $branchId ORDER BY m.createdTime DESC";

        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function listMfgOrder($branchId, $status, $limit, $startIndex) {
        $em1 = getEntityManager();
        // echo $branchId;
        // echo $status;die();
        $qb = $em1->createQueryBuilder();
        $qb->select('m')
            ->from('MfgOrder', 'm');
            
        // if ($branchId != -1 && $status != null){
        //     $qb->join('m.branch', 'b')
        //         ->where("b.id  = $branchId")
        //         ->andWhere("m.currentState = '$status'");
        // } else 
        if ($branchId != -1) {
            $qb->join('m.branch', 'b')
                ->where("b.id  = $branchId");
        }
        
        if ($status != null){
            $qb->andWhere("m.currentState = '$status'");
        }
        
        $qb->orderBy('m.createdTime', 'DESC');
        
        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

}

$mfgOrdersRepository = $em->getRepository('MfgOrder');