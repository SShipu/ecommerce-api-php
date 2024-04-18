<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class LookupsRepository extends EntityRepository {

    public function save($data) {
        $em1 = getEntityManager();

        $lookup = new Lookup();
        $lookup->setType($data->type);
        $lookup->setName($data->name);
        $lookup->setImageUrl($data->imageUrl);
        $lookup->setStatus("ACTIVE");
        $lookup->setSeq($data->seq);
        $lookup->setCount(0);
        $parent = $em1->find('Lookup', $data->parentId);
        $lookup->setParent($parent);
        $em1->persist($lookup);

        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
        return $lookup->getId();
    }

    public function update($data) {

        $em1 = getEntityManager();
        $lookup = $em1->find('Lookup', $data->id);

        if ($lookup != null) {
            $lookup->setType($data->type);
            $lookup->setName($data->name);
            $lookup->setImageUrl($data->imageUrl);
            $lookup->setSeq($data->seq);
            $parent = $em1->find('Lookup', $data->parentId);
            $lookup->setParent($parent);

            $em1->persist($lookup);

            try {
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                throw new ConflictException();
            }

        } else {
            throw new NotFoundException();
        }

    }

    // public function findAllByInactive($limit, $startIndex) {
        
    //         $dql = "SELECT l FROM Lookup l WHERE l.status = 'INACTIVE'";
    //         $query = getEntityManager()->createQuery($dql)
    //                                ->setMaxResults($limit)
    //                                ->setFirstResult($startIndex);
    //         return $query->getResult();
    // }

    public function findAllByInactive($type, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('l')
            ->from('Lookup', 'l')
            ->where("l.status = 'INACTIVE'")
            ->orderBy('l.name', 'ASC');

        if ($type != null) {
            $qb->andWhere("l.type = '$type'");
        }

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }
    public function findAllByType($type, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('l')
            ->from('Lookup', 'l')
            ->where("l.status = 'ACTIVE'")
            ->orderBy('l.name', 'ASC');

        if ($type != null) {
            $qb->andWhere("l.type = '$type'");
        }

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    public function findAllByParentId($parentId, $limit, $startIndex) {
        if ($parentId > -1) {
            $dql = "SELECT l FROM Lookup l JOIN l.parent p WHERE p.id = $parentId AND l.status = 'ACTIVE'";
            $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
            return $query->getResult();

        } else {
            $dql = "SELECT l FROM Lookup l WHERE l.parent is NULL AND l.status = 'ACTIVE'";
            $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
            return $query->getResult();
        }
    }

    public function findAllByTypeAndParentId($parentId, $type, $limit, $startIndex) {
        if ($parentId > -1) {
            $dql = "SELECT l FROM Lookup l WHERE l.parent = $parentId AND l.type = '$type' AND l.status = 'ACTIVE' ORDER BY l.name ASC";
            $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
            return $query->getResult();
        } else {
            $dql = "SELECT l FROM Lookup l WHERE l.parent is NULL AND l.type = '$type' AND l.status = 'ACTIVE' ORDER BY l.name ASC";
            $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
            return $query->getResult();
        }
    }

    public function findAllByTypeAndParentId2($id, $parentId, $type, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('l')
            ->from('Lookup', 'l')
            ->where("l.status = 'ACTIVE'")
            ->orderBy('l.name', 'ASC');
            
        if ($id != -1) {
            $qb->andWhere("l.id = $id");
        }
            
        if ($parentId != -1) {
            
            $qb->addSelect('p')
                ->join('l.parent', 'p')
                ->andWhere("p.id = $parentId");
        }
        // else {
        //     $qb->andWhere("l.parent = null");
        // }

        if ($type != null) {
            $qb->andWhere("l.type = '$type'");
        }

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    public function assignAttributes($lookupId, $attrIds) {
        $em1 = getEntityManager();
        $lookup = $em1->find('Lookup', $lookupId);
        if ($lookup != null) {
            $lookup->getAttributes()->clear();
            foreach ($attrIds as $attrId) {
                $attr = $em1->find('ItemAttribute', $attrId);
                if ($attr != null) {
                    $lookup->addAttribute($attr);
                }

            }
            $em1->persist($lookup);
            $em1->flush();
        }
    }

    public function incrementCounts($lookupIds) {

        foreach ($lookupIds as $id) {

            $sql = "UPDATE lookups SET count = count + 1 WHERE id = $id";
            $stmt = getEntityManager()->getConnection()->prepare($sql);
            $stmt->executeQuery();
        }
    }

    public function findById($id) {
        // return getEntityManager()->find('Lookup', $id);
        $dql = "SELECT l FROM Lookup l WHERE l.type = 'band' AND l.id = $id AND l.status = 'ACTIVE'";
        $query = getEntityManager()->createQuery($dql);
        return $query->getResult();
    }

    public function delete($id) {
        $dql = "DELETE Lookup l WHERE l.id = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

    public function setInactive($id) {
        // $dql = "DELETE Lookup l WHERE l.id = $id";
        $dql = "UPDATE Lookup l SET l.status = 'INACTIVE' WHERE l.id = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();

        // $sql = "UPDATE lookups SET status = 'INACTIVE' WHERE id = $id";
        // $stmt = getEntityManager()->getConnection()->prepare($sql);
        // return $stmt->executeQuery();
    }

    public function findByTitle($query, $limit, $startIndex) {
        $dql = "SELECT l FROM Lookup l WHERE l.type = 'band' AND LOWER(l.name) LIKE '$query%' AND l.status = 'ACTIVE' ORDER BY l.name ASC";
        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $query->getResult();
        // $query->setMaxResults(120);
        // return $query->getResult();
      }

    public function setActive($id) {
        $em1 = getEntityManager();
        $lookup = $em1->find('Lookup', $id);
        if ($lookup->getStatus() != 'INACTIVE') {
            throw new NotFoundException;
        }
        $dql = "UPDATE Lookup l SET l.status = 'ACTIVE' WHERE l.id = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

}

$lookupsRepository = $em->getRepository('Lookup');