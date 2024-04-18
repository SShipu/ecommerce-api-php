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

if (hasRole('ADMIN')) {
    if (isset($_GET['branch']))
        $branchId = $_GET['branch'];
} else {
    $branchId = $currentUser->getBranches()[0]->getId();
}

if (isset($_GET['startDate']))
    $startDate = $_GET['startDate'];

if (isset($_GET['endDate']))
    $endDate = $_GET['endDate'];


$result = $invoicesRepository->aggregateTotal($branchId, $startDate, $endDate);

sendJsonResponse(200, $result);