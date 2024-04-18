<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../helpers/RegexHelper.php';
cors();

list($limit, $offset, $startIndex) = getPaginationParams();

$id = -1;
if (isset($_GET['id'])) {
    $id = $_GET['id'];
}

// if ($query == '') {
  $list = $productsRepository->findTypesTopSales($id, $limit, $startIndex);
// } else {
//   $list = $productsRepository->findFilteredV3($query, $limit, $startIndex);
// }

$array = array();
foreach ($list as $item) {
  array_push($array, $item->getProduct());
}
$list = $array;
$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));