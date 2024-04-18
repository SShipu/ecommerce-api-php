<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/LookupsRepository.php';
require_once __DIR__ . '/../../validation/LookupValidation.php';

cors();

requiresAuth(array('ADMIN'));

$data = getJsonBody();
validate($data);

if (isset($data->id)) {
    $lookupsRepository->update($data);
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}