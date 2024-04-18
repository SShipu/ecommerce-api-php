<?php

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\ResultSetMapping;
use Doctrine\ORM\NoResultException;

class StocksRepository extends EntityRepository
{

    public function newStock($data)
    {
        $em1 = getEntityManager();

        foreach ($data->skus as $sku) {
            $conn = $em1->getConnection();
            $stmt = $conn->prepare('SELECT * FROM stocks WHERE branch_id = ' . $data->branchId . ' AND sku_code = "' . $sku->code . '" LIMIT 1');
            $stmt->execute();

            $result = $stmt->fetchAll();

            $stock = null;
            if (count($result) > 0) {
                $stock = new Stock();
                $stock->setId($result[0]["id"]);
                $stock->setSkuCode($result[0]["sku_code"]);
                $stock->setTotal($result[0]["total"]);
                $stock->setOnHold($result[0]["on_hold"]);
                $stock->setSalesBooked($result[0]["sales_booked"]);
                $stock->setOnHold($result[0]["on_hold"]);
                $stock->setDamaged($result[0]["damaged"]);

                $branch = $em1->find('Branch', $result[0]["branch_id"]);
                if ($branch != null) {
                    $stock->setBranch($branch);
                }

                $skuDb = $em1->find('SKU', $sku->code);
                if ($skuDb != null) {
                    $stock->setSku($skuDb);
                }
            }

            // echo $sku->amount;die();

            if ($stock != null) {
                $newTotal = $stock->getTotal() + $sku->quantity;
                $stock->setTotal($newTotal);
                $em1->merge($stock);
                $em1->flush();
            } else {
                $stock = new Stock();
                $stock->setSkuCode($sku->code);
                $stock->setTotal($sku->quantity);
                $stock->setDamaged(0);
                $stock->setOnHold(0);
                $stock->setSalesBooked(0);

                $branch = $em1->find('Branch', $data->branchId);

                if ($branch != null) {
                    $stock->setBranch($branch);
                }

                $skuDb = $em1->find('SKU', $sku->code);
                if ($skuDb != null) {
                    $stock->setSku($skuDb);
                }

                $em1->persist($stock);
                $em1->flush();
            }
        }
    }

    public function markStockAsDamaged($data)
    {
        /* TODO: what if no stock entry is present ? */
        $em1 = getEntityManager();

        foreach ($data->skus as $sku) {
            $conn = $em1->getConnection();
            $stmt = $conn->prepare("UPDATE stocks SET total = total - $sku->quantity, damaged = damaged + $sku->quantity WHERE branch_id = " . $data->branchId . ' AND sku_code = "' . $sku->code . '"');
            $stmt->execute();
        }
    }

    public function markStockAsSalesBooked($data)
    {
        /* TODO: what if no stock entry is present ? */
        $em1 = getEntityManager();

        foreach ($data->skus as $sku) {
            $conn = $em1->getConnection();
            $stmt = $conn->prepare("UPDATE stocks SET total = total - $sku->quantity, sales_booked = sales_booked + $sku->quantity WHERE branch_id = " . $data->branchId . ' AND sku_code = "' . $sku->code . '"');
            $stmt->execute();
        }
    }

    public function markStockAsOnHold($data)
    {
        /* TODO: what if no stock entry is present ? */
        $em1 = getEntityManager();

        foreach ($data->skus as $sku) {
            $conn = $em1->getConnection();
            $stmt = $conn->prepare("UPDATE stocks SET total = total - $sku->quantity, on_hold = on_hold + $sku->quantity WHERE branch_id = " . $data->branchId . ' AND sku_code = "' . $sku->code . '"');
            $stmt->execute();
        }
    }

    public function saleStock($skuCode, $branchId, $quantity)
    {
        $sql = "UPDATE stocks SET total = total - $quantity WHERE sku_code = '$skuCode' AND branch_id = $branchId";
        $stmt = getEntityManager()->getConnection()->prepare($sql);
        $stmt->executeQuery();
    }

    public function findAllPaginated($limit, $startIndex)
    {
        $dql = "SELECT s FROM Stock s ORDER BY s.skuCode ASC";

        $query = getEntityManager()->createQuery($dql)
            ->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findAllByBranchId($branchId)
    {
        $dql = "SELECT s FROM Stock s JOIN Branch b WHERE b.id = $branchId ORDER BY s.skuCode ASC";

        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(120);
        return $query->getResult();
    }

    public function findFiltered($query, $branchId, $limit, $startIndex)
    {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('s')
            ->from('Stock', 's')
            ->orderBy('s.skuCode', 'ASC');

        if ($branchId != -1) {
            $qb->join('s.branch', 'b');
            $qb->andWhere("b.id = $branchId");
        }

        if ($query != '') {

            global $productsRepository;
            global $skusRepository;

            if (RegexHelper::isSkuCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $sku = $skusRepository->findByCode($query);
                if (count($sku) > 0) {
                    $code = $sku[0]->getCode();
                    $qb->andWhere("s.skuCode = '$code'");
                } else {
                    return array();
                }
            } else if (RegexHelper::isProductCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $product = $productsRepository->findOneByCode($query);
                // if ($product != null) {
                if (count($product) > 0) {
                    $skuCodes = array();
                    foreach ($product[0]->getSkus() as $sku) {
                        array_push($skuCodes, $sku->getCode());
                    }
                    if (count($skuCodes) > 0) {
                        $qb->andWhere('s.skuCode in (:skuCodes)')
                            ->setParameter('skuCodes', $skuCodes);
                    }
                } else {
                    return array();
                }
            } else {
                $products = $productsRepository->findByTitle($query);
                if (count($products) > 0) {
                    $skuCodes = array();
                    foreach ($products as $product) {
                        foreach ($product->getSkus() as $sku) {
                            array_push($skuCodes, $sku->getCode());
                        }
                    }

                    if (count($skuCodes) > 0) {
                        $qb->andWhere('s.skuCode in (:skuCodes)')
                            ->setParameter('skuCodes', $skuCodes);
                    } else {
                        return array();
                    }
                } else {
                    return array();
                }
            }
        }

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    public function findOne($id)
    {
        return $this->findOneBy(array('id' => $id));
    }

    public function delete($id)
    {
        $dql = "DELETE Stock s WHERE s.id = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }
}

$stocksRepository = $em->getRepository('Stock');
