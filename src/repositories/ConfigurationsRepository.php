<?php

use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Doctrine\DBAL\Exception\ConstraintViolationException;

class ConfigurationsRepository extends EntityRepository {

    function save($data) {
        $em1 = getEntityManager();
        
        $cfg = $em1->find('Configuration', 1);
        if ($cfg == null)
            $cfg = new Configuration();

            
        $cfg->setId(1);
        
        if (isset($data->vatApplicable)) {
            if ($data->vatApplicable != null && $data->vatApplicable == "true") {
                $cfg->setVatApplicable(true);
            } else {
                $cfg->setVatApplicable(false);
            }
        } else {
            $cfg->setVatApplicable(false);
        }
        $cfg->setVatPercentage($data->vatPercentage);
        if (isset($data->stockThreshold)) {
            if ($data->stockThreshold > 0) {
                $cfg->setStockThreshold($data->stockThreshold);
            } else {
                $cfg->setStockThreshold(10);
            }
        } else {
            $cfg->setStockThreshold(10);
        }
        
        $em1->persist($cfg);
        
        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            echo $ex->getMessage();die();
            throw new ConflictException();
        }
        return $cfg->getId();
    }

    public function findAllPaginated($limit, $startIndex) {
        $dql = "SELECT c FROM Configuration c ORDER BY c.id ASC";

        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    // function update($data) {
    //     $em1 = getEntityManager();

    //     $branch = $em1->find('Branch', $data->id);

    //     if ($branch != null) {
    //         $branch->setBranchName($data->branchName);
    //         $branch->setBranchAddress($data->branchAddress);
    //         $branch->setnote($data->note);

    //         try {
    //             $em1->flush();
    //         } catch (UniqueConstraintViolationException $ex) {
    //             throw new ConflictException();
    //         }

    //     } else {
    //         throw new NotFoundException();
    //     }
    //     return $branch->getId();
    // }
}

$configurationsRepository = $em->getRepository('Configuration');