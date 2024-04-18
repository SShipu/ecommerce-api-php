<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../repositories/InvoicesRepository.php';
require_once __DIR__ . '/../../../repositories/BranchesRepository.php';

cors();

if($_POST['pay_status']=="Successful"){
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
$pgid = $a['pg_txnid'];

$phone = $a['cus_phone'];

$data=new stdClass;
$data->id = $mid;
$data->tarnsId = $pgid;
$data->payStatus = $a['pay_status'];

$branchId = $branchesRepository->findEcommerceBranch()[0]->getId();

$invoicesRepository->paymentReceivedEcommerceOrder($data, $branchId);

// for Sandbox (for testing):
// header("Location: http://localhost:8080/payment?invoicesId=$mid&transactionId=$pgid");

//for LIVE(production):
header("Location: http://heavymetaltshirtbd.com/payment?invoicesId=$mid&transactionId=$pgid");


// $username = "HMTSMS";
// $password = "hmtp@$";
// $mobiles = '01744612299';
$message = 'Dear Customer, thank you for your order. Your invoice id is' . $mid .' & transaction id is ' . $pgid . '. Soon, a representative will contact you regarding the delivery.';
// $originator = '01844016400';
$token= "2bfce7c1f5e1f1b63722927efa3da1867aa4f2f9";

// LOCAL API KEY
// $api_key="AFC7F6D6A12F7743"; // api key will be get from your portal http://portal.muthofun.com

// SERVER API KEY
// $api_key="BB91AEEEBEBC8787"; // api key will be get from your portal http://portal.muthofun.com

// $senderId="Aruhat"; //sender id is available in your portal
	
// echo sendSMS($username, $password, $mobiles, $sms, $originator, $senderId);
// echo sendSMS($username, $password, $mobiles, $sms, $senderId);
echo sendSMS($token, $phone, $message);

// function sendSMS($username, $password, $phone, $message, $originator, $senderId)
// function sendSMS($username, $password, $phone, $message, $senderId) {	
function sendSMS($token, $phone, $message) {	
    // make sure passed string is url encoded
    $message = rawurlencode($message);
    
    // $url = "http://clients.muthofun.com:8901/esmsgw/sendsms.jsp?user=$username&password=$password&mobiles=$phone&sms=$message&unicode=1";			
    // $url = "http://clients.muthofun.com:8901/esmsgw/sendsms.jsp?senderid=Aruhat&user=HMTSMS&mobiles=01744612299&sms=hello world&unicode=1&&password=hmtp@$";			
    // $url = "http://clients.muthofun.com:8901/esmsgw/sendsms.jsp?senderid=$senderId&user=$username&mobiles=$phone&sms=$message&unicode=1&password=$password";			
    $url = "https://sysadmin.muthobarta.com/api/v1/send-sms-get?token=$token&receiver=$phone&message=$message&remove_duplicate=true";			

    $c = curl_init(); 
    curl_setopt($c, CURLOPT_RETURNTRANSFER, 1); 
    curl_setopt($c, CURLOPT_URL, $url); 
    $response = curl_exec($c); 
    return $response;
}