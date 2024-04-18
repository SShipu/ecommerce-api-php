<?php

use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="ShipmentsV2Repository")
 * @Table(name="shipments_v2", uniqueConstraints={ @UniqueConstraint(name="unique_code", columns={ "id" }) } )
 **/
class ShipmentV2 implements JsonSerializable {

    /**
     * @Id
     * @Column(type="string")
     */
    protected $id;

    /**
     * @Column(name = "type", type = "string")
     */
    protected $type;

    /**
     * @Column(name = "current_state", type="string")
     */
     protected $currentState;

     /**
      * @OneToMany(targetEntity="ShipmentStateV2", mappedBy="shipment")
      */
     protected $states;

    /**
     * @OneToMany(targetEntity="ShipmentItemV2", mappedBy="shipment")
     */
    protected $items;

    /**
     * @ManyToOne(targetEntity="Branch")
     * @JoinColumn(name = "source_branch_id", referencedColumnName = "id")
     */
    protected $sourceBranch;

    /**
     * @ManyToOne(targetEntity="Branch")
     * @JoinColumn(name = "destination_branch_id", referencedColumnName = "id")
     */
    protected $destinationBranch;

    /**
     * @ManyToOne(targetEntity="MfgOrderV2")
     * @JoinColumn(name = "mfg_order_id", referencedColumnName = "id")
     */
    protected $mfgOrder;

    /**
     * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
     */
    protected $createdTime;


    public function __construct() {
        $this->items = new ArrayCollection();
    }

    public function getId() {
        return $this->id;
    }

    public function setId($id) {
        $this->id = $id;
    }

    public function getType() {
        return $this->type;
    }

    public function setType($type) {
        $this->type = $type;
    }

    public function getCurrentState() {
        return $this->currentState;
    }

    public function setCurrentState($currentState) {
        $this->currentState = $currentState;
    }

    public function getStates() {
        return $this->States;
    }

    public function setStates($States) {
        $this->States = $States;
    }

    public function getItems() {
        return $this->items;
    }

    public function setItems($items) {
        $this->items = $items;
    }

    public function addItem($item) {
        $this->items[] = $item;
    }

    public function getSourceBranch() {
        return $this->sourceBranch;
    }

    public function setSourceBranch($sourceBranch) {
        return $this->sourceBranch = $sourceBranch;
    }

    public function getDestinationBranch() {
        return $this->destinationBranch;
    }

    public function setDestinationBranch($destinationBranch) {
        return $this->destinationBranch = $destinationBranch;
    }

    public function setOrder($order) {
        $this->mfgOrder = $order;
    }

    public function getOrder() {
        return $this->mfgOrder;
    }

    public function getCreatedTime() {
        return $this->createdTime;
    }

    public function setCreatedTime($createdTime) {
        $this->createdTime = $createdTime;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {

        $items = array();
        foreach($this->items as $item) {
            array_push($items, $item->jsonSerialize());
        }

        $states = array();
        foreach($this->states as $state) {
            array_push($states, $state->jsonSerialize());
        }

        return array(
            'id' => $this->id,
            'sourceBranch' => $this->sourceBranch,
            'destinationBranch' => $this->destinationBranch,
            'currentState' => $this->currentState,
            'createdTime' => $this->createdTime,
            'states' => $states,
            'items' => $items,
        );
    }
}