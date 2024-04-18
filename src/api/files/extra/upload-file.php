<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/UsersRepository.php';
require_once __DIR__ . '/../../repositories/RolesRepository.php';
require_once __DIR__ . '/../../repositories/UserTokensRepository.php';

cors();

$data = getJsonBody();

// $userId = $currentUser->getId();

$target_dir = __DIR__ . "/../../../uploads/";
$target_file = $target_dir . basename($_FILES["file"]["name"]);
$imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

// print_r($data);die();
// if ($userId != null) {
try {
    // $upFile = new UploadFile();
    // // $upFile->setUserId($id);
    // // // echo "h1";die();
    // // $usersRepository->uploadImage($id);
    // sendEmptyJsonResponse(202);

    // if (isset($data->userName)) {

    if (password_verify($data->password, $user->getPassword())) {
        // echo "True";die();

        $rolesArray = array();
        foreach ($user->getRoles() as $role) {
            array_push($rolesArray, $role->jsonSerialize());
        }

        $res = array(
            'id' => $user->getId(),
            'userName' => $user->getUserName(),
            'fullName' => $user->getFullName(),
            'roles' => $rolesArray,
            'token' => $userTokensRepository->save($user->getId()),
        );

        sendJsonResponse(200, $res);

    } else {
        sendEmptyJsonResponse(401);
    }

} catch (Exception $ex) {
    // print_r($ex);die();
    $errorCode = $ex->getPrevious()->getCode();
    if ($errorCode == 23000) {
        sendEmptyJsonResponse(409);
    } else {
        sendEmptyJsonResponse(500);
    }

}
// } else {
//     sendEmptyJsonResponse(412);
// }
// $target_dir = __DIR__ . "/../../../uploads/";
// $target_file = $target_dir . basename($_FILES["file"]["name"]);
// $uploadOk = 1;
// $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

// // Check if image file is a actual image or fake image
// if (isset($_POST["submit"])) {
//     $check = getimagesize($_FILES["file"]["tmp_name"]);
//     if ($check !== false) {
//         echo "File is an image - " . $check["mime"] . ".";
//         $uploadOk = 1;
//     } else {
//         echo "File is not an image.";
//         $uploadOk = 0;
//     }
//     // echo "h1";
// }
// // Check if file already exists
// if (file_exists($target_file)) {
//     echo "Sorry, file already exists.";
//     $uploadOk = 0;
//     // echo "h2";
// }
// // Check file size
// if ($_FILES["file"]["size"] > 50000000) {
//     echo "Sorry, your file is too large.";
//     $uploadOk = 0;
//     // echo "h3";
// }
// // Allow certain file formats
// if ($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
//     && $imageFileType != "gif") {
//     echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
//     $uploadOk = 0;
//     // echo "h4";
// }
// // echo __DIR__;
// // echo $target_file;
// // Check if $uploadOk is set to 0 by an error
// if ($uploadOk == 0) {
//     // echo "h5";
//     echo "Sorry, your file was not uploaded.";
// // if everything is ok, try to upload file

// } else {
//     if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
//         echo "The file " . htmlspecialchars(basename($_FILES["file"]["name"])) . " has been uploaded.";
//     } else {
//         echo "Sorry, there was an error uploading your file.";
//     }
// }