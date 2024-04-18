<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/MfgOrderSetsRepository.php';
require_once __DIR__ . '/../../../repositories/SKUsRepository.php';


cors();

requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();

$id = $mfgOrderSetsRepository->save($data);
$res = array('id' => $id, 'errors' => array());
sendJsonResponse(201, $res);