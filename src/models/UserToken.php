<?php
// src/UserToken.php

// use Doctrine\Common\Collections\ArrayCollection;

 /**
 * @Entity (repositoryClass="UserTokensRepository")
 * @Table(name="user_tokens")
 **/

class UserToken implements JsonSerializable{

    /** @Id @Column(type="integer") @GeneratedValue **/
    protected $id;

    /** @Column(type="integer", name="user_id") **/
    protected $userId;

    /** @Column(type="string", name="user_token") **/
    protected $token;

    // * @Column(type="timestamp") 
    /** 
     * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"})
     */
    protected $createdTime;

    public function getUserId()
    {
        return $this->userId;
    }

    public function setUserId($userId)
    {
        $this->userId = $userId;
    }

    public function getToken()
    {
        return $this->token;
    }

    public function setToken($token)
    {
        $this->token = $token;
    }

    public function getCreatedTime()
    {
        return $this->createdTime;
    }

    public function setCreatedTime($createdTime)
    {
        $this->createdTime = $createdTime;
    }

    public function jsonSerialize() {
        return array(
            'id' => $this->id,
            'userId' => $this->userId,
            'token' => $this->token,
            'createdTime' => $this->createdTime
        );
    }
}