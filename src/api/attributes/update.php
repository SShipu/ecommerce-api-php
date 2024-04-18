<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/ItemAttributesRepository.php';
require_once __DIR__ . '/../../validation/ItemAttributeValidation.php';
cors();

requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();
validate($data);

if (isset($data->id)) {
    $itemAttributesRepository->update($data);
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}