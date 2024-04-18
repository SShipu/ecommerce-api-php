<?php

/* configuration */
require_once(__DIR__. '/../../configs/config.php');
require_once(__DIR__. '/../../framework/framework.php');
require_once(__DIR__. '/../../framework/auth.php');
require_once(__DIR__. '/../../repositories/LookupsRepository.php');
require_once(__DIR__. '/../../validation/LookupValidation.php');


cors();

requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();

$lookupsRepository->assignAttributes($data->lookupId, $data->attrIds);
sendEmptyJsonResponse(202);
