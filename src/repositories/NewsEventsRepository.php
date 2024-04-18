<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class NewsEventsRepository extends EntityRepository
{
    public function save($data) {
        $em1 = getEntityManager();
        $news = new NewsEvent();
        $news->setTitle($data->title);
        $news->setDate($data->date);
        $news->setType($data->type);
        $news->setDescription($data->description);
        $news->setCreatedTime(new \DateTime('now', new DateTimeZone('Asia/Dhaka')));
        
        foreach ($data->images as $image) {
            $image = $em1->find('OttomanFile', $image);
            if ($image != null) {
                $news->addImage($image);
            }
        }
        
        $em1->persist($news);
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
        return $news->getId();
    }

    public function update($data) {
        $em1 = getEntityManager();
        $oldNews = $em1->find('NewsEvent', $data->id);

        if ($oldNews != null) {
            $oldNews->setTitle($data->title);
            $oldNews->setDate($data->date);
            $oldNews->setType($data->type); 
            $oldNews->setDescription($data->description);

            $oldNews->getImages()->clear();
            if ($data->imageIds != null) {
                foreach ($data->imageIds as $image) {
                    $image = $em1->find('OttomanFile', $image);
                    if ($image != null) {
                        $oldNews->addImage($image);
                    }
                }
            }

            $em1->persist($oldNews);

            try {
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                throw new ConflictException();
            }
        } else {
            throw new NotFoundException();
        }
    }

    public function findAll() {
        
        $dql = "SELECT u FROM Role u ORDER BY u.userId ASC";

        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(120);
        return $query->getResult();
    }

    public function findAllPaginated($type, $limit, $startIndex) {
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select('n')
           ->from('NewsEvent', 'n')
           ->orderBy('n.createdTime', 'DESC');
        
        if ($type != "") {
            $qb->andWhere("n.type = '$type'");
        }

        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        $result = $qb->getQuery()->getResult();

        return $result;
    }

    // public function findAllPaginated($limit, $startIndex) {
    //     $dql = "SELECT n FROM NewsEvent n ORDER BY n.createdTime DESC";

    //     $query = getEntityManager()->createQuery($dql)
    //                                ->setMaxResults($limit)
    //                                ->setFirstResult($startIndex);
    //     return $query->getResult();
    // }

    public function findOne($id) {
        return $this->findOneBy(array('id' => $id));
    }

    public function delete($id) {
        $dql = "DELETE NewsEvent n WHERE n.id = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

}

$newsEventsRepository = $em->getRepository('NewsEvent');