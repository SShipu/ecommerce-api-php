<?php

use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Doctrine\DBAL\Exception\ConstraintViolationException;

class ProductBundlesRepository extends EntityRepository {
  
    public function save($data) {
        $em1 = getEntityManager();
        // print_r($data);die();
        $prodBundle = new ProductBundle();
        $prodBundle->setName($data->name);
        $prodBundle->setPrice($data->price);
        $prodBundle->setDiscountPrice($data->discountPrice);

        $discountPercentage = ($data->discountPrice / $data->price) * 100;

        $prodBundle->setDiscountPercentage($discountPercentage);

        if (isset($data->special)) {
            if ($data->special != null && $data->special == true) {
                $prodBundle->setSpecial(true);
            } else {
                $prodBundle->setSpecial(false);
            }
        } else {
            $prodBundle->setSpecial(false);
        }
        
        if (isset($data->productIds)) {
            foreach ($data->productIds as $product) {
                $prod = $em1->find('Product', $product);
                if ($prod != null) {
                    $prodBundle->addProduct($prod);
                }
            }
        }
        
        if (isset($data->imageIds)) {
            foreach ($data->imageIds as $image) {
                $image = $em1->find('OttomanFile', $image);
                if ($image != null) {
                    $prodBundle->addImage($image);
                }
            }
        }

        $em1->persist($prodBundle);
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
        return $prodBundle->getId();
    }

    public function update($data) {
        $em1 = getEntityManager();
        $prodBundle = $em1->find('ProductBundle', $data->id);

        if ($prodBundle != null) {
            $prodBundle->setName($data->name);
            $prodBundle->setPrice($data->price);
            $prodBundle->setDiscountPrice($data->discountPrice);

            $discountPercentage = ($data->discountPrice / $data->price) * 100;

            $prodBundle->setDiscountPercentage($discountPercentage);

            if (isset($data->special)) {
                if ($data->special != null && $data->special == true) {
                    $prodBundle->setSpecial(true);
                } else {
                    $prodBundle->setSpecial(false);
                }
            } else {
                $prodBundle->setSpecial(false);
            }
            $prodBundle->getProducts()->clear();
            if (isset($data->productIds)) {
                foreach ($data->productIds as $product) {
                    $prod = $em1->find('Product', $product);
                    if ($prod != null) {
                        $prodBundle->addProduct($prod);
                    }
                }
            }
            
            $prodBundle->getImages()->clear();
            if (isset($data->imageIds)) {
                foreach ($data->imageIds as $image) {
                    $image = $em1->find('OttomanFile', $image);
                    if ($image != null) {
                        $prodBundle->addImage($image);
                    }
                }
            }

            try {
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                throw new ConflictException();
            }

        } else {
            throw new NotFoundException();
        }
    }

    public function findAllPaginated($special, $limit, $startIndex) {
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select('p')
           ->from('ProductBundle', 'p')
           ->orderBy('p.id', 'ASC');
        
        if ($special != -1) {
            $qb->andWhere("p.special = $special");
        }

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        $result = $qb->getQuery()->getResult();

        return $result;
    }

    public function findAllByNameId($id, $name, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('i')
            ->from('ItemAttribute', 'i')
            ->where("i.lapse = 1")
            ->orderBy('i.seq', 'ASC');
            
        if ($id != -1) {
            $qb->andWhere("i.id = $id");
        }

        if ($name != null) {
            $qb->andWhere("i.name = '$name'");
        }

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    public function findDefaults($limit, $startIndex) {
        $dql = "SELECT i FROM ItemAttribute i  WHERE i.lapse=1 ORDER BY i.seq ASC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findById($id) {
        return getEntityManager()->find('ProductBundle', $id);
    }

    public function findOne($id) {
        return $this->findOneBy(array('id' => $id));
    }
    
    public function delete($id) {

        $em1 = getEntityManager();

        $attribute = $em1->find('ProductBundle', $id);
        if ($attribute != null) {
            $em1->remove($attribute);
            try {
                $em1->flush();
            } catch(ConstraintViolationException $ex) {
                throw new ExpectationFailedException();
            } 
        }
    }
}

$productBundlesRepository = $em->getRepository('ProductBundle');