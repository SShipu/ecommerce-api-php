<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/InvoicesRepository.php';
require_once __DIR__ . '/../../repositories/StocksV2Repository.php';
require_once __DIR__ . '/../../repositories/BranchesRepository.php';

cors();

requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();

// if (hasRole('ADMIN')) {
//     $branchId = -1;
// } else {
    $branchId = $branchesRepository->findEcommerceBranch()[0]->getId();
// }

$invoicesRepository->cancelEcommerceOrder($data, $branchId);

sendEmptyJsonResponse(202);