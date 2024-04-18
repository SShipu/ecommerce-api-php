<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/InvoicesRepository.php';

cors();

requiresAuth();

$startDate = date('Y-m-d', strtotime('-30 days'));
$endDate = date('Y-m-d');
$branchId = -1;

if (hasRole('ADMIN')) {
    if (isset($_GET['branch']))
        $branchId = ($_GET['branch']);
} else {
    $branchId = $currentUser->getBranches()[0]->getId();
}

$result = $invoicesRepository->aggregateDateWise($branchId, $startDate, $endDate);

sendJsonResponse(200, $result);