<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class ContactUsRepository extends EntityRepository {

    public function save($data) {

        $em1 = getEntityManager();

        $user = new ContactUs();
        $user->setName($data->name);
        $user->setEmail($data->email);
        $user->setContactNo($data->contactNo);
        $user->setAddress($data->address);
        $user->setMessage($data->message);
        $user->setCreatedTime(new \DateTime('now', new DateTimeZone('Asia/Dhaka')));

        $em1->persist($user);

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }

        return $user->getId();
    }


    public function update($data) {

        $em1 = getEntityManager();
        $oldUser = $em1->find('User', $data->id);

        if ($oldUser != null) {
            $oldUser->setFullName($data->fullName);
            $oldUser->setUserName($data->userName);
            $oldUser->setEmail($data->email);
            // $oldUser->setPassword($data->password);
            $oldUser->setStatus($data->status);
            $oldUser->setContactNo($data->contactNo);

            $oldUser->getRoles()->clear();
            foreach ($data->roleIds as $roleId) {
                $role = $em1->find('Role', $roleId);
                if ($role != null) {
                    $oldUser->addRole($role);
                }
            }

            $oldUser->getBranches()->clear();
            foreach ($data->branchIds as $branchId) {
                $branch = $em1->find('Branch', $branchId);
                if ($branch != null) {
                    $oldUser->addBranch($branch);
                }
            }

            $em1->persist($oldUser);

            try {
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                throw new ConflictException();
            }
        } else {
            throw new NotFoundException();
        }
    }

    public function findActiveUserByUserName($userName) {
        $dql = "SELECT u, r FROM User u INNER JOIN u.roles r WHERE u.userName = '$userName' AND u.status = 'ACTIVE'";
        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(1);
        return $query->getOneOrNullResult();
    }

    public function findActiveUserById($id) {
        $dql = "SELECT u FROM User u WHERE u.id = $id";
        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(1);
        return $query->getSingleResult();
    }

    public function changePassword($data, $id) {
        $em2 = getEntityManager();
        $user = $em2->find('User', $id);
        if ($user != null) {
            if (password_verify($data->currentPassword, $user->getPassword())) {
                $options = [
                    'cost' => 12,
                ];
                $passwordHash = password_hash($data->newPassword, PASSWORD_BCRYPT, $options);
                $user->setPassword($passwordHash);
                $em2->persist($user);
            } else {
                throw new ExpectationFailedException();
            }
            try {
                $em2->flush();
            } catch (UniqueConstraintViolationException $ex) {
                throw new ConflictException();
            }
        } else {
            throw new NotFoundException();
        }
    }

    public function resetPassword($data) {
        $em1 = getEntityManager();
        $user = $em1->find('User', $data->id);
        if ($user != null) {
            $options = [
                    'cost' => 12,
                ];
            $passwordHash = password_hash($data->password, PASSWORD_BCRYPT, $options);
            $user->setPassword($passwordHash);
            $em1->persist($user);
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
        $dql = "SELECT c FROM ContactUs c ORDER BY c.createdTime DESC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function delete($id) {
        $dql = "DELETE User u WHERE u.id = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }
}

$contactUsRepository = $em->getRepository('ContactUs');