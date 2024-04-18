<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../../../configs/config.php';
require_once __DIR__ . '/../../../../framework/framework.php';
require_once __DIR__ . '/../../../../framework/auth.php';
// require_once __DIR__ . '/../../../../repositories/ProductsRepository.php';
// require_once __DIR__ . '/../../../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../../../repositories/MfgOrdersV2Repository.php';
// require_once __DIR__ . '/../../../../repositories/StocksV2Repository.php';

cors();

requiresRoleAnyOf(array('ADMIN', 'DISTRIBUTION_MANAGER'));

$data = getJsonBody();

if (hasRole('ADMIN')) {
    $branchId = -1;
} else {
    $branchId = $currentUser->getBranches()[0]->getId();
    // echo $branchId;
}

$mfgOrdersV2Repository->completeOrder($data, $branchId, $currentUser->getId());

sendEmptyJsonResponse(202);