<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/MfgOrdersRepository.php';
require_once __DIR__ . '/../../../repositories/MfgOrderSetsRepository.php';


cors();

requiresRoleAnyOf(array('ADMIN'));
$data = getJsonBody();

$id = $mfgOrdersRepository->save($data, $currentUser->getId());
$res = array('id' => $id, 'errors' => array());
sendJsonResponse(201, $res);