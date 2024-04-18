<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/InvoicesRepository.php';
require_once __DIR__ . '/../../repositories/BranchesRepository.php';

cors();

requiresRoleAnyOf(array('ADMIN'));

list($limit, $offset, $startIndex) = getPaginationParams();

$startDate = null;
$endDate = null;
$deliveryStatus = null;
$paymentStatus = null;
$orderStatus = null;
$contactNo = null;

// if (hasRole('ADMIN')) {
//     if (isset($_GET['branchId']))
//         $branchId = ($_GET['branchId']);
// } else {
$branchId = $branchesRepository->findEcommerceBranch()[0]->getId();
// }

if (isset($_GET['deliveryStatus']))
    $deliveryStatus = $_GET['deliveryStatus'];

if (isset($_GET['paymentStatus']))
    $paymentStatus = $_GET['paymentStatus'];

if (isset($_GET['orderStatus']))
    $orderStatus = $_GET['orderStatus'];
    
if (isset($_GET['startDate']))
    $startDate = $_GET['startDate'];

if (isset($_GET['endDate']))
    $endDate = $_GET['endDate'];

if (isset($_GET['contactNo']))
    $contactNo = $_GET['contactNo'];
    
// echo $contactNo;die();
$list = $invoicesRepository->listEcommerceInvoice($branchId, $deliveryStatus, $paymentStatus, $orderStatus, $contactNo, $startDate, $endDate, $limit, $startIndex);

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;
sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));