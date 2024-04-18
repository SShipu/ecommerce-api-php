<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/ItemAttributesRepository.php';
cors();

list($limit, $offset, $startIndex) = getPaginationParams();

$id = -1;
$name = null;

if (isset($_GET['id'])) {
    $id = $_GET['id'];
}

if (isset($_GET['name'])) {
    $name = $_GET['name'];
}

if ($id != -1 || $name != null) {
    $list = $itemAttributesRepository->findAllByNameId($id, $name, $limit, $startIndex);
} else {
    $list = $itemAttributesRepository->findAllPaginated($limit, $startIndex);
}


$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));