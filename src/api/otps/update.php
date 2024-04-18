<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/OtpsRepository.php';

cors();

// requiresRoleAnyOf(array('ADMIN', 'SHOWROOM-MANAGER'));

$data = getJsonBody();

// validate($data);

if (isset($data->id)) {
    $otp = $otpsRepository->update($data);
    // sendEmptyJsonResponse(202);
    sendJsonResponse(202, array('otpData' => $otp, 'errors' => array()));

} else {
    throw new BadRequestException();
}