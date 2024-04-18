<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../repositories/ShipmentsRepository.php';
// require_once __DIR__ . '/../../repositories/StocksRepository.php';
require_once __DIR__ . '/../../repositories/StocksV2Repository.php';

cors();
requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER'));

$data = getJsonBody();
$errors = array();

if (hasRole('ADMIN')) {
    $branchId = $data->destinationId;
} else {
    $branchId = $currentUser->getBranches()[0]->getId();
}

$shipmentsRepository->receivedShipment($data, $branchId);
sendEmptyJsonResponse(202);