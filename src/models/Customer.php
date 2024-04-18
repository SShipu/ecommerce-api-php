<?php
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="CustomersRepository")
 * @Table(name="customers", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "name" }) } )
 **/
class Customer implements JsonSerializable {

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
     * @Column(type="string", name="address")
    */
    protected $address;

    /**
     * @ManyToMany(targetEntity="Branch")
     */
    protected $branches;

    /**
     * @Column(type="string", name="contact_no")
     */
    protected $contactNo;

    public function __construct() {
        $this->branches = new ArrayCollection();
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
        
    public function getBranches() {
        return $this->branches;
    }

    public function setBranches($branches) {
        $this->branches = $branches;
    }

    public function addBranch($branch) {
        $this->branches[] = $branch;
    }

    public function getContactNo() {
        return $this->contactNo;
    }

    public function setContactNo($contactNo) {
        $this->contactNo = $contactNo;
    }
        
    public function jsonSerialize() {
            
        $branchValues = array();
        foreach ($this->branches as $branch) {
            array_push($branchValues, $branch->jsonSerialize());
        }

        return array(
            'id' => $this->id,
            'name' => $this->name,
            'email' => $this->email,
            'address' => $this->address,
            'branches' => $branchValues,
            'contactNo' => $this->contactNo,
        );
    }
}