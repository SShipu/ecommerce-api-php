<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/MfgOrdersV2Repository.php';
require_once __DIR__ . '/../../../repositories/ShipmentsV2Repository.php';

cors();

requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER'));

$data = getJsonBody();

if (hasRole('ADMIN')) {
    $branchId = -1;
} else {
    $branchId = $currentUser->getBranches()[0]->getId();
}

$shipmentsV2Repository->receivedShipment($data, $branchId, $currentUser->getId());
sendEmptyJsonResponse(202);