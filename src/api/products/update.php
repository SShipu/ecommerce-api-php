<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../repositories/SearchIndicesRepository.php';
require_once __DIR__ . '/../../repositories/StocksV2Repository.php';
require_once __DIR__ . '/../../validation/ProductValidation.php';
cors();

// requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();
validate($data);

if (isset($data->id)) {
    $undeletedSkus = $productsRepository->update($data);
    if (count($undeletedSkus) > 0) {
        sendJsonResponse(206, $undeletedSkus);
    } else {
        sendEmptyJsonResponse(202);  
    }
} else {
    throw new BadRequestException();
}