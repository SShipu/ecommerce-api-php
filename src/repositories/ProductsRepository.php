<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
// use Doctrine\DBAL\Exception\ConstraintViolationException;

class ProductsRepository extends EntityRepository {

    public function save($data) {
        $em1 = getEntityManager();

        
        $prod = new Product();
        $prod->setTitle($data->title);
        $prod->setPrice($data->price);
        $prod->setDiscountPrice($data->discountPrice);

        $discountPercentage = ($data->discountPrice / $data->price) * 100;

        $prod->setDiscountPercentage($discountPercentage);

        if (!empty($data->code))
          $prod->setCode($data->code);
        else {
          $codePrefix = StringHelper::abbreviate($data->title);
          $codeObj = $em1->find('CodePrefix', $codePrefix);
          if ($codeObj == null) {
              $prod->setCode($codePrefix . '1');
              $codeObj = new CodePrefix();
              $codeObj->setPrefix($codePrefix);
              $codeObj->setLastSeq(1);
          } else {
              $suffix = $codeObj->getLastSeq() + 1;
              $codeObj->setLastSeq($suffix);
              $paddedSuffix = $suffix;
              $prod->setCode($codePrefix . $suffix);
          }
          $em1->persist($codeObj);
        }
        $prod->setDescription($data->description);
        $prod->setDefaultSkuCode('');
        $prod->setStatus($data->status);
        $prod->setTimesSold(0);
        $prod->setViewCount(0);
        $prod->setRating(0);
        $prod->setPopularity(0);
        $prod->setDescriptionFormat($data->descriptionFormat);
        $prod->setPlainDescription($data->plainDescription);
        $prod->setCreatedTime(new \DateTime('now', new DateTimeZone('Asia/Dhaka')));

        foreach ($data->lookupIds as $lookupId) {
            $lookup = $em1->find('Lookup', $lookupId);
            if ($lookup != null) {
                $prod->addLookup($lookup);
            }
        }
        
        $tags = '';
        foreach ($data->tags as $tag) {
            $tags = $tags . $tag . ",";
        }
        
        $tags = rtrim($tags, ',');
        $prod->setTags($tags);

        foreach ($data->imageIds as $image) {
            $image = $em1->find('OttomanFile', $image);
            if ($image != null) {
                $prod->addImage($image);
            }
        }

        $em1->persist($prod);

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }

        $productId = $prod->getId();

        for ($i = 0; $i < count($data->skus); $i++) {
           $data->skus[$i]->productId = $productId;
        }



        if (count($data->skus) > 0) {
          global $skusRepository;
          $codes = $skusRepository->batchSave($data->skus);
          $defaultIndex = -1;
          for ($i = 0; $i < count($data->skus); $i++) {
            if ($data->skus[$i]->lapse) {
              $defaultIndex = $i;
              break;
            }
          }

          if ($defaultIndex > -1 && $defaultIndex <= count($codes) - 1) {
            $prod->setDefaultSkuCode($codes[$defaultIndex]);
            $prod->setPrice($data->skus[$i]->price);
            $prod->setDiscountPrice($data->skus[$i]->discountPrice);
            $em1->persist($prod);
          }
        }
        if (isset($data->featured)) {
            $featured = new FeaturedProduct();
            if ($data->featured != null && $data->featured == true) {
                $featured->setProduct($prod);
                $em1->persist($featured);
            }
        } 
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
        
        global $searchIndicesRepository;
        $searchIndicesRepository->createSearchIndex($prod->getId());
        
