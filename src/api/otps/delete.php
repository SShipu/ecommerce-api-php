<?php

/* configuration */
require_once __DIR__ . '../../../configs/config.php';
require_once __DIR__ . '../../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '../../../repositories/NewsEventsRepository.php';

cors();

requiresRoleAnyOf(array('ADMIN', 'SHOWROOM-MANAGER'));

if (isset($_REQUEST['id'])) {
    $newsEventsRepository->delete($_REQUEST['id']);
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}