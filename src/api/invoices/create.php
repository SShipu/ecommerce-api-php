<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/InvoicesRepository.php';

cors();

// requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();

$userId = $currentUser->getId();

$code = $invoicesRepository->save($data, $userId);
$res = array('code' => $code, 'errors' => array());
sendEmptyJsonResponse(201, $res);