<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
date_default_timezone_set("Asia/Dhaka");

// echo __DIR__;
require_once(__DIR__ . '/../../bootstrap.php');
require_once(__DIR__ . '/../framework/framework.php');


require_once(__DIR__ . '/../framework/exceptions/ConflictException.php');
require_once(__DIR__ . '/../framework/exceptions/BadRequestException.php');
require_once(__DIR__ . '/../framework/exceptions/ExpectationFailedException.php');
require_once(__DIR__ . '/../framework/exceptions/FailedDependencyException.php');
require_once(__DIR__ . '/../framework/exceptions/ForbiddenException.php');
require_once(__DIR__ . '/../framework/exceptions/GoneException.php');
require_once(__DIR__ . '/../framework/exceptions/NotAcceptableException.php');
require_once(__DIR__ . '/../framework/exceptions/NotAllowedException.php');
require_once(__DIR__ . '/../framework/exceptions/NotFoundException.php');
require_once(__DIR__ . '/../framework/exceptions/PaymentRequiredException.php');
require_once(__DIR__ . '/../framework/exceptions/PreconditionFailedException.php');
require_once(__DIR__ . '/../framework/exceptions/ResourceLockedException.php');
require_once(__DIR__ . '/../framework/exceptions/UnauthorizedException.php');
require_once(__DIR__ . '/../framework/exceptions/UnprocessableEntityException.php');


function exceptionHandler($ex) {
    if ($ex instanceof ConflictException) {
        sendEmptyJsonResponse(409);
        die();
    } else if ($ex instanceof BadRequestException) {
        if ($ex->getErrorBody() != null)
            sendJsonResponse(400, $ex->getErrorBody());
        else
            sendEmptyJsonResponse(400);
        die();
    } else if ($ex instanceof ExpectationFailedException) {
        if ($ex->getErrorBody() != null)
            sendJsonResponse(417, $ex->getErrorBody());
        else
            sendEmptyJsonResponse(417);
        die();
    } else if ($ex instanceof FailedDependencyException) {
        sendEmptyJsonResponse(424);
        die();
    } else if ($ex instanceof ForbiddenException) {
        sendEmptyJsonResponse(403);
        die();
    } else if ($ex instanceof GoneException) {
        sendEmptyJsonResponse(412);
        die();
    } else if ($ex instanceof NotAcceptableException) {
        sendEmptyJsonResponse(406);
        die();
    } else if ($ex instanceof NotAllowedException) {
        sendEmptyJsonResponse(405);
        die();
    } else if ($ex instanceof NotFoundException) {
        sendEmptyJsonResponse(404);
        die();
    } else if ($ex instanceof PaymentRequiredException) {
        sendEmptyJsonResponse(402);
        die();
    } else if ($ex instanceof PreconditionFailedException) {
        if ($ex->getErrorBody() != null)
            sendJsonResponse(412, $ex->getErrorBody());
        else
            sendEmptyJsonResponse(412);
    } else if ($ex instanceof ResourceLockedException) {
        sendEmptyJsonResponse(423);
        die();
    } else if ($ex instanceof UnauthorizedException) {
          sendEmptyJsonResponse(401);
          die();
    } else if ($ex instanceof UnprocessableEntityException) {
          sendEmptyJsonResponse(422);
          die();
    } else {
          echo $ex->getMessage();
    }
}

// Set user-defined exception handler function
set_exception_handler("exceptionHandler");