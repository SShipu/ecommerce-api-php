<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../repositories/ShipmentsRepository.php';
require_once __DIR__ . '/../../repositories/StocksV2Repository.php';


cors();

requiresRoleAnyOf(array('ADMIN', 'DISTRIBUTION_MANAGER'));

$data = getJsonBody();


$errors = array();

if (hasRole('ADMIN')) {
    if (!isset($data->sourceId)) {
        $error = array('field' => 'sourceId', 'code' => 'missing');
        array_push($errors, $error);
        sendJsonResponse(412, array('errors' => $errors));
        die();
    }
} else {
    $data->branchId = $currentUser->getBranches()[0]->getId();
}


$total = 0;
$skus = array();

foreach ($data->skus as $skuData) {
    $sku = $skusRepository->findByCode($skuData->code);
    if (count($sku) > 0) {
        if (!$sku[0]->hasEnoughStock($skuData->quantity, $data->branchId)) {
            $error = array('field' => 'skus', 'code' => 'not_enough_stock', 'value' => $skuData->code);
            array_push($errors, $error);
            break;
        } 
        array_push($skus, $sku);
    } else {
          $error = array('field' => 'skus', 'code' => 'not_found', 'value' => $skuData->code);
          array_push($errors, $error);
          break;
    }
}
if (count($errors) > 0) {
    sendJsonResponse(412, array('errors' => $errors));
    die();
}

$id = $shipmentsRepository->createShipment($data);

sendJsonResponse(201, array('id' => $id, 'error' => array()));