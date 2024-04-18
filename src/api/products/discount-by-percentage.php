<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../helpers/RegexHelper.php';
cors();

list($limit, $offset, $startIndex) = getPaginationParams();

$minPercentage = '';
$maxPercentage = '';
if (isset($_GET['minPercentage']))
    $minPercentage = $_GET['minPercentage'];

if (isset($_GET['maxPercentage']))
    $maxPercentage = $_GET['maxPercentage'];


$list = $productsRepository->findDiscountByPercentage($minPercentage, $maxPercentage, $limit, $startIndex);

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));