<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/UsersRepository.php';
require_once __DIR__ . '/../../repositories/RolesRepository.php';

cors();
requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();
// print_r($data);die();
if (isset($data->userName)) {

    $user = $usersRepository->findActiveUserByUserName($data->userName);
    // $role = $rolesRepository->findOne($id);
    // print_r($user);die();
    // echo $data->password . " - " . $user->getPassword();die();
    if ($user != null) {
        if ($user->getUserName() == 'admin') {
        // echo "True";die();
            if (password_verify($data->password, $user->getPassword())) {
                // echo "True";die();

                $rolesArray = array();
                foreach ($user->getRoles() as $role) {
                    array_push($rolesArray, $role->jsonSerialize());
                }

                $branchesArray = array();
                foreach ($user->getBranches() as $branch) {
                    array_push($branchesArray, $branch->jsonSerialize());
                }

                $res = array(
                    'userName' => $user->getUserName(),
                    'branch' => $branchesArray,
                    'roles' => $rolesArray,
                    'response' => "true",
                );

                sendJsonResponse(200, $res);

            } else {
                sendEmptyJsonResponse(401);
            }
        } else 
            throw new UnauthorizedException();
    } else {
        sendEmptyJsonResponse(401);
    }
}