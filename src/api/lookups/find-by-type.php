<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/LookupsRepository.php';

cors();

list($limit, $offset, $startIndex) = getPaginationParams();

$type = null;


if (isset($_GET['type'])) {
    $type = $_GET['type'];
}

$list = $lookupsRepository->findAllByType($type, $limit, $startIndex);

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));