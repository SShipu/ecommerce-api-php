<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class OtpsRepository extends EntityRepository
{
    public function save($data) {
        $em1 = getEntityManager();

        function generateNumericOTP($n) {
            
            $generator = "1357902468";
            $result = "";
        
            for ($i = 1; $i <= $n; $i++) {
                $result .= substr($generator, (rand()%(strlen($generator))), 1);
            }
            return $result;
        }
        function sendSMS($token, $phone, $message) {
        // function sendSMS($username, $password, $phone, $message, $senderId) {	
            $message = rawurlencode($message);
            
            // $url = "http://clients.muthofun.com:8901/esmsgw/sendsms.jsp?senderid=$senderId&user=$username&mobiles=+88$phone&sms=$message&unicode=1&password=$password";	
            // echo $url;
            $url = "https://sysadmin.muthobarta.com/api/v1/send-sms-get?token=$token&receiver=$phone&message=$message&remove_duplicate=true";

            $c = curl_init(); 
            curl_setopt($c, CURLOPT_RETURNTRANSFER, 1); 
            curl_setopt($c, CURLOPT_URL, $url); 
            $response = curl_exec($c); 
            // echo "SMS get way";
            // echo $url;
            // print_r($response);
            return $response;
        }

        $otpCode = generateNumericOTP(6);

        // $username = "HMTSMS";
        // $password = "hmtp@$";
        $phone = $data->contactNo;
        $sms = 'Dear Customer, Your Otp Code Is ' . $otpCode;
        $token= "2bfce7c1f5e1f1b63722927efa3da1867aa4f2f9";
        // $senderId="Aruhat"; //sender id is available in your portal
        // $senderId="8809601002706"; //sender id is available in your portal


        $code = $data->fingerprint . '-' . $phone;

        // $oldOtps = $em1->find('Otp', $data->id);

        $dql = "SELECT o FROM Otp o WHERE o.contactNo = '$data->contactNo' AND o.fingerPrint = '$data->fingerprint'";
        $query = $em1->createQuery($dql);
        $oldOtps = $query->getResult();
        // echo "Check create otp";
        // print_r($oldOtps);die();
        // $token = bin2hex(random_bytes(16));

        $id = "";
        
        if ($oldOtps != null) {
            $oldId = $oldOtps[0]->getCode();
            $oldOtpsV2 = $em1->find('Otp', $oldId);
            $oldOtpsV2->setOtp($otpCode);
            $oldOtpsV2->setConfirm("false");
            $em1->persist($oldOtpsV2);
            // echo "Check create otp old otp";
            // echo $oldOtpsV2->getCode();die();
            $id = $oldOtpsV2->getCode();
        } else {
            // throw new NotFoundException();
             
            // echo "New create"; die();
            $otp = new Otp();
            $otp->setCode($code);
            $otp->setOtp($otpCode);
            $otp->setConfirm("false");
            $otp->setContactNo($data->contactNo);
            $otp->setFingerPrint($data->fingerprint);
            $otp->setCreatedTime(new \DateTime('now', new DateTimeZone('Asia/Dhaka')));
            
            
            $em1->persist($otp);
            $id = $otp->getCode();
        }

        try {
            $em1->flush();
            sendSMS($token, $phone, $sms);
            // sendSMS($username, $password, $phone, $sms, $senderId);
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
        
        return $id;
    }

    public function update($data) {
        $em1 = getEntityManager();
        $oldOtps = $em1->find('Otp', $data->id);
        $token = bin2hex(random_bytes(16));
        
        if ($oldOtps != null) {
            if ($oldOtps->getOtp() == $data->otpCode ) {
                if ($oldOtps->getConfirm() == "false" ) {
                    $oldOtps->setToken($token);
                    $oldOtps->setConfirm("true");
                    $oldOtps->setCreatedTime(new \DateTime('now', new DateTimeZone('Asia/Dhaka')));

                    $em1->persist($oldOtps);

                    try {
                        $em1->flush();
                    } catch (UniqueConstraintViolationException $ex) {
                        throw new ConflictException();
                    }
                } else {
                    echo "Already Confirmed";
                    throw new ConflictException();
                }
            } else {
                throw new UnauthorizedException();
            }
        } else {
            throw new NotFoundException();
        }

        return $em1->find('Otp', $data->id);
    }

    public function check($data) {
        $em1 = getEntityManager();
        // echo "check otp";
        // print_r($data);

        // function reGenerateNumericOTP($n) {
            
        //     $generator = "1357902468";
        //     $result = "";
        
        //     for ($i = 1; $i <= $n; $i++) {
        //         $result .= substr($generator, (rand()%(strlen($generator))), 1);
        //     }
        //     return $result;
        // }

        // function reSendSMS($username, $password, $phone, $message, $senderId)
        // {	
        //     $message = rawurlencode($message);
            
        //     $url = "http://clients.muthofun.com:8901/esmsgw/sendsms.jsp?senderid=$senderId&user=$username&mobiles=$phone&sms=$message&unicode=1&password=$password";			

        //     $c = curl_init(); 
        //     curl_setopt($c, CURLOPT_RETURNTRANSFER, 1); 
        //     curl_setopt($c, CURLOPT_URL, $url); 
        //     $response = curl_exec($c); 
        //     // return $response;
        // }

        // $otpCode = reGenerateNumericOTP(6);

        // $username = "HMTSMS";
        // $password = "hmtp@$";
        // $phone = $data->contactNo;
        // $sms = 'Dear Customer, Your Otp Code Is ' . $otpCode;
        
        // // $senderId="Aruhat"; //sender id is available in your portal
        // $senderId="8809601002706"; //sender id is available in your portal
        
        $newData = (array) $data;
    
        $code = $newData['code'];
        $token = $newData['token'];
        $fingerPrint = $newData['fingerPrint'];

        $dql = "SELECT o.code, DATE_DIFF(CURRENT_DATE(), o.createdTime) as days FROM Otp o WHERE o.code = '$code'";
        $query = $em1->createQuery($dql);
        $checkData = $query->getResult();
        
        $oldOtps = $em1->find('Otp', $code);
        if ($oldOtps != null) {

            if ($oldOtps->getFingerPrint() != $fingerPrint)
                return "false";
                
            if ($oldOtps->getToken() != $token)
                return "false";
                
            if ($checkData[0]['days'] >= 7) {
                // $oldOtps->setOtp($otpCode);
                // $oldOtps->setConfirm("false");
                // $em1->persist($oldOtps);
                // $em1->flush();
                // reSendSMS($username, $password, $phone, $sms, $senderId);
                return "false";
                // return "times-up";
            }

            return "true";
        } else {
            throw new NotFoundException();
        }

    }

    public function findAll() {
        $dql = "SELECT u FROM Role u ORDER BY u.userId ASC";

        $query = getEntityManager()->createQuery($dql);
        $query->setMaxResults(120);
        return $query->getResult();
    }

    public function findAllPaginated($limit, $startIndex) {
        $dql = "SELECT n FROM NewsEvent n ORDER BY n.createdTime DESC";
        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findOne($id) {
        // return $this->findOneBy(array('code' => $id));
        $dql = "SELECT o FROM Otp o WHERE o.code = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

    public function delete($id) {
        $dql = "DELETE NewsEvent n WHERE n.id = $id";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }
      
    // // Main program
    // $n = 6;
    // print_r(generateNumericOTP($n));

}

$otpsRepository = $em->getRepository('Otp');