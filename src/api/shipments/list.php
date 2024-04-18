<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ShipmentsRepository.php';
cors();

$data = getJsonBody();

requiresRoleAnyOf(array('ADMIN', 'DISTRIBUTION_MANAGER', 'SHOWROOM_MANAGER'));

list($limit, $offset, $startIndex) = getPaginationParams();

$startDate = null;
$endDate = null;
$id = null;
$sourceId = -1;
$destinationId = -1;
$status = null;

if (hasRole('ADMIN')) {
    if (isset($_GET['sourceId']))
        $sourceId = ($_GET['sourceId']);

    if (isset($_GET['destinationId']))
    $destinationId = ($_GET['destinationId']);

} else if (hasRole('DISTRIBUTION_MANAGER')) {
    $sourceId = $currentUser->getBranches()[0]->getId();
} else {
    $destinationId = $currentUser->getBranches()[0]->getId();
}

if (isset($_GET['startDate']))
    $startDate = $_GET['startDate'];

if (isset($_GET['endDate']))
    $endDate = $_GET['endDate'];

// if (isset($_GET['id']))
//     $id = $_GET['id'];

if (isset($_GET['status']))
  $status = $_GET['status'];

$list = $shipmentsRepository->listShipmentV2($sourceId, $destinationId, $status, $startDate, $endDate, $limit, $startIndex);

// $list = $shipmentsRepository->listShipment($sourceId, $destinationId, $id, $startDate, $endDate, $limit, $startIndex);

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));
