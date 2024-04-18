<?php
/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../repositories/LookupsRepository.php';
cors();
$data = getJsonBody();
list($limit, $offset, $startIndex) = getPaginationParams();

$data = getJsonBody();
// print_r($data);die();
// $endDate = null;
// if (isset($_GET['startDate']))
//     $startDate = $_GET['startDate'];

$list = $lookupsRepository->findByTitle($data->query, $limit, $startIndex);

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));