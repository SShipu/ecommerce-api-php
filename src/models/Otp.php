<?php
    // use Doctrine\Common\Collections\ArrayCollection;

	/**
	* @Entity (repositoryClass="OtpsRepository")
	* @Table(name="otps", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "code" }) } )
	**/
	class Otp implements JsonSerializable {

        /**
         * @Id
         * @Column(type="string", name="code")
         */
        protected $code;

		/**
         * @Column(type="string", nullable=true)   
        */
        protected $token;

        /**
         * @Column(type="string", name="finger_print")   
        */
        protected $fingerPrint;

        /**
         * @Column(type="string")
         */
        protected $otp;

        /**
         * @Column(type="string")
         */
        protected $confirm;

        /**
         * @Column(type="string", name="contact_no")
         */
        protected $contactNo;

        /**
         * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
         */
        protected $createdTime;
        
        // public function __construct() {
        // }

		// public function getId() {
		// 	return $this->id;
		// }

        public function getCode() {
            return $this->code;
        }
    
        public function setCode($code) {
            $this->code = $code;
        }

        public function getToken() {
            return $this->token;
        }
    
        public function setToken($token) {
            $this->token = $token;
        }

        public function getFingerPrint() {
            return $this->fingerPrint;
        }
    
        public function setFingerPrint($fingerPrint) {
            $this->fingerPrint = $fingerPrint;
        }

        public function getOtp() {
            return $this->otp;
        }
    
        public function setOtp($otp) {
            $this->otp = $otp;
        }

        public function getConfirm() {
            return $this->confirm;
        }
    
        public function setConfirm($confirm) {
            $this->confirm = $confirm;
        }

        public function getContactNo() {
            return $this->contactNo;
        }
    
        public function setContactNo($contactNo) {
            $this->contactNo = $contactNo;
        }
        
        public function getCreatedTime() {
            return $this->createdTime;
        }
    
        public function setCreatedTime($createdTime) {
            $this->createdTime = $createdTime;
        }

		public function jsonSerialize() {

			return array(
				// 'id' => $this->id,
				'code' => $this->code,
				'token' => $this->token,
				'fingerPrint' => $this->fingerPrint,
				'otp' => $this->otp,
                'confirm' => $this->confirm,
                'contactNo' => $this->contactNo,
                'createdTime' => $this->createdTime,
			);
		}
	}