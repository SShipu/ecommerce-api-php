<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../repositories/ProductBundlesRepository.php';

cors();

if (isset($_GET['id'])) {
    $prod = $productBundlesRepository->findById($_GET['id']);
    if ($prod == null)
        throw new NotFoundException();
    sendJsonResponse(200, $prod);
} else {
    throw new BadRequestException();
}
