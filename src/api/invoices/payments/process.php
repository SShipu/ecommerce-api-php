<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../framework/framework.php';

cors();

error_reporting(0); //warning hide
$data = getJsonBody();

if(!isset($data->name)){
    echo "Direct access restricted";
    exit();
}

    $fullName=$data->name;
    $email=$data->email;
    $phone_number=$data->contactNo;
    $address = $data->contactAddress;
    $description=$data->desc;
    $invoiceId=$data->invoiceId;
    $total = $data->total;
    $host = 'http://' . $_SERVER['HTTP_HOST'];
    $path = "/api/invoices/payments/";
    $success = $host . $path . 'success.php';
    $fail = $host . $path . 'fail.php';
   
//for Sandbox (for testing):
// $url = 'https://sandbox.aamarpay.com/request.php';

//for LIVE(production):
$url = 'https://secure.aamarpay.com/request.php';

$fields = array(
    //for Sandbox (for testing):
    // 'store_id' => 'aamarpay',

    //for LIVE(production):
    'store_id' => 'heavymetal',
    
    'amount' => $total, 
    'currency' => 'BDT', 
    'payment_type' => 'VISA',
    // 'tran_id' => $cur_random_value,
    'tran_id' => $invoiceId,
    'cus_name' => $fullName, 
    'cus_email' => $email,
    'cus_add1' => $address, 
    // 'cus_add2' => 'Mohakhali DOHS',
    // 'cus_city' => 'Dhaka', 
    // 'cus_state' => 'Dhaka', 
    // 'cus_postcode' => '1206',
    // 'cus_country' => 'Bangladesh', 
    'cus_phone' => $phone_number,
    'cus_fax' => 'Not¬Applicable', 
    'ship_name' => $fullName,
    // 'ship_add1' => 'House B-121, Road 21', 
    // 'ship_add2' => 'Mohakhali',
    // 'ship_city' => 'Dhaka', 
    // 'ship_state' => 'Dhaka',
    // 'ship_postcode' => '1212', 
    // 'ship_country' => 'Bangladesh',
    'desc' => $description,
    // 'success_url' => 'http://localhost/edu/success.php',
    // 'cancel_url' => 'http://localhost/edu/cancel.php',
    'success_url' => $success,
    'fail_url' => $fail,
    'cancel_url' => 'http://heavymetaltshirtbd.com/payment',
    // 'opt_a' => 'Reshad', 
    // 'opt_b' => 'Akil',
    // 'opt_c' => 'Liza', 
    // 'opt_d' => 'Sohel',

    //for Sandbox (for testing):
    // 'signature_key' => '28c78bb1f45112f5d40b956fe104645a');

    //for LIVE(production):
    'signature_key' => '2b5ec657b135b13debf3c5070d21d1ed');
   
foreach($fields as $key=>$value) { $fields_string .= $key.'='.$value.'&'; }
$fields_string = rtrim($fields_string, '&'); 
$ch = curl_init();
curl_setopt($ch, CURLOPT_VERBOSE, true);
curl_setopt($ch, CURLOPT_URL, $url);  
curl_setopt($ch, CURLOPT_POST, count($fields)); 
curl_setopt($ch, CURLOPT_POSTFIELDS, $fields_string);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
$res = curl_exec($ch);

$url_forward = str_replace('"', '', stripslashes($res));	
curl_close($ch); 

sendJsonResponse(200, array('url' => $url_forward, 'error' => array()));
