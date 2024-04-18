<?php

/* configuration */
require_once __DIR__ . '/../../../../configs/config.php';
require_once __DIR__ . '/../../../../framework/framework.php';
require_once __DIR__ . '/../../../../framework/auth.php';
require_once __DIR__ . '/../../../../repositories/MfgOrdersV2Repository.php';
cors();
requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER', 'SHOWROOM_SALES'));

if (isset($_GET['id'])) {
    $order = $mfgOrdersV2Repository->findByOrderId($_GET['id']);
    if ($order == null)
        throw new NotFoundException();


    if (hasRole('ADMIN')) {
          sendJsonResponse(200, $order);
      } else if (hasRole('SHOWROOM_MANAGER', 'SHOWROOM_SALES')) {
          $branchId = $currentUser->getBranches()[0]->getId();
          if ($branchId == $order->getDestinationBranch()->getId()) {
              sendJsonResponse(200, $order);
          } else {
              throw new ResourceLockedException();
          }
      }
}
else {
    throw new BadRequestException();
}