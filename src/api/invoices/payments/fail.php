<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../framework/framework.php';
// require_once __DIR__ . '/../../repositories/InvoicesRepository.php';

cors();

if($_POST['pay_status']=="Failed"){
    echo "Successful page";
    $merTxnId= $_POST['mer_txnid'];
    
}else {
    echo "Not Successful page";
}

//for Sandbox (for testing):
    // $store_id = "aamarpay";
    // $signature_key = "28c78bb1f45112f5d40b956fe104645a";

//for LIVE(production):
    $store_id = "heavymetal";
    $signature_key = "2b5ec657b135b13debf3c5070d21d1ed";

$curl_handle=curl_init();

//for Sandbox (for testing):
// curl_setopt($curl_handle,CURLOPT_URL,"https://sandbox.aamarpay.com/api/v1/trxcheck/request.php?request_id=$merTxnId&store_id=$store_id&signature_key=$signature_key&type=json");

//for LIVE(production):
curl_setopt($curl_handle,CURLOPT_URL,"https://secure.aamarpay.com/api/v1/trxcheck/request.php?request_id=$merTxnId&store_id=$store_id&signature_key=$signature_key&type=json");

curl_setopt($curl_handle, CURLOPT_VERBOSE, true);
curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl_handle, CURLOPT_SSL_VERIFYPEER, false);
$buffer = curl_exec($curl_handle);
curl_close($curl_handle);
$a = (array)json_decode($buffer);
echo "<pre>";
print_r($a);
echo "</pre>";

$paystatus=$a['pay_status'];
$mid=$a['mer_txnid'];
$status=$a['status_code'];

// if($_SERVER['REQUEST_METHOD']=="POST"){

//     $paystatus=$_POST['pay_status'];
//     $amount=$_POST['amount'];
//     $trxnid=$_POST['pg_txnid'];
//     $mer_trxnid=$_POST['mer_txnid'];
//     $card=$_POST['card_type'];
   
//     echo $paystatus."</br>";
//     echo $amount."</br>";
//     echo $trxnid."</br>";
//     echo $mer_trxnid."</br>";
//     echo $card."</br>";
    
//     // echo $paystatus;
//     // echo $amount;
//     //you can get all parameter from post request
//     //print_r($_POST);
// }

