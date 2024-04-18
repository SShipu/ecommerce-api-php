<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/OtpsRepository.php';
cors();

// requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER', 'SHOWROOM_SALES'));

if (isset($_GET['id'])) {

    $otp = $otpsRepository->findOne($_GET['id']);

    if ($otp == null)
        throw new NotFoundException();

    // sendJsonResponse(200, $otp);
    sendJsonResponse(200, array('otpData' => $otp, 'errors' => array()));
}
else {
    throw new BadRequestException();
}