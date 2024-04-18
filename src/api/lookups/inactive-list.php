<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/LookupsRepository.php';

cors();

list($limit, $offset, $startIndex) = getPaginationParams();

// $id = -1;
// $parentId = -1;
$type = null;

// if (isset($_GET['id'])) {
//     $id = $_GET['id'];
// }

// if (isset($_GET['parentId'])) {
//     $parentId = $_GET['parentId'];
// }

if (isset($_GET['type'])) {
    $type = $_GET['type'];
}

$list = $lookupsRepository->findAllByInactive($type, $limit, $startIndex);

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));