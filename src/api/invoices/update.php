<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';

cors();

$data = getJsonBody();

if (isset($data->code)) {
    $skusRepository->update($data);
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}