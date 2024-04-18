<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
cors();

requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();

$code = $skusRepository->save($data);
$res = array('code' => $code, 'errors' => array());
sendJsonResponse(201, $res);