<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/LookupsRepository.php';

cors();

requiresAuth(array('ADMIN'));

if (isset($_REQUEST['id'])) {
    $lookupsRepository->setInactive($_REQUEST['id']);
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}