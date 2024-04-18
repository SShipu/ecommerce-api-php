<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/InvoicesRepository.php';
cors();

requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER', 'SHOWROOM_SALES'));

if (isset($_GET['id'])) {

    $invoice = $invoicesRepository->findByInvoiceId($_GET['id']);

    if ($invoice == null)
        throw new NotFoundException();


    if (hasRole('ADMIN')) {
        sendJsonResponse(200, $invoice);
    } else if (hasRole('SHOWROOM_MANAGER') || hasRole('SHOWROOM_SALES')) {
        $branchId = $currentUser->getBranches()[0]->getId();
        if ($branchId == $invoice->getBranch()->getId()) {

            sendJsonResponse(200, $invoice);
        } else {

            throw new ResourceLockedException();
        }
    }
}
else {

    throw new BadRequestException();
}