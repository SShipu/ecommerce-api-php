<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../repositories/ProductBundlesRepository.php';
// require_once __DIR__ . '/../../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../../helpers/RegexHelper.php';
cors();

list($limit, $offset, $startIndex) = getPaginationParams();

$special = -1;
if (isset($_GET['special'])) {
    $special = $_GET['special'];
}
// echo "special";
// echo $special;die();
// if ($query == '') {
$list = $productBundlesRepository->findAllPaginated($special, $limit, $startIndex);
// } else {
//   $list = $productsRepository->findAllPaginated($query, $limit, $startIndex);
// }

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));