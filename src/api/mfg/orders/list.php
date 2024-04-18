<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/MfgOrdersRepository.php';
cors();


requiresRoleAnyOf(array('ADMIN', 'DISTRIBUTION_MANAGER'));

$branchId = -1;
$status = null;

if (isset($_GET['status']))
    $status = $_GET['status'];
    
if (hasRole('ADMIN')) {
    if (isset($_GET['branchId']))
        $branchId = ($_GET['branchId']);
} else if (hasRole('DISTRIBUTION_MANAGER')) {
    $branchId = $currentUser->getBranches()[0]->getId();
    // echo $branchId;die();
}

list($limit, $offset, $startIndex) = getPaginationParams();

// $list = $mfgOrdersRepository->findAllPaginated($branchId, $limit, $startIndex);
$list = $mfgOrdersRepository->listMfgOrder($branchId, $status, $limit, $startIndex);

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));