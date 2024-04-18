<?php

use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Doctrine\DBAL\Exception\ConstraintViolationException;

class ItemAttributesRepository extends EntityRepository {
  
    public function save($data) {
        $em1 = getEntityManager();
        
        $itemAttri = new ItemAttribute();
        $itemAttri->setName($data->name);
        $itemAttri->setSeq($data->order);

        if (isset($data->lapse)) {
            if ($data->lapse != null && $data->lapse == "true") {
                $itemAttri->setLapse(true);
            } else {
                $itemAttri->setLapse(false);
            }
        } else {
            $itemAttri->setLapse(false);
        }
        $em1->persist($itemAttri);
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
        return $itemAttri->getId();
    }

    public function update($data) {
        $em1 = getEntityManager();
        $itemAttri = $em1->find('ItemAttribute', $data->id);

        if ($itemAttri != null) {
            $itemAttri->setName($data->name);
            if (isset($data->order)) {
                $itemAttri->setSeq($data->order);
            }
            if (isset($data->lapse)) {
                if ($data->lapse != null && $data->lapse == "true") {
                    $itemAttri->setLapse(true);
                } else {
                    $itemAttri->setLapse(false);
                }
            } else {
                $itemAttri->setLapse(false);
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

    public function findAllPaginated($limit, $startIndex) {
        $dql = "SELECT i FROM ItemAttribute i ORDER BY i.seq ASC";

        $query = getEntityManager()->createQuery($dql)
                                  ->setMaxResults($limit)
                                  ->setFirstResult($startIndex);
        return $query->getResult();
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

    public function findOne($id) {
        return $this->findOneBy(array('id' => $id));
    }



    public function delete($id) {

        $em1 = getEntityManager();

        $attribute = $em1->find('ItemAttribute', $id);
        if ($attribute != null) {
            $em1->remove($attribute);
            try {
                $em1->flush();
            } catch(ConstraintViolationException $ex) {
                throw new ExpectationFailedException();
            } 
        }
    }

    // public function deleteWithClildren($id) {
    //     $sql1 = "DELETE FROM item_attribute_values WHERE attribute_id = $id";
    //     $stmt1 = getEntityManager()->getConnection()->prepare($sql1);
    //     $stmt1->executeQuery();
    //     getEntityManager()->flush();

    //     $sql = "DELETE FROM item_attributes WHERE id = $id";
    //     $stmt = getEntityManager()->getConnection()->prepare($sql);
    //     $stmt->executeQuery();
    //     getEntityManager()->flush();
    // }


}

$itemAttributesRepository = $em->getRepository('ItemAttribute');