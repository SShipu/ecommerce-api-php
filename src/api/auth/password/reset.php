<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/UsersRepository.php';
require_once __DIR__ . '/../../../repositories/UserTokensRepository.php';

cors();
requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();

if (isset($data->id)) {   
    $usersRepository->resetPassword($data);
    sendEmptyJsonResponse(202);
} else
    throw new BadRequestException();