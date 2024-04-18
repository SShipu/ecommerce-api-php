<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class MfgOrderSetsRepository extends EntityRepository {

    function save($data) {
        $em1 = getEntityManager();

        $set = new MfgOrderSet();
        $set->setName($data->name);
        $set->setCreatedTime(new \DateTime('now'));

        try {
            $em1->persist($set);
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

        // global $skusRepository;
        for ($i = 0; $i < count($data->skus); $i++) {
            $skuData = $data->skus[$i];
            $item = new MfgOrderItem($set, $i);
            $item->setQuantity($skuData->quantity);
            $sku = $em1->find('SKU', $skuData->code);
            if ($sku != null) {
                $item->setSku($sku);
            }
            $em1->persist($item);
        }

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            /* error code should always be 1062 here */
            throw new ConflictException();
        }

        return $set->getId();
    }

    public function findAllPaginated($limit, $startIndex) {
        $dql = "SELECT m FROM MfgOrderSet m ORDER BY m.name DESC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();

    }

}

$mfgOrderSetsRepository = $em->getRepository('MfgOrderSet');