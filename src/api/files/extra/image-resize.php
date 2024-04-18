<?php

$target_dir = __DIR__ . "/../../../images/";
$uploadImage = $_FILES["file"]["name"];

move_uploaded_file($_FILES['file']['tmp_name'], $target_dir . $uploadImage);

$file_name = basename($_FILES["file"]["name"]);

$target_file = $target_dir . $file_name;

$dimention = array(
    array('pos-large-thumb', 432, 401),
    array('pos-details-thumb', 372, 460),
    array('main-thumb', 480, 652),
    array('sidebar-thumb', 110, 160),
    array('related-thumb', 198, 269),
    array('list-thumb', 320, 434),
    array('gallery-thumb', 138, 187),
    array('shop-list-thumb', 232, 315),
);

$im = new imagick($target_file);

$imageprops = $im->getImageGeometry();
$width = $imageprops['width'];
$height = $imageprops['height'];

$ratio = $width / $height;
echo $ratio . " ";
echo "h6" . " ";

for ($i = 0; $i < count($dimention); $i++) {
    echo $dimention[$i][0];
    $uid = uniqid();
    $imageName = $dimention[$i][0] . "-" . $uid;

    $target_width = $dimention[$i][1];
    $target_height = $dimention[$i][2];

    $newWidth = $ratio * $target_height;
    $newHeight = $target_height;
    echo $newWidth . " ";
    echo $newHeight . " ";

    echo "h8";

    $im->setImageFormat("jpeg");
    $im->scaleImage($newWidth, $newHeight);

    $im->setFilename($imageName);
    echo "h9" . " ";
    $im->writeImage($target_dir . $imageName . ".jpg");
}

// for ($i = 0; $i < count($dimention); $i++) {
//     echo $dimention[$i][0];
//     $uid = uniqid();
//     $imageName = $dimention[$i][0] . "-" . $uid;

//     if ($width > $height) {
//         $newHeight = $ratio / $dimention[$i][2];
//         // $newWidth = (80 / $height) * $width;
//         $newWidth = $dimention[$i][1];
//         echo $newWidth;
//         echo "h7";

//     } else {
//         // $newWidth = 80;
//         // $newHeight = (80 / $width) * $height;
//         $newWidth = $ratio / $dimention[$i][1];
//         $newHeight = $dimention[$i][2];
//         //     echo $newHeight;
//         echo "h8";
//     }

// // $im->resizeImage($newWidth, $newHeight, imagick::FILTER_LANCZOS, 0.9, true);
//     // $image->setImageColorspace(imagick::COLORSPACE_RGB);
//     $im->setImageFormat("jpeg");
//     $im->scaleImage($newWidth, $newHeight);
//     $im->setFilename($imageName);
//     // $im->cropImage(80, 80, 0, 0);
//     echo "h9";
//     echo $target_dir . $imageName . ".jpg";
//     $im->writeImage($target_dir . $imageName . ".jpg");
// }
// echo "h10";