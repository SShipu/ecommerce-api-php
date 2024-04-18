<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/LookupsRepository.php';
cors();

// requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER', 'SHOWROOM_SALES'));

if (isset($_GET['id'])) {
    $list = $lookupsRepository->findById($_GET['id']);
    if ($list == null)
        throw new NotFoundException();
    
    sendJsonResponse(200, $list);
} else {
    throw new BadRequestException();
}