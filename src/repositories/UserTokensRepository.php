<?php 
use Doctrine\ORM\EntityRepository;

class UserTokensRepository extends EntityRepository
{
    
    
    function save($userId) {

        $token = bin2hex(random_bytes(16));

        $em1 = getEntityManager();
        $userToken = new UserToken();
        $userToken->setUserId($userId);
        $userToken->setToken($token);
        $userToken->setCreatedTime(new DateTime());
        $em1->persist($userToken);
        $em1->flush();
        return $token;
    }

    function update($user) {
        $em1 = getEntityManager();
        $em1->flush();
        return $user->getId();
    }

    function findOne($token) {
        $dql = "SELECT u FROM UserToken u WHERE u.token = $token";

        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(120);
        return $query->getResult();
    }

    function delete($id) {
        $dql = "DELETE UserToken u WHERE u.id = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

    function getAuthentication($token, $usersRepository) {
        $userToken = $this->findOneBy(array('token' => $token));
        if ($userToken != null) {
            $user = $usersRepository->findOneBy(array('id' => $userToken->getUserId()));
            return $user;
        } else {
            return null;
        }
    }

}

$userTokensRepository = $em->getRepository('UserToken');