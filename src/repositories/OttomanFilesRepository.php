<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class OttomanFilesRepository extends EntityRepository
{

    public function saveImage($image) {
        $em1 = getEntityManager();

        $em1->persist($image);
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            echo $ex->getMessage();die();
            throw new ConflictException();
        }
        return $image->getId();
    }

    public function findOne($token) {
        return $this->findOneBy(array('id' => $token));
    }

}

$ottomanFilesRepository = $em->getRepository('OttomanFile');