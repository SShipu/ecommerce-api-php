<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ItemAttributesRepository.php';

cors();

requiresRoleAnyOf(array('ADMIN'));

if (isset($_REQUEST['id'])) {
    $itemAttributesRepository->delete($_REQUEST['id']);
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}