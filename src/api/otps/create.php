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
echo "OTP Create";
print_r($data);
die();

$id = $otpsRepository->save($data);

$res = array('id' => $id, 'errors' => array());
sendJsonResponse(201, $res);






