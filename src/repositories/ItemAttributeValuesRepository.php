<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Doctrine\DBAL\Exception\ConstraintViolationException;

class ItemAttributeValuesRepository extends EntityRepository {
    
    public function save($data) {
        $em1 = getEntityManager();
        $itmAttVal = new ItemAttributeValue();
        $itmAttVal->setValue($data->value);
        $itmAttVal->setExtra($data->extra);
        $itmAttVal->setSeq($data->order);
        
        $attr = $em1->find('ItemAttribute', $data->attrId);
        if ($attr != null) {
            $itmAttVal->setAttribute($attr);
        }
        $em1->persist($itmAttVal);
        
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
        
        return $itmAttVal->getId();
    }

    public function update($data) {
        $em1 = getEntityManager();
        $itmAttVal = $em1->find('ItemAttributeValue', $data->id);
        if ($itmAttVal != null) {
            $itmAttVal->setValue($data->value);
            $itmAttVal->setExtra($data->extra);

            if (isset($data->order)) {
                $itmAttVal->setSeq($data->order);
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
        $dql = "SELECT i FROM ItemAttributeValue i ORDER BY i.seq ASC";
        $query = getEntityManager()->createQuery($dql)
                                    ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findAttributeID($id) {
        $dql = "SELECT i FROM ItemAttribute i where i.id = $id";
        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(120);
        return $query->getResult();
    }

    public function findOne($id) {
        return $this->findOneBy(array('id' => $id));
    }

    public function delete($id) {
        $em1 = getEntityManager();
        $attributeValue = $em1->find('ItemAttributeValue', $id);
        if ($attributeValue != null) {
            $em1->remove($attributeValue);
            try {
                $em1->flush();
            } catch(ConstraintViolationException $ex) {
                throw new ExpectationFailedException();
            } 
        }
    }
}

$itemAttributeValuesRepository = $em->getRepository('ItemAttributeValue');