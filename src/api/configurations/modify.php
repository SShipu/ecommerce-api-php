<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ConfigurationsRepository.php';

cors();
requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();

$id = $configurationsRepository->save($data);
$res = array('id' => $id, 'errors' => array());
sendJsonResponse(201, $res);