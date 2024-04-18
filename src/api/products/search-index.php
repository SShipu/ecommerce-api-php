<?php
/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/SearchIndicesRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../helpers/RegexHelper.php';
cors();
$data = getJsonBody();

$list = $searchIndicesRepository->createSearchIndex($data->productId);
sendEmptyJsonResponse(202);