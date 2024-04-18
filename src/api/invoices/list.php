<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/InvoicesRepository.php';
cors();

requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER', 'SHOWROOM_SALES'));

list($limit, $offset, $startIndex) = getPaginationParams();

$startDate = null;
$endDate = null;
$branchId = -1;
$deliveryStatus = null;
$paymentStatus = null;
$type = null;
$source = null;

if (hasRole('ADMIN')) {
    if (isset($_GET['branchId']))
        $branchId = ($_GET['branchId']);
} else {
    $branchId = $currentUser->getBranches()[0]->getId();
}

if (isset($_GET['deliveryStatus']))
    $deliveryStatus = $_GET['deliveryStatus'];

if (isset($_GET['paymentStatus']))
    $paymentStatus = $_GET['paymentStatus'];

if (isset($_GET['type']))
    $type = $_GET['type'];

if (isset($_GET['startDate']))
    $startDate = $_GET['startDate'];

if (isset($_GET['endDate']))
    $endDate = $_GET['endDate'];

if (isset($_GET['source']))
    $source = $_GET['source'];

$list = $invoicesRepository->listInvoice($branchId, $source, $deliveryStatus, $paymentStatus, $type, $startDate, $endDate, $limit, $startIndex);

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;
sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));