<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '../../../repositories/NewsEventsRepository.php';
cors();

// requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER', 'SHOWROOM_SALES'));

if (isset($_GET['id'])) {

    $news = $newsEventsRepository->findOne($_GET['id']);
    if ($news == null)
        throw new NotFoundException();
    sendJsonResponse(200, $news);
} else {
    throw new BadRequestException();
}