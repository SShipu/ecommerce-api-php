<?php
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="UsersRepository")
 * @Table(name="users", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "user_name" }) } )
 **/
class User implements JsonSerializable
{

    /** 
     * @Id @Column(type="integer") 
     * @GeneratedValue 
     */
    protected $id;

    /** 
     * @Column(type="string", name="user_name") 
     */
    protected $userName;

    /** 
     * @Column(type="string", name="full_name") 
     */
    protected $fullName;

    /** 
     * @Column(type="string") 
     */
    protected $email;

    /** 
     * @Column(type="string") 
     */
    protected $password;

    /**
     * Many User have Many Roles.
     * @ManyToMany(targetEntity="Role")
     */
    protected $roles;

    /** 
     * @Column(type="string") 
     */
    protected $status;

    /**
     * @ManyToMany(targetEntity="Branch")
     */
    protected $branches;

    /**
     * @Column(type="string", name="contact_no")
     */
    protected $contactNo;

    public function __construct() {
        $this->roles = new ArrayCollection();
        $this->branches = new ArrayCollection();
    }

    public function getId() {
        return $this->id;
    }

    public function getUserName() {
        return $this->userName;
    }

    public function setUserName($userName) {
        $this->userName = $userName;
    }

    public function getFullName() {
        return $this->fullName;
    }
    public function setFullName($fullName) {
        $this->fullName = $fullName;
    }

    public function getEmail() {
        return $this->email;
    }
    public function setEmail($email) {
        $this->email = $email;
    }

    public function getPassword() {
        return $this->password;
    }
    public function setPassword($password) {
        $this->password = $password;
    }

    public function getRoles() {
        return $this->roles;
    }
    public function setRoles($roles) {
        $this->roles = $roles;
    }

    public function addRole($role) {
        $this->roles[] = $role;
    }

    public function getStatus() {
        return $this->status;
    }
    public function setStatus($status) {
        $this->status = $status;
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
        $roleValues = array();
        foreach ($this->roles as $role) {
            // $valArray = array('value' => $val->getValue(), 'id' => $val->getId(), 'extra' => $val->getExtra());
            array_push($roleValues, $role->jsonSerialize());
        }

        $branchValues = array();
        foreach ($this->branches as $branch) {
            // $valArray = array('value' => $val->getValue(), 'id' => $val->getId(), 'extra' => $val->getExtra());
            array_push($branchValues, $branch->jsonSerialize());
        }

        return array(
            'id' => $this->id,
            'userName' => $this->userName,
            'fullName' => $this->fullName,
            'email' => $this->email,
            'password' => $this->password,
            'roles' => $roleValues,
            'status' => $this->status,
            'branches' => $branchValues,
            'contactNo' => $this->contactNo,
        );
    }
}