<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/SKUsRepository.php';

cors();
requiresRoleAnyOf(array('ADMIN'));

$datas = getJsonBody();

$codes = $skusRepository->batchSave($datas);
$res = array('codes' => $codes, 'errors' => array());
sendJsonResponse(201, $res);