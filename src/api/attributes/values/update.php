<?php

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../repositories/ItemAttributeValuesRepository.php';
require_once __DIR__. '/../../../validation/ItemAttributeValueValidation.php';

cors();
requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();
validate($data);

if (isset($data->id)) {
    $itemAttributeValuesRepository->update($data);
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}