<?php
use Doctrine\DBAL\DBALException;
/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/StocksV2Repository.php';
cors();

requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER'));
$data = getJsonBody();

// $branchId = -1;

if (hasRole('ADMIN')) {
    $branchId = $data->branchId;
} else {
    $branchId = $currentUser->getBranches()[0]->getId();
}

$stocksV2Repository->returnStockFromSalesBooked($data, $branchId);
sendEmptyJsonResponse(202);