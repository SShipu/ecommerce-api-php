<?php
use Doctrine\ORM\EntityRepository;

class RolesRepository extends EntityRepository
{
    public function save($role)
    {
        $em1 = getEntityManager();
        $em1->persist($role);
        $em1->flush();
        return $role->getId();
    }

    public function update($role)
    {
        $em1 = getEntityManager();
        $em1->flush();
        return $role->getId();
    }

    public function findAll()
    {
        $dql = "SELECT u FROM Role u ORDER BY u.userId ASC";

        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(120);
        return $query->getResult();
    }

    public function findOne($id)
    {
        return $this->findOneBy(array('id' => $id));
    }

    public function delete($id)
    {
        $dql = "DELETE Role u WHERE u.id = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

}

$rolesRepository = $em->getRepository('Role');

// class RolesRepository extends EntityRepository
// {
//     function save($userId, $roles) {
//         $em1 = getEntityManager();
//         foreach($roles as $role) {
//             $userRole = new Role($userId, $role);
//             $em1->persist($role);
//             $em1->flush();

//         }
//     }

//     function update($role) {
//         $em1 = getEntityManager();
//         $em1->flush();
//         return $role->getId();
//     }

//     function findAll() {
//         $dql = "SELECT u FROM ROle u ORDER BY u.userId ASC";

//         $query = getEntityManager()->createQuery($dql);
//         $query->setMaxResults(120);
//         return $query->getResult();
//     }

//     function delete($id) {
//         $dql = "DELETE User u WHERE u.id = $id";
//         $query = getEntityManager()->createQuery($dql);
//         return $query->execute();
//     }

// }