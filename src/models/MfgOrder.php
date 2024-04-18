<?php
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="MfgOrdersRepository")
 * @Table(name="mfg_orders", uniqueConstraints={ @UniqueConstraint(name="unique_code", columns={ "id" }) } )
 **/
class MfgOrder implements JsonSerializable {

    /**
     * @Id
     * @Column(type="string")
     */
    protected $id;

    /**
     * @Column(name = "current_state", type = "string")
     */
    protected $currentState;

    /**
     * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
     */
    protected $createdTime;

    /**
     * @OneToMany(targetEntity="MfgOrderState", mappedBy="mfgOrder")
     */
    protected $states;
    
    /**
     * @ManyToOne(targetEntity = "MfgOrderSet")
     * @JoinColumn(name = "set_id", referencedColumnName = "id")
     */
    protected $set;

    /**
     * @ManyToOne(targetEntity="Branch")
     * @JoinColumn(name = "branch_id", referencedColumnName = "id")
     */
    protected $branch;

    public function __construct() {
        $this->states = new ArrayCollection();
    }

    public function getId() {
        return $this->id;
    }

    public function setId($id) {
        $this->id = $id;
    }

    public function getCurrentState() {
        return $this->currentState;
    }

    public function setCurrentState($currentState) {
        $this->currentState = $currentState;
    }

    public function getCreatedTime() {
        return $this->createdTime;
    }

    public function setCreatedTime($createdTime) {
        $this->createdTime = $createdTime;
    }

    public function getSet() {
            return $this->set;
    }

    public function setSet($set) {
            $this->set = $set;
    }

    public function getStates() {
        return $this->states;
    }

    public function setStates($states) {
        $this->states = $states;
    }

    public function addState($state) {
        $this->states[] = $state;
    }

    public function getBranch() {
        return $this->branch;
    }

    public function setBranch($branch) {
        return $this->branch = $branch;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {
        $arr = array(
            'id' => $this->id,
            'currentState' => $this->currentState,
            'createdTime' => $this->createdTime,
        );
        if ($this->branch != null) {
            $arr['branch'] = $this->branch->jsonSerialize();
        }
        if ($this->set != null) {
            $arr['set'] = $this->set->jsonSerialize();
        }
        return $arr;
    }
}