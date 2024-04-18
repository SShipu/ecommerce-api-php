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
$cateId = -1;

if (isset($_GET['id'])) {
    $branchId = $_GET['id'];
}

if (isset($_GET['categoryId'])) {
    $cateId = $_GET['categoryId'];
}

$stocks = $stocksV2Repository->findFilteredByBranch($branchId, $cateId, $limit, $startIndex);

$productArray =  array();
$uniqueIds =  array();

foreach ($stocks as $stock) {
    $product = $stock->getSku()->getProduct();
    if (!in_array($product->getId(), $uniqueIds)) {
        array_push($uniqueIds, $product->getId());
        array_push($productArray, $product);
    } else {
        // echo 'exists' . '<br/>';
    }
    foreach ($product->getSkus() as $sku) {
        $filteredStocks = array();
        foreach ($sku->getStocks() as $s) {
            if ($s->getBranch()->getId() == $branchId) {
                array_push($filteredStocks, $s);
            }
        }
        $sku->setStocks($filteredStocks);

        if (count($filteredStocks) > 0) {
            foreach ($productArray as $product) {
                $prodSkus = $product->getSkus();
                for ($i=0; $i < count($prodSkus); $i++) { 
                    $prodSkus[$i] == $sku; break;
                }
                $product->setSkus($prodSkus);
            }
        }
    }
    

}
// $filtered = array_intersect_key($array, array_unique(array_column($array, 'someProperty')));

$list = $productArray; 

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));