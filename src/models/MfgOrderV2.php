<?php
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="MfgOrdersV2Repository")
 * @Table(name="mfg_orders_v2", uniqueConstraints={ @UniqueConstraint(name="unique_code", columns={ "id" }) } )
 **/
class MfgOrderV2 implements JsonSerializable {
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
     * @OneToMany(targetEntity="MfgOrderStateV2", mappedBy="mfgOrder")
     */
    protected $states;

    /**
     * @OneToMany(targetEntity = "MfgOrderItemV2", mappedBy = "mfgOrder")
     */
    protected $items;

    /**
     * @OneToMany(targetEntity = "ShipmentV2", mappedBy = "mfgOrder")
     */
    protected $shipments;

    /**
     * @ManyToOne(targetEntity="Branch")
     * @JoinColumn(name = "branch_id", referencedColumnName = "id")
     */
    protected $branch;

    public function __construct() {
        $this->states = new ArrayCollection();
        $this->items = new ArrayCollection();
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

    public function getItems() {
            return $this->items;
    }

    public function setItems($items) {
            $this->items = $items;
    }

     public function getShipments() {
            return $this->shipments;
    }

    public function setShipments($shipments) {
            $this->shipments = $shipments;
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
        $items = array();
        foreach($this->items as $item) {
            array_push($items, $item->jsonSerialize());
        }

        $shipments = array();
        foreach($this->shipments as $shipment) {
            array_push($shipments, $shipment->jsonSerialize());
        }

        $states = array();
        foreach($this->states as $state) {
            array_push($states, $state->jsonSerialize());
        }
        
        $arr = array(
            'id' => $this->id,
            'currentState' => $this->currentState,
            'createdTime' => $this->createdTime,
            'states' => $states,
        );
        if ($this->branch != null) {
            $arr['branch'] = $this->branch->jsonSerialize();
        }
        if ($this->items != null) {
            $arr['items'] = $items;
        }
        if ($this->shipments != null) {
            $arr['shipments'] = $shipments;
        }
        return $arr;
    }
}