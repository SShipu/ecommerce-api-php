<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../repositories/UsersRepository.php';
require_once __DIR__ . '/../../../repositories/RolesRepository.php';
require_once __DIR__ . '/../../../repositories/UserTokensRepository.php';

cors();

$data = getJsonBody();

$userId = $currentUser->getId();

if ($userId != null) {
    $usersRepository->changePassword($data, $userId);
    sendEmptyJsonResponse(202);
} else
    throw new BadRequestException();