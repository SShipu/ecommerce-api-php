<?php
// use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="ContactUsRepository")
 * @Table(name="contact_us")
 **/
class ContactUs implements JsonSerializable {

    /** 
     * @Id @Column(type="integer") 
     * @GeneratedValue
    */
    protected $id;

    /** 
     * @Column(type="string")
    */
    protected $name;

    /** 
     * @Column(type="string")
    */
    protected $email;

    /**
     * @Column(type="string", name="contact_no")
     */
    protected $contactNo;

    /** 
     * @Column(type="string", name="address")
     */
    protected $address;

    /**
     * @Column(type="string", name="message")
     */
    protected $message;

    /**
     * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
     */
    protected $createdTime;


    public function __construct() {
    }

    public function getId() {
        return $this->id;
    }

    public function getName() {
        return $this->name;
    }
    
    public function setName($name) {
        $this->name = $name;
    }

    public function getEmail() {
        return $this->email;
    }
        
    public function setEmail($email) {
        $this->email = $email;
    }

    public function getAddress() {
        return $this->address;
    }
        
    public function setAddress($address) {
        $this->address = $address;
    }
        
    public function getMessage() {
        return $this->message;
    }

    public function setMessage($message) {
        $this->message = $message;
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
            'id' => $this->id,
            'name' => $this->name,
            'email' => $this->email,
            'address' => $this->address,
            'message' => $this->message,
            'contactNo' => $this->contactNo,
            'createdTime' => $this->createdTime,
        );
    }
}