        return $productId;
    }

    public function update($data) {
        /**
         * TODO: change it
         */
        $em1 = getEntityManager();
        $prod = $em1->find('Product', $data->id);

        if ($prod != null) {
            //$prod->setCode($data->code);
            $prod->setTitle($data->title);
            $prod->setPrice($data->price);
            $prod->setDiscountPrice($data->discountPrice);
            $prod->setDescription($data->description);
            $prod->setDefaultSkuCode('');
            $prod->setStatus($data->status);

            $discountPercentage = ($data->discountPrice / $data->price) * 100;

            $prod->setDiscountPercentage($discountPercentage);
            
            $prod->getLookups()->clear();
            foreach ($data->lookupIds as $lookupId) {
                $lookup = $em1->find('Lookup', $lookupId);
                if ($lookup != null) {
                    $prod->addLookup($lookup);
                }
            }

            $tags = '';
            foreach ($data->tags as $tag) {
                $tags = $tags . $tag . ",";
            }
            $tags = rtrim($tags, ',');
            $prod->setTags($tags);

            $prod->getImages()->clear();
            if ($data->imageIds != null) {
                foreach ($data->imageIds as $image) {
                    $image = $em1->find('OttomanFile', $image);
                    if ($image != null) {
                        $prod->addImage($image);
                    }
                }
            }

            $deletedSkus = array();
            foreach($prod->getSkus() as $existingSku) {
                $found = false;
                for ($i = 0; $i < count($data->skus); $i++) {
                    if (isset($data->skus[$i]->code) && $data->skus[$i]->code == $existingSku->getCode()) {
                      $found = true;
                      break;
                   }
                }
                if (!$found) {
                    array_push($deletedSkus, $existingSku);
                }
            }
            // echo count($deletedSkus);die();

            $defaultSku = null;
            foreach($data->skus as $newSku) {
                if (isset($newSku->code)) {
                    // echo $newSku->code;
                    $oldSku = $em1->find('SKU', $newSku->code);
                    if ($oldSku != null) {
                        $oldSku->setPrice($newSku->price);
                        $oldSku->setDiscountPrice($newSku->discountPrice);
                        $oldSku->setLapse($newSku->lapse);
                        $em1->persist($oldSku);
                        if ($oldSku->getLapse() == TRUE) {
                            $defaultSkuCode = $oldSku;
                        }
                    } else {
                          /* ?? */
                    }
                } else {
                    $sku = new SKU();
                    $sku->setPrice($newSku->price);
                    $sku->setDiscountPrice($newSku->discountPrice);
                    $sku->setLapse(isset($newSku->lapse) && strtolower($newSku->lapse == 'true'));
                    $attrValues = array();
                    foreach ($newSku->attributeValueIds as $attrValueId) {
                        $attrValue = $em1->find('ItemAttributeValue', $attrValueId);
                        if ($attrValue != null) {
                            $sku->addAttributeValue($attrValue);
                            array_push($attrValues, $attrValue);
                        }
                    }
                    $sku->setProduct($prod);
                    $code = $prod->getId() . '-' . $prod->getCode();
                    $label = '';
                    foreach ($attrValues as $attrValue) {
                        $code = $code . '-' . $attrValue->getId();
                        $label = $label . $attrValue->getValue() . ',';
                    }

                    $lblLen = strlen($label);
                    if ($lblLen > 0) {
                        $label = substr($label, 0, $lblLen - 1);
                    }

                    $sku->setCode($code);
                    $sku->setLabel($label);

                    $prod->addSku($sku);
                    $em1->persist($sku);

                    if ($sku->getLapse() == TRUE) {
                            $defaultSku = $sku;
                        }
                }
            }
            
            $undeletedSkus = array();
            if (count($deletedSkus) > 0) {
                foreach ($deletedSkus as $sku) {
                    if ($sku->getStocks() != null && count($sku->getStocks()) > 0) {
                        global $stocksV2Repository;
                        global $productsRepository;

                        $stocksV2Repository->delete($sku->getCode());
                        $productsRepository->deleteProductStat($sku->getCode());
                        
                        foreach($sku->getAttributeValues() as $av) {
                            $sku->getAttributeValues()->removeElement($av);
                        }
                        $prod->removeSku($sku);
                        $sku->setProduct(null);
                        $em1->remove($sku);
                    } else {
                        foreach($sku->getAttributeValues() as $av) {
                            $sku->getAttributeValues()->removeElement($av);
                        }
                        $prod->removeSku($sku);
                        $sku->setProduct(null);
                        $em1->remove($sku);
                    }
                }
            }

            if ($defaultSku != null) {
                $prod->setDefaultSkuCode($defaultSku->getCode());
                $prod->setPrice($defaultSku->getPrice());
                $prod->setDiscountPrice($defaultSku->getDiscountPrice());
                $em1->persist($prod);
            }

            if (isset($data->featured)) {
                $featured = $em1->find('FeaturedProduct', $data->id);
                if ($featured != null) {
                    if ($data->featured == false) {
                        $em1->remove($featured);
                    } 
                } else if ($data->featured != null && $data->featured == true) {
                    $featured = new FeaturedProduct();
                    $featured->setProduct($prod);
                    $em1->persist($featured);
                }
            } 

            try {
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                echo $ex->getMessage();die();
                throw new ConflictException();
            }
            
            global $searchIndicesRepository;
            $searchIndicesRepository->createSearchIndex($data->id);

            return $undeletedSkus;

        } else {
            throw new NotFoundException();
        }
    }

    public function updateDelete($id) {

        $em1 = getEntityManager();
        $prod = $em1->find('Product', $id);

        if ($prod != null) {
            if (str_contains($prod->getTitle(), '(delete)')) { 
                throw new BadRequestException();
            }
            $prodTitle = $prod->getTitle() . ' (delete)';
            
            try {
                $dql = "UPDATE Product p SET p.title = '$prodTitle', p.status = 'DELETE' WHERE p.id = $id";
                $query = getEntityManager()->createQuery($dql);
                return $query->execute();
            } catch (UniqueConstraintViolationException $ex) {
                echo $ex->getMessage();die();
                throw new ConflictException();
            }

        } else {
            throw new NotFoundException();
        }
    }

    public function addImg($data) {
        $em1 = getEntityManager();
        $prod = $em1->find('Product', $data->id);

        if ($prod != null) {

            foreach ($data->imageIds as $image) {
                $image = $em1->find('OttomanFile', $image);
                if ($image != null) {
                    $prod->addImage($image);
                }
            }

            $em1->persist($prod);

            try {
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                echo $ex->getMessage();die();
                throw new ConflictException();
            }

        } else {
            throw new NotFoundException();
        }
        return $prod->getId();
    }

    public function removeImg($data) {

        $em1 = getEntityManager();
        $prod = $em1->find('Product', $data->id);
        $indices = array();

        if ($prod != null) {
            foreach ($data->imageIds as $imageId) {
                for ($i = 0; $i < count($prod->getImages()); $i++) {
                    if ($prod->getImages()[$i]->getId() == $imageId) {
                        array_push($indices, $i);
                        break;
                    }
                }
            }

            rsort($indices);

            foreach ($indices as $index) {
                $prod->getImages()->remove($index);
            }

            $em1->persist($prod);

            try {
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                echo $ex->getMessage();die();
                throw new ConflictException();
            }

        } else {
            throw new NotFoundException();
        }
    }

    public function findAllPaginated($limit, $startIndex) {
        $dql = "SELECT p FROM Product p WHERE p.status = 'ACTIVE' ORDER BY p.title ASC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findAllInactive($limit, $startIndex) {
        $dql = "SELECT p FROM Product p WHERE p.status = 'INACTIVE' ORDER BY p.title ASC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findLatestProduct($limit, $startIndex) {
        $dql = "SELECT p FROM Product p WHERE p.status = 'ACTIVE' ORDER BY p.createdTime DESC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findPriceHighToLow($limit, $startIndex) {
        $dql = "SELECT p FROM Product p WHERE p.status = 'ACTIVE' ORDER BY p.price DESC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findPriceLowToHigh($limit, $startIndex) {
        $dql = "SELECT p FROM Product p WHERE p.status = 'ACTIVE' ORDER BY p.price ASC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findDiscountByPercentage($minPercentage, $maxPercentage, $limit, $startIndex) {
        $dql = "SELECT p FROM Product p WHERE p.discountPercentage >= $minPercentage AND p.discountPercentage <= $maxPercentage AND p.status = 'ACTIVE' ORDER BY p.discountPrice DESC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findDiscountHighToLow($limit, $startIndex) {
        $dql = "SELECT p FROM Product p WHERE p.status = 'ACTIVE' ORDER BY p.discountPrice DESC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findDiscountLowToHigh($limit, $startIndex) {
        $dql = "SELECT p FROM Product p WHERE p.status = 'ACTIVE' ORDER BY p.discountPrice ASC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findTypesLatestProduct($id, $limit, $startIndex) {
        // $dql = "SELECT p, l FROM Product p JOIN p.lookups l where l.id = $id";
        // $dql = "SELECT p FROM Product p WHERE p.status = 'ACTIVE' ORDER BY p.createdTime DESC";
        $dql = "SELECT p, l FROM Product p JOIN p.lookups l WHERE l.id = $id AND p.status = 'ACTIVE' ORDER BY p.createdTime DESC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findTopSales($limit, $startIndex) {
        //    ->addSelect('SUM(product.price) AS HIDDEN stat_sum_realised')
        $dql = "SELECT SUM(p.counter) as HIDDEN counter, p FROM ProductStat p GROUP BY p.product ORDER BY counter DESC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        // echo $query->getSQL();
        return $query->getResult();
    }

    public function findTypesTopSales($id, $limit, $startIndex) {
        // echo $id;
        //    ->addSelect('SUM(product.price) AS HIDDEN stat_sum_realised')
        // SELECT p, l FROM Product p JOIN p.lookups l where l.id = $id
        $dql = "SELECT SUM(p.counter) as HIDDEN counter, p , p1, l FROM ProductStat p JOIN p.product p1 JOIN p1.lookups l where l.id = $id GROUP BY p1 ORDER BY counter DESC";
        // echo $dql;
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        // echo $query->getSQL();
        return $query->getResult();
    }

    public function findAllFeaturedPaginated($limit, $startIndex) {
        $dql = "SELECT f, p FROM FeaturedProduct f JOIN f.product p WHERE p.status = 'ACTIVE' ORDER BY f.product ASC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findOne($id) {
        $dql = "SELECT p FROM Product p WHERE p.id = $id AND p.status = 'ACTIVE'";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

    public function findOneByCode($code) {
        // return $this->findOneBy(array('code' => $code));
        $dql = "SELECT p FROM Product p WHERE p.code = '$code' AND p.status = 'ACTIVE'";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

    public function findByTitle($query) {
      $dql = "SELECT p FROM Product p WHERE LOWER(p.title) LIKE '%$query%' AND p.status = 'ACTIVE'";
      $query = getEntityManager()->createQuery($dql);
      $query->setMaxResults(120);
      return $query->getResult();
    }

    public function delete($id) {

        $em1 = getEntityManager();

        $product = $em1->find('Product', $id);
        if ($product != null) {
            $em1->remove($product);
            $em1->flush();
        }
    }

    public function skuGet($id) {
        $dql = "SELECT s FROM SKU s WHERE s.product = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->getResult();
    }

    public function getProductLookups($id) { //find-one-test.php
        // $dql = "SELECT p FROM product p JOIN p.lookups l WHERE p.product_id = $id";
        // $query = getEntityManager()->createQuery($dql);
        // return $query->getResult();

        $qb = $this->getEntityManager()->createQueryBuilder('p')
            // ->select('p.id as productId, l.id as lookupId')
            ->innerJoin('p.lookups', 'l')
            ->where('l.product_id = :product_id')
            // ->andWhere('p.status = "ACTIVE"')
            ->setParameter('product_id', $id);
        return $qb->getQuery()->getResult();
    }

    public function setInactive($id) {
        $dql = "UPDATE Product p SET p.status = 'INACTIVE' WHERE p.id = $id AND p.status = 'ACTIVE'";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

    public function searchProduct($catIds, $bandIds, $brandIds) {

        $qb = $this->getEntityManager()->createQueryBuilder();

        $lookupWhereClause = '';

        if ($catIds != null && count($catIds) > 0) {
            if (strlen($lookupWhereClause) > 0) {
                $lookupWhereClause .= ' OR';
            }

            $lookupWhereClause .= ' l.id IN (:categoryIds) ';
            $qb->setParameter('categoryIds', $catIds);
        }

        if ($bandIds != null && count($bandIds) > 0) {
            if (strlen($lookupWhereClause) > 0) {
                $lookupWhereClause .= ' OR';
            }

            $lookupWhereClause .= ' l.id IN (:bandIds) ';
            $qb->setParameter('bandIds', $bandIds);
        }

        if ($brandIds != null && count($brandIds) > 0) {
            if (strlen($lookupWhereClause) > 0) {
                $lookupWhereClause .= ' OR';
            }

            $lookupWhereClause .= ' l.id IN (:brandIds) ';
            $qb->setParameter('brandIds', $brandIds);
        }

        $result = $qb->select('p')
            ->from('Product', 'p')
            ->join('p.lookups', 'l')
            ->where($lookupWhereClause)
            ->andWhere('p.status = "ACTIVE"')
            ->getQuery()
            ->getResult();

        echo $qb->getDql();

        return $result;

    }

    public function advancedSearch($data, $limit, $startIndex) {
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select('s')
           ->from('SearchIndex', 's')
           ->join('s.product', 'p');
        
        if (isset($data->query) && $data->query != "") {
            $qb->andWhere($qb->expr()->like('p.title', "'%" . $data->query . "%'"));
        }

        if (isset($data->minPrice)) {
            $qb->andWhere("p.price >= '$data->minPrice'");
        }

        if (isset($data->maxPrice)) {
            $qb->andWhere("p.price <= '$data->maxPrice'");
        }

        if (isset($data->discountPercentage)) {
            $qb->andWhere("p.discountPercentage >= $data->discountPercentage");
                // ->andWhere("p.discountPercentage <= $data->maxPercentage");
            // p.discountPercentage >= $minPercentage AND p.discountPercentage <= $maxPercentage
        }

        if (isset($data->attributes) && count($data->attributes) > 0) {

            $attribExpr = $qb->expr()->andX();
            foreach($data->attributes as $attribute) {
                $exprSingleAttrib = $qb->expr()->andX();
                foreach($attribute->valueIds as $valueId) {
                    $exprSingleAttrib->add($qb->expr()->like('s.attributeValues', "'%#" . $valueId . "#%'"));
                }
                $attribExpr->add($exprSingleAttrib);
            }
            $qb->andWhere($attribExpr);
        }

        if (isset($data->lookups) && count($data->lookups) > 0) {

            $lookupExpr = $qb->expr()->andX();
            foreach($data->lookups as $lookup) {
                $exprSingleLookup = $qb->expr()->orX();
                foreach($lookup->lookupIds as $lookupId) {
                    $exprSingleLookup->add($qb->expr()->like('s.lookups', "'%#" . $lookupId . "#%'"));
                }
                $lookupExpr->add($exprSingleLookup);
            }
            $qb->andWhere($lookupExpr);
        }

        if (isset($data->tags) && count($data->tags) > 0) {

            $tagExpr = $qb->expr()->andX();

            foreach($data->tags as $tag) {

                $exprSingleTag = $qb->expr()->orX();
                $exprSingleTag->add($qb->expr()->like('s.tags', "'%#" . $tag . "#%'"));
                $tagExpr->add($exprSingleTag);
            }
            
            $qb->andWhere($tagExpr);
        }

        // echo $qb->getDql(); die();
        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        $result = $qb->getQuery()->getResult();
        $products = array();
        foreach ($result as $r)
            array_push($products, $r->getProduct());

        return $products;
    }

    public function advancedSearchForBranch($data, $limit, $startIndex) {
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select('s')
           ->from('SearchIndex', 's')
           ->join('s.product', 'p')
           ->join('p.skus', 'sk')
           ->join('sk.stocks', 'st')
           ->join('st.branch', 'b');

        if (isset($data->branchId) && $data->branchId != -1) {
            $qb->andWhere("b.id = $data->branchId");
            // echo "Branch Id - " . $data->branchId;
        }
        
        if (isset($data->query) && $data->query != "") {
            $qb->andWhere($qb->expr()->like('p.title', "'%" . $data->query . "%'"));
        }

        if (isset($data->minPrice)) {
            $qb->andWhere("p.price >= '$data->minPrice'");
        }

        if (isset($data->maxPrice)) {
            $qb->andWhere("p.price <= '$data->maxPrice'");
        }

        if (isset($data->attributes) && count($data->attributes) > 0) {

            $attribExpr = $qb->expr()->andX();
            foreach($data->attributes as $attribute) {
                $exprSingleAttrib = $qb->expr()->orX();
                foreach($attribute->valueIds as $valueId) {
                    $exprSingleAttrib->add($qb->expr()->like('s.attributeValues', "'%#" . $valueId . "#%'"));
                }
                $attribExpr->add($exprSingleAttrib);
            }
            $qb->andWhere($attribExpr);
        }

        if (isset($data->lookups) && count($data->lookups) > 0) {

            $attribExpr = $qb->expr()->andX();
            foreach($data->lookups as $lookup) {
                $exprSingleAttrib = $qb->expr()->orX();
                foreach($lookup->lookupIds as $lookupId) {
                    $exprSingleAttrib->add($qb->expr()->like('s.lookups', "'%#" . $lookupId . "#%'"));
                }
                $attribExpr->add($exprSingleAttrib);
            }
            $qb->andWhere($attribExpr);
        }

        // echo $qb->getDql(); die();
        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        $result = $qb->getQuery()->getResult();
        $products = array();
        foreach ($result as $r)
            array_push($products, $r->getProduct());

        return $products;
    }

    public function searchProductTwo($catIds) {
        $dql = "SELECT p, l FROM Product p JOIN p.lookups l WHERE p.lookups IN (:catIds) AND p.status = 'ACTIVE'";
        $query = getEntityManager()->createQuery($dql)->setParameter('catIds', $catIds);
        $result = $query->execute();
        return $result;

    }

    public function searchBandProduct($id, $limit, $startIndex) {
        $dql = "SELECT p, l FROM Product p JOIN p.lookups l WHERE l.id = $id AND p.status = 'ACTIVE'";
        $query = getEntityManager()->createQuery($dql)
                                    ->setMaxResults($limit)
                                    ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function searchTypesProduct($id, $limit, $startIndex) {
        $dql = "SELECT p, l FROM Product p JOIN p.lookups l WHERE l.id = $id AND l.type = 'category' AND p.status = 'ACTIVE'";
        $query = getEntityManager()->createQuery($dql)
                                    ->setMaxResults($limit)
                                    ->setFirstResult($startIndex);
        return $query->getResult(); 
    }

    public function findById($id) {
        // return getEntityManager()->find('Product', $id);
        $dql = "SELECT p FROM Product p WHERE p.id = $id AND p.status = 'ACTIVE'";
        $query = getEntityManager()->createQuery($dql);
        return $query->getResult(); 
    }

    // not useing
    public function findFiltered($query, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('s')
            ->from('StockV2', 's')
            ->join('s.sku', 'sku')
            ->join('sku.product', 'prod')
            // ->orderBy('sku.code', 'ASC')
            ->addOrderBy('prod.title', 'ASC');

        if ($query != '') {

        global $productsRepository;
        global $skusRepository;

        if (RegexHelper::isSkuCode($query)) {
            $str = RegexHelper::parseSkuCode($query);
            $sku = $skusRepository->findByCode($str);
            if ($sku != null) {
                echo "h1";
                // $code = $sku->getCode();
                $code2 = $sku->getProduct()->getId();
                // $qb->where("sku.code = '$code'")
                //    $qb->andWhere("sku.product = '$code'");
            $product = $productsRepository->findById($code2);
            if ($product == null) {
                echo "hello";
            }
                // echo $code2;

                $qb->andWhere("prod.id = '$code2'");

                // return $product;
            } else {
                return array();
            }
        } else if (RegexHelper::isProductCode($query)) {
            echo "h2";
            $str = RegexHelper::parseSkuCode($query);
            $product = $productsRepository->findOneByCode($str);
            // $product = $em1->find('Product', array('code' => $query));

            if ($product != null) {
                // $skuCodes = array();
                // foreach($product->getSkus() as $sku) {
                // array_push($skuCodes, $sku->getCode());
                // }
                // if (count($skuCodes) > 0) {
                //     $qb->andWhere('sku.code in (:skuCodes)')
                //         ->setParameter('skuCodes', $skuCodes);
                // }
                return $product;
            } else {
                return array();
            }
        } else {
            echo "h3";
            $products = $productsRepository->findByTitle($query);
            if (count($products) > 0) {
                $skuCodes = array();
                foreach ($products as $product) {
                    // foreach($product->getSkus() as $sku) {
                    // array_push($skuCodes, $sku->getCode());
                    // }
                return $product;

                }

                // if (count($skuCodes) > 0) {
                // $qb->andWhere('sku.code in (:skuCodes)')
                //     ->setParameter('skuCodes', $skuCodes);
                // } else {
                // return array();
                // }
            } else {
                return array();
            }
        }
        }

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    // not useing
    public function findFilteredV2($query, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('p')
            ->from('Product', 'p')
            ->where("p.status = 'ACTIVE'")
            ->addOrderBy('p.title', 'ASC');

        if ($query != '') {

            global $productsRepository;
            global $skusRepository;

            if (RegexHelper::isSkuCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $sku = $skusRepository->findByCode($str);
                if ($sku != null) {
                    $code2 = $sku->getProduct()->getId();
                    $qb->andWhere("p.id = '$code2'");
                } else {
                    return array();
                }
            } else if (RegexHelper::isProductCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $product = $productsRepository->findOneByCode($str);

                if ($product != null) {
                    $prodCode = $product->getCode();
                    $qb->andWhere("p.code = '$prodCode'");
                } else {
                    return array();
                }
            } else {
                $products = $productsRepository->findByTitle($query);
                if (count($products) > 0) {
                    foreach ($products as $product) {
                        $prodTitle = $product->getTitle();
                        $qb->andWhere("p.title = '$prodTitle'");
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

    public function findFilteredV3($query, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('p')
            ->from('Product', 'p')
            ->where("p.status = 'ACTIVE'")
            ->addOrderBy('p.title', 'ASC');

        if ($query != '') {

            global $productsRepository;
            global $skusRepository;

            if (RegexHelper::isSkuCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $sku = $skusRepository->findByCode($str);
                if (count($sku) > 0) {
                // if ($sku != null) {
                    $code2 = $sku[0]->getProduct()->getId();
                    $qb->andWhere("p.id = '$code2'");
                } else {
                    return array();
                }
            } else if (RegexHelper::isProductCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $product = $productsRepository->findOneByCode($str);

                if (count($product) > 0) {
                    $prodCodes = $product[0]->getCode();
                    $qb->andWhere('p.code in (:prodCodes)')
                        ->setParameter('prodCodes', $prodCodes);
                } else {
                    return array();
                }
            } else {
                $products = $productsRepository->findByTitle($query);
                if (count($products) > 0) {
                    $prodTitles = array();
                    foreach ($products as $product) {

                        array_push($prodTitles, $product->getTitle());

                    } if (count($prodTitles) > 0) {
                    $qb->andWhere('p.title in (:prodTitles)')
                            ->setParameter('prodTitles', $prodTitles);
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

    public function findFilteredInactive($query, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('p')
            ->from('Product', 'p')
            ->where("p.status = 'INACTIVE'")
            ->addOrderBy('p.title', 'ASC');

        if ($query != '') {

            global $productsRepository;
            global $skusRepository;

            if (RegexHelper::isSkuCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $sku = $skusRepository->findByCode($str);
                if (count($sku) > 0) {
                // if ($sku != null) {
                        $code2 = $sku[0]->getProduct()->getId();
                    $qb->andWhere("p.id = '$code2'");
                } else {
                    return array();
                }
            } else if (RegexHelper::isProductCode($query)) {
                $str = RegexHelper::parseSkuCode($query);
                $product = $productsRepository->findOneByCode($str);

                if (count($product) > 0) {
                    $prodCodes = $product[0]->getCode();
                    $qb->andWhere('p.code in (:prodCodes)')
                        ->setParameter('prodCodes', $prodCodes);
                } else {
                    return array();
                }
            } else {
                $products = $productsRepository->findByTitle($query);
                if (count($products) > 0) {
                    $prodTitles = array();
                    foreach ($products as $product) {

                        array_push($prodTitles, $product->getTitle());

                    } if (count($prodTitles) > 0) {
                    $qb->andWhere('p.title in (:prodTitles)')
                            ->setParameter('prodTitles', $prodTitles);
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

    public function deleteProductStat($id) {
        // $dql = "DELETE StockV2 s WHERE s.id = $id";
        $dql = "DELETE FROM ProductStat p WHERE p.sku = '$id'";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }
}

$productsRepository = $em->getRepository('Product');