<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Doctrine\DBAL\Exception\ConstraintViolationException;

class BranchesRepository extends EntityRepository {

    function save($data) {
        $em1 = getEntityManager();
        $branch = new Branch();
        $branch->setBranchName($data->branchName);
        $branch->setBranchAddress($data->branchAddress);
        $branch->setCity($data->city);
        $branch->setPostalCode($data->postalCode);
        $branch->setMapLongitude($data->longitude);
        $branch->setMapLatitude($data->latitude);
        $branch->setNote($data->note);
        $branch->setType($data->type);
        if (isset($data->commissionPercentage) && $data->commissionPercentage > 0) {
            $branch->setCommissionPercentage($data->commissionPercentage);
        }
        if (isset($data->isEcommerce) && $data->isEcommerce != null && $data->isEcommerce == "true") {
            $branch->setIsEcommerce(true);
        } else {
            $branch->setIsEcommerce(false);
        }
        $em1->persist($branch);
        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
        return $branch->getId();
    }

    function update($data) {
        $em1 = getEntityManager();
        $branch = $em1->find('Branch', $data->id);
        if ($branch != null) {
            $branch->setBranchName($data->branchName);
            $branch->setBranchAddress($data->branchAddress);
            $branch->setCity($data->city);
            $branch->setPostalCode($data->postalCode);
            $branch->setMapLongitude($data->longitude);
            $branch->setMapLatitude($data->latitude);
            $branch->setnote($data->note);
            $branch->setType($data->type);
            if (isset($data->isEcommerce) && $data->isEcommerce != null && $data->isEcommerce == "true") {
                $branch->setIsEcommerce(true);
            } else {
                $branch->setIsEcommerce(false);
            }
            $em1->persist($branch);
            try {
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                throw new ConflictException();
            }
        } else {
            throw new NotFoundException();
        }
        return $branch->getId();
    }

    function findAllPaginated($limit, $offset) {
        $dql = "SELECT b FROM Branch b ORDER BY b.branchName ASC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($offset);
        return $query->getResult();
    }

    function findEcommerceBranch() {
        $dql = "SELECT b FROM Branch b WHERE b.isEcommerce = 1";
        $query = getEntityManager()->createQuery($dql)
                                    ->setMaxResults(1);
        return $query->getResult();
    }

    function findOne($id) {
        return $this->findOneBy(array('id' => $id));
    }

    public function delete($id) {
        $em1 = getEntityManager();
        $branch = $em1->find('Branch', $id);
        if ($branch != null) {
            $em1->remove($branch);
            try {
                $em1->flush();
            } catch(ConstraintViolationException $ex) {
                throw new ExpectationFailedException();
            } 
        }
    }


}

$branchesRepository = $em->getRepository('Branch');