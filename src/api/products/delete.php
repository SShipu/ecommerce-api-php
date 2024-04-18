<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';

cors();
// requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER'));

if (isset($_REQUEST['id'])) {
    $skuGet = $productsRepository->updateDelete($_REQUEST['id']);
    
    // if ($skuGet != null) {
    //     $productsRepository->setInactive($_REQUEST['id']);
    // } else {
    //     $productsRepository->delete($_REQUEST['id']);
    // }
    
   sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}