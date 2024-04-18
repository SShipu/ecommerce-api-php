<?php
/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';

cors();

if (isset($_REQUEST['code'])) {
    $skusRepository->delete($_REQUEST['code']);
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}