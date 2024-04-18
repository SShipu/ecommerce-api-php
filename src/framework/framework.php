<?php


function cors() {

    // Allow from any origin
    if (isset($_SERVER['HTTP_ORIGIN'])) {
        // Decide if the origin in $_SERVER['HTTP_ORIGIN'] is one
        // you want to allow, and if so:
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400'); // cache for 1 day
    }

    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        // may also be using PUT, PATCH, HEAD etc
        {
            header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
        }

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS'])) {
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
        }

        exit(0);
    }
}

function getJsonBody()
{
    $json = file_get_contents('php://input', true);
    $data = json_decode($json);
    return $data;
}

function sendEmptyJsonResponse($code)
{
    http_response_code($code);
    header('Content-Type: application/json');
    echo json_encode(array());
}

function sendJsonResponse($code, $body)
{
    http_response_code($code);
    header('Content-Type: application/json');
    echo json_encode($body);
}

function isAuthenticated() {
    global $currentUser;
    return $currentUser != null;
}

function isCurrentUser() {
    global $currentUser;
    return $currentUser;
}

function requiresAuth() {
    if (!isAuthenticated()) {
        throw new UnauthorizedException();
    }
}

function requiresRole($role) {
    if (!isAuthenticated()) {
        throw new UnauthorizedException();
    }
    global $currentUser;
    if ($currentUser->getUserRole() != $role) {
        throw new ForbiddenException();
    }

}

function requiresRoleAnyOf($roles) {

    if (!isAuthenticated()) {
        throw new UnauthorizedException();
    }

    global $currentUser;

    $roleFound = false;

    foreach ($currentUser->getRoles() as $role) {
        if (in_array($role->getRole(), $roles)) {
            $roleFound = true;
            break;
        }
    }
    if (!$roleFound) {
        throw new ForbiddenException();
    }
}

function hasRole($role) {
  if (!isAuthenticated()) {
      return FALSE;
  }
  global $currentUser;
  foreach ($currentUser->getRoles() as $uRole) {
      if ($uRole->getRole() == $role) {
        return TRUE;
      }
  }
  return FALSE;
}

function getPaginationParams() {

    $limit = 0;
    $offset = 0;
    $startIndex = 0;

    if (isset($_GET['size']) && isset($_GET['pageNo'])) {
        $limit = (int)$_GET['size'];
        $offset = ((int)$_GET['pageNo']) - 1;
        $startIndex = $offset * $limit;
        return array($limit, $offset, $startIndex);
    }

    if (!isset($_GET['size']) && !isset($_GET['pageToken'])) {
        $limit = 300;
        $offset = 0;
        $startIndex = 0;
    } else {
        if (isset($_GET['size'])) {
            $limit = (int)$_GET['size'];
            $offset = 0;
            $startIndex = 0;
        } else if (isset($_GET['pageToken'])) {
            $parts = explode("-", $_GET['pageToken']);
            $offset = (int)$parts[0];
            $limit = (int)$parts[1];
            $startIndex = $offset * $limit;
        }
    }
    return array($limit, $offset, $startIndex);
}