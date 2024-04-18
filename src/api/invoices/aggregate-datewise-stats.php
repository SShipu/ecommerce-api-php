<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/InvoicesRepository.php';

cors();

requiresAuth();

$startDate = null;
$endDate = null;
$branchId = -1;
// $sku = null;
$prodId = null;
// $color = null;
// $size = null;
// $source = null;

if (hasRole('ADMIN')) {
    if (isset($_GET['branchId']))
        $branchId = ($_GET['branchId']);
} else {
    $branchId = $currentUser->getBranches()[0]->getId();
}
// if (isset($_GET['sku']))
//         $sku = ($_GET['sku']);

if (isset($_GET['productId']))
        $prodId = ($_GET['productId']);

// if (isset($_GET['color']))
//         $prodId = ($_GET['color']);

// if (isset($_GET['size']))
//         $prodId = ($_GET['size']);

if (isset($_GET['startDate']))
    $startDate = $_GET['startDate'];

if (isset($_GET['endDate']))
    $endDate = $_GET['endDate'];

$result = $invoicesRepository->aggregateDateWiseForStats($branchId, $prodId, $startDate, $endDate);

sendJsonResponse(200, $result);