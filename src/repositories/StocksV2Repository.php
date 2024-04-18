<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Doctrine\ORM\Query\ResultSetMapping;
use Doctrine\ORM\NoResultException;

class StocksV2Repository extends EntityRepository {

    public function newStock($data) {

        $em1 = getEntityManager();
        $branch = $em1->find('Branch', $data->branchId);

        if ($branch == null) {
            throw new NotFoundException();
        }
        foreach ($data->skus as $skuData) {
            $sku = $em1->find('SKU', $skuData->code);

            if ($sku == null) {
                throw new NotFoundException();
            }

            $stock = $em1->find("StockV2", array("sku" => $sku->getCode(), "branch" => $branch->getId()));

            if ($stock == null) {
                $stock = new StockV2($sku, $branch);
                $stock->setTotal($skuData->quantity);
                $stock->setDamaged(0);
                $stock->setSalesBooked(0);
                $stock->setOnHold(0);
            }else {
                $stock->setTotal($stock->getTotal() + $skuData->quantity);
            }

            $em1->persist($stock);
        }

        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function markStockAsDamaged($data) {
        $em1 = getEntityManager();
        $branch = $em1->find('Branch', $data->branchId);
        if ($branch == null) {
            throw new NotFoundException();
        }

        foreach ($data->skus as $skuData) {
            $sku = $em1->find('SKU', $skuData->code);

            if ($sku == null) {
                throw new NotFoundException();
            }

            $stock = $em1->find("StockV2", array("sku" => $sku->getCode(), "branch" => $branch->getId()));
            if ($stock == null) {
                throw new NotFoundException();
            }
            if ($skuData->quantity <= $stock->getTotal()) {
                $stock->setDamaged($stock->getDamaged() + $skuData->quantity);
                $stock->setTotal($stock->getTotal() - $skuData->quantity);
                $em1->persist($stock);
            } else {
                throw new PreconditionFailedException();
            }

        }
        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function markStockAsSalesBooked($data) {
        $em1 = getEntityManager();
        $branch = $em1->find('Branch', $data->branchId);

        if ($branch == null) {
            throw new NotFoundException();
        }

        foreach ($data->skus as $skuData) {
            $sku = $em1->find('SKU', $skuData->code);

            if ($sku == null) {
                throw new NotFoundException();
            }

            $stock = $em1->find("StockV2", array("sku" => $sku->getCode(), "branch" => $branch->getId()));
            if ($stock == null) {
                throw new NotFoundException();
            }
            if ($skuData->quantity <= $stock->getTotal()) {
                $stock->setSalesBooked($stock->getSalesBooked() + $skuData->quantity);
                $stock->setTotal($stock->getTotal() - $skuData->quantity);
                $em1->persist($stock);
            } else {
                throw new PreconditionFailedException();
            }

        }
        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function markStockAsOnHold($data) {
        $em1 = getEntityManager();
        $branch = $em1->find('Branch', $data->branchId);

        if ($branch == null) {
            throw new NotFoundException();
        }

        foreach ($data->skus as $skuData) {
            $sku = $em1->find('SKU', $skuData->code);

            if ($sku == null) {
                throw new NotFoundException();
            }

            $stock = $em1->find("StockV2", array("sku" => $sku->getCode(), "branch" => $branch->getId()));
            if ($stock == null) {
                throw new NotFoundException();
            }
            if ($skuData->quantity <= $stock->getTotal()) {
                $stock->setOnHold($stock->getOnHold() + $skuData->quantity);
                $stock->setTotal($stock->getTotal() - $skuData->quantity);
                $em1->persist($stock);
            } else {
                throw new PreconditionFailedException();
            }

        }
        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function returnStockFromOnHold($data, $branchId) {
        $em1 = getEntityManager();
        $branch = $em1->find('Branch', $branchId);
        if ($branch == null) {
            throw new NotFoundException();
        }

        foreach ($data->skus as $skuData) {
            $stock = $em1->find('StockV2', array("sku" => $skuData->code, "branch" => $branchId));
            if ($stock == null) {
                throw new NotFoundException();
            }
            if ($stock->getOnHold() == null) {
                throw new NotFoundException();
            }

            if ($data->status == "return") {
                if ($skuData->quantity <= $stock->getOnHold()) {
                    $stock->setOnHold($stock->getOnHold() - $skuData->quantity);
                    $stock->setTotal($stock->getTotal() + $skuData->quantity);
                    $em1->persist($stock);
                } else {
                    throw new PreconditionFailedException();
                }
            } else if ($data->status == "sales") {
               if ($skuData->quantity <= $stock->getOnHold()) {
                    $stock->setOnHold($stock->getOnHold() - $skuData->quantity);
                    $em1->persist($stock);
                } else {
                    throw new PreconditionFailedException();
                }
            } else if ($data->status == "damaged") {
               if ($skuData->quantity <= $stock->getOnHold()) {
                    $stock->setOnHold($stock->getOnHold() - $skuData->quantity);
                    $stock->setDamaged($stock->getDamaged() + $skuData->quantity);
                    $em1->persist($stock);
                } else {
                    throw new PreconditionFailedException();
                }
            }
        }
        
        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function returnStockFromSalesBooked($data, $branchId) {
        $em1 = getEntityManager();
        $branch = $em1->find('Branch', $branchId);
        if ($branch == null) {
            throw new NotFoundException();
        }

        foreach ($data->skus as $skuData) {
            $stock = $em1->find('StockV2', array("sku" => $skuData->code, "branch" => $branchId));
            if ($stock == null) {
                throw new NotFoundException();
            }
            if ($stock->getSalesBooked() == null) {
                throw new NotFoundException();
            }

            if ($data->status == "return") {
                if ($skuData->quantity <= $stock->getSalesBooked()) {
                    $stock->setSalesBooked($stock->getSalesBooked() - $skuData->quantity);
                    $stock->setTotal($stock->getTotal() + $skuData->quantity);
                    $em1->persist($stock);
                } else {
                    throw new PreconditionFailedException();
                }
            } else if ($data->status == "sales") {
               if ($skuData->quantity <= $stock->getSalesBooked()) {
                    $stock->setSalesBooked($stock->getSalesBooked() - $skuData->quantity);
                    $em1->persist($stock);
                } else {
                    throw new PreconditionFailedException();
                }
            } else if ($data->status == "hold") {
               if ($skuData->quantity <= $stock->getSalesBooked()) {
                    $stock->setSalesBooked($stock->getSalesBooked() - $skuData->quantity);
                    $stock->setOnHold($stock->getOnHold() + $skuData->quantity);
                    $em1->persist($stock);
                } else {
                    throw new PreconditionFailedException();
                }
            } else if ($data->status == "damaged") {
               if ($skuData->quantity <= $stock->getSalesBooked()) {
                    $stock->setSalesBooked($stock->getSalesBooked() - $skuData->quantity);
                    $stock->setDamaged($stock->getDamaged() + $skuData->quantity);
                    $em1->persist($stock);
                } else {
                    throw new PreconditionFailedException();
                }
            }
        }
        
        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }
    
    public function adjustTotal($data) {
        $em1 = getEntityManager();
        $branch = $em1->find('Branch', $data->branchId);

        if ($branch == null) {
            throw new NotFoundException();
        }

        foreach ($data->skus as $skuData) {
            $sku = $em1->find('SKU', $skuData->code);

            // if ($sku == null) {
            //     throw new NotFoundException();
            // }

            if ($sku != null) {
                $stock = $em1->find("StockV2", array("sku" => $sku->getCode(), "branch" => $branch->getId()));
                if ($stock == null) {
                    if (isset($skuData->total)) {
                        $stock = new StockV2($sku, $branch);
                        $stock->setTotal($skuData->total);
                        $stock->setDamaged(0);
                        $stock->setSalesBooked(0);
                        $stock->setOnHold(0);
                        $em1->persist($stock);
                    }
                } else {
                    if (isset($skuData->total)) {
                        $stock->setTotal($skuData->total);
                        $em1->persist($stock);
                    } 
                }

                // else {
                    // throw new PreconditionFailedException();
                // }
            }
        }
        
        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function saleStock($em1, $skuCode, $branch, $quantity) {

       $sku = $em1->find('SKU', $skuCode);

            if ($sku == null) {
                throw new NotFoundException();
            }

            $stock = $em1->find("StockV2", array("sku" => $sku->getCode(), "branch" => $branch));
            if ($stock == null) {
                throw new NotFoundException();
            }
            if ($quantity <= $stock->getTotal()) {

                $stock->setTotal($stock->getTotal() - $quantity);
                $em1->persist($stock);
            } else {
                throw new PreconditionFailedException();
            }
    }

    public function findAllPaginated($limit, $startIndex) {
        $dql = "SELECT s FROM StockV2 s JOIN s.sku sku JOIN s.branch b ORDER BY sku.code, b.branchName ASC";

        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findLowQuantityPaginated($limit, $startIndex) {
        $em1 = getEntityManager();
        $threshold = 10;
        $cfg = $em1->find('Configuration', 1);
        if ($cfg != null) {
            $threshold = $cfg->getStockThreshold();
        }
        $dql = "SELECT s FROM StockV2 s JOIN s.sku sku JOIN s.branch b WHERE s.total <= $threshold ORDER BY sku.code, b.branchName, s.total ASC";

        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findAllByBranchId($branchId) {
        $dql = "SELECT s FROM StockV2 s JOIN Branch b WHERE b.id = $branchId ORDER BY s.skuCode ASC";

        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(120);
        return $query->getResult();
    }

    public function findFiltered($query, $branchId, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('s')
            ->from('StockV2', 's')
            ->join('s.sku', 'sku') 
            ->join('s.branch', 'b')
            ->orderBy('sku.code', 'ASC')
            ->addOrderBy('b.branchName', 'ASC')
            ->addOrderBy('s.total', 'ASC');

        if ($branchId != -1) {
        // $qb->join('s.branch', 'b');
            $qb->andWhere("b.id = $branchId");
        }

        if ($query != '') {

            global $productsRepository;
            global $skusRepository;

            if (RegexHelper::isSkuCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $sku = $skusRepository->findByCode($str);
                
                if (count($sku ) > 0) {
                    $code = $sku[0]->getCode();
                    $qb->andWhere("sku.code = '$code'");
                } else {
                    return array();
                }
            } else if (RegexHelper::isProductCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $product = $productsRepository->findOneByCode($str);

                if (count($product) > 0) {
                    $skuCodes = array();
                    foreach($product[0]->getSkus() as $sku) {
                        array_push($skuCodes, $sku->getCode());
                    }
                    if (count($skuCodes) > 0) {
                        $qb->andWhere('sku.code in (:skuCodes)')
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
                        foreach($product->getSkus() as $sku) {
                        array_push($skuCodes, $sku->getCode());
                        }
                    }

                    if (count($skuCodes) > 0) {
                    $qb->andWhere('sku.code in (:skuCodes)')
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

    // public function findFilteredByBranch($branchId, $limit, $startIndex) {
    //     $zero = 0;
    //     $em1 = getEntityManager();
    //     $qb = $em1->createQueryBuilder();
    //     $qb->select('s')
    //         ->from('StockV2', 's')
    //         ->join('s.sku', 'sku') 
    //         ->join('s.branch', 'b')
    //         ->orderBy('sku.code', 'ASC')
    //         ->addOrderBy('b.branchName', 'ASC')
    //         ->addOrderBy('s.total', 'ASC');

    //     if ($branchId != -1) {
    //     // $qb->join('s.branch', 'b');
    //         $qb->andWhere("b.id = $branchId");
    //         $qb->andWhere("s.total > $zero");
    //     }

    //     $qb->setMaxResults($limit)
    //         ->setFirstResult($startIndex);
    //     return $qb->getQuery()->getResult();
    // }

    public function findFilteredByBranch($branchId, $cateId, $limit, $startIndex) {
        $zero = 0;
        // $cateId = 246;
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('s')
            ->from('StockV2', 's')
            ->join('s.sku', 'sku') 
            ->join('sku.product', 'p') 
            ->join('s.branch', 'b')
            ->join('p.lookups', 'l') 
            ->orderBy('sku.code', 'ASC')
            ->addOrderBy('b.branchName', 'ASC')
            ->addOrderBy('s.total', 'ASC');

        if ($branchId != -1) {
        // $qb->join('s.branch', 'b');
            $qb->andWhere("b.id = $branchId");
            $qb->andWhere("s.total > $zero");
        }

        if ($cateId != -1) {
            $qb->andWhere("l.id = $cateId");
        }

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    public function findFilteredLowQuantity($query, $branchId, $limit, $startIndex) {
        $em1 = getEntityManager();
        
        $threshold = 10;
        $cfg = $em1->find('Configuration', 1);
        if ($cfg != null) {
            $threshold = $cfg->getStockThreshold();
        }
        
        $qb = $em1->createQueryBuilder();
        $qb->select('s')
            ->from('StockV2', 's')
            ->join('s.sku', 'sku') 
            ->join('s.branch', 'b')
            ->orderBy('sku.code', 'ASC')
            ->addOrderBy('b.branchName', 'ASC')
            ->addOrderBy('s.total', 'ASC');

        $qb->andWhere("s.total <= $threshold");

        if ($branchId != -1) {
        // $qb->join('s.branch', 'b');
        $qb->andWhere("b.id = $branchId");
        }

        if ($query != '') {

        global $productsRepository;
        global $skusRepository;

        if (RegexHelper::isSkuCode($query)) {
            $str = RegexHelper::parseSkuCode($query);
            $sku = $skusRepository->findByCode($query);
            if (count($sku ) > 0) {
                $code = $sku[0]->getCode();
                $qb->andWhere("sku.code = '$code'");
            } else {
                return array();
            }
        } else if (RegexHelper::isProductCode($query)) {
            $str = RegexHelper::parseSkuCode($query);
            $product = $productsRepository->findOneByCode($query);
            // if ($product != null) {
            if (count($product) > 0) {
                $skuCodes = array();
                foreach($product[0]->getSkus() as $sku) {
                array_push($skuCodes, $sku->getCode());
                }
                if (count($skuCodes) > 0) {
                    $qb->andWhere('sku.code in (:skuCodes)')
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
                    foreach($product->getSkus() as $sku) {
                    array_push($skuCodes, $sku->getCode());
                    }
                }

                if (count($skuCodes) > 0) {
                $qb->andWhere('sku.code in (:skuCodes)')
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

    
    public function findOne($id) {
        return $this->findOneBy(array('id' => $id));
    }

    public function findStockByBranch($id) {
        $dql = "SELECT s FROM StockV2 s WHERE s.sku = $id";
        $query = getEntityManager()->createQuery($dql);
                                //    ->setMaxResults($limit)
                                //    ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function delete($id) {
        // $dql = "DELETE StockV2 s WHERE s.id = $id";
        $dql = "DELETE FROM StockV2 s WHERE s.sku = '$id'";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

}

$stocksV2Repository = $em->getRepository('StockV2');