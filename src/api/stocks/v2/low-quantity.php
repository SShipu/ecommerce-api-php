<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../repositories/StocksV2Repository.php';
require_once __DIR__ . '/../../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../../helpers/RegexHelper.php';
cors();

list($limit, $offset, $startIndex) = getPaginationParams();

$branchId = -1;
if (isset($_GET['branchId'])) {
    $branchId = $_GET['branchId'];
}

$query = '';
if (isset($_GET['query'])) {
    $query = $_GET['query'];
}

if ($query == '' && $branchId == -1) {
    $list = $stocksV2Repository->findLowQuantityPaginated($limit, $startIndex);
} else {
    $list = $stocksV2Repository->findFilteredLowQuantity($query, $branchId, $limit, $startIndex);
}

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));