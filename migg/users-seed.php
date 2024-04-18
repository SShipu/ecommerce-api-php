<?php

/* configuration */
require_once __DIR__ . '/../src/configs/config.php';
require_once __DIR__ . '/../src/framework/framework.php';
require_once __DIR__ . '/../src/repositories/UsersRepository.php';
require_once __DIR__ . '/../src/repositories/RolesRepository.php';
require_once __DIR__ . '/../src/validation/UserValidation.php';
cors();
$data = new stdClass();
$data->userName = 'admin';
$data->fullName = 'ADMIN';
$data->email = 'admin@hmt.com';
$data->password = "@dm!n-p@$$";
$data->status = 'ACTIVE';
$data->contactNo = "1";
$data->roleIds = array(2);
$data->branchIds = array();
validate($data);

$id = $usersRepository->save($data);

$res = array('id' => $id, 'errors' => array());
sendJsonResponse(201, $res);