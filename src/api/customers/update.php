<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/UsersRepository.php';
require_once __DIR__ . '/../../validation/UserValidation.php';

cors();

requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();

validate($data);

if (isset($data->id)) {
    $usersRepository->update($data);
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}