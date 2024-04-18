<?php

/* configuration */
require_once __DIR__ . '../../../configs/config.php';
require_once __DIR__ . '../../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '../../../repositories/ContactUsRepository.php';

cors();

// requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER'));

list($limit, $offset, $startIndex) = getPaginationParams();

$list = $contactUsRepository->findAllPaginated($limit, $startIndex);

$nextPageToken = '';
if (count($list) >= $limit)
    $nextPageToken = ($offset + 1) . '-' . $limit;

sendJsonResponse(200, array('list' => $list, 'nextPageToken' => $nextPageToken));
