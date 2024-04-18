<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/CustomersRepository.php';
require_once __DIR__ . '/../../repositories/RolesRepository.php';
// require_once __DIR__ . '/../../validation/CustomerValidation.php';

cors();
// requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();
// validate($data);

$id = $customersRepository->save($data);

$res = array('id' => $id, 'errors' => array());
sendJsonResponse(201, $res);