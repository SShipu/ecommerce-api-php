<?php
/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../helpers/RegexHelper.php';
cors();
$data = getJsonBody();
if (RegexHelper::isSkuCode($data->query)) {
    $str = RegexHelper::parseSkuCode($data->query);
    $sku = $skusRepository->findByCode($data->query);
    // if ($sku != null) {
    if (count($sku) > 0) {
        $list = array();
        foreach ($sku as $val) {
            array_push($list, $val->longJsonSerialize());
        }
        // array_push($list, $sku->longJsonSerialize());
        sendJsonResponse(200, array('list' => $list, 'nextPageToken' => ''));
        // sendJsonResponse(200, array('list' => $sku, 'nextPageToken' => ''));
    } else {
        sendJsonResponse(200, array('list' => array(), 'nextPageToken' => ''));
    }
} else if (RegexHelper::isProductCode($data->query)) {
    $str = RegexHelper::parseSkuCode($data->query);
    $product = $productsRepository->findOneByCode($data->query);
    // if ($product != null) {
    if (count($product) > 0) {
      $list = array();
    //   array_push($list, $product->jsonSerialize());
        foreach ($product as $val) {
            array_push($list, $val->jsonSerialize());
        }
      sendJsonResponse(200, array('list' => $list, 'nextPageToken' => ''));
    } else {
      sendJsonResponse(200, array('list' => array(), 'nextPageToken' => ''));
    }
} else {
    $products = $productsRepository->findByTitle($data->query);
    $list = array();
    foreach ($products as $product) {
        array_push($list, $product->jsonSerialize());
    }
    sendJsonResponse(200, array('list' => $list, 'nextPageToken' => ''));
}