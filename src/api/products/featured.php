<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../helpers/RegexHelper.php';
cors();

list($limit, $offset, $startIndex) = getPaginationParams();

$products = $productsRepository->findAllFeaturedPaginated($limit, $startIndex);

$productArray =  array();
foreach ($products as $product) {
  array_push($productArray, $product->getProduct());
}
$list = $productArray; 

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));