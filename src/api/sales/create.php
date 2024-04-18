<?php
use Doctrine\DBAL\DBALException;
use Doctrine\ORM\Query\Expr\Math;

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../repositories/InvoicesRepository.php';
require_once __DIR__ . '/../../repositories/StocksV2Repository.php';

cors();
requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER', 'SHOWROOM_SALES'));

$data = getJsonBody();

$errors = array();
// echo "Sales Data";
// print_r($data);die();

if (hasRole('ADMIN')) {
    if (!isset($data->branchId)) {
        $error = array('field' => 'branchId', 'code' => 'missing');
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
    // if ($sku != null) {
    if (count($sku) > 0) {
        if (!$sku[0]->hasEnoughStock($skuData->quantity, $data->branchId)) {
            echo $skuData->quantity . ' ' . $skuData->code . ' ' . $data->branchId;
            $error = array('field' => 'skus', 'code' => 'not_enough_stock', 'value' => $skuData->code);
            array_push($errors, $error);
            break;
        } else if (!$sku[0]->isProperPrice($skuData->price)){
            $error = array('field' => 'skus', 'code' => 'wrong_price', 'value' => $skuData->code);
            array_push($errors, $error);
            break;
        }
        $total += $skuData->price * $skuData->quantity;
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

$netTotal = $total;
$discount = 0;
if (isset($data->discountType) && isset($data->discount) && $data->discount > 0) {
    if ($data->discountType == 'PERCENTAGE') {
        $discount = ($netTotal * $data->discount / 100.0);
        $discount = floor($discount);
        $netTotal -= $discount;
    } else if ($data->discountType == 'FIXED') {
        $discount = $data->discount;
        $netTotal -= $discount;
    }
}

$data->total = $total;
$data->netTotal = $netTotal;

if (isset($data->vatPercentage) && $data->vatPercentage > 0) {
    $vatPercentage = $data->vatPercentage / 100.0;


} else {
    $vatPercentage = 0;

}

$data->vatAmount = ceil($data->netTotal * $vatPercentage);
$data->grandTotal = $data->netTotal + $data->vatAmount;

$id = $invoicesRepository->createSalesInvoice($data, $skus, $currentUser->getId());

sendJsonResponse(201, array('id' => $id, 'error' => array()));