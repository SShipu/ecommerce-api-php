<?php

/**
 * @Entity (repositoryClass="ShipmentsRepository")
 * @Table(name="shipment_states_v2")
 **/

class ShipmentStateV2 implements JsonSerializable {

    /**
     * @Id
     * @ManyToOne(targetEntity = "ShipmentV2", fetch = "EAGER", inversedBy = "states")
     * @JoinColumn(name = "shipment_id", referencedColumnName = "id")
     */
    protected $shipment;

  	/**
  	 * @Id
  	 * @Column(type="string", name="state_name")
  	 */
    protected $stateName;

	  /**
     * @ManyToOne(targetEntity = "User")
     * @JoinColumn(name = "performed_by_user_id", referencedColumnName = "id")
     */
    protected $performedBy;

	   /**
     * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
     */
    protected $createdTime;

  	public function __construct($shipment, $stateName) {
  		$this->shipment = $shipment;
  		$this->stateName = $stateName;
  	}

	public function getShipment() {
			return $this->shipment;
	}

	public function setMfgOrder($mfgOrder) {
			$this->mfgOrder = $mfgOrder;
	}

	public function getStateName() {
	return $this->stateName;
	}

	public function setStateName($stateName) {
		$this->stateName = $stateName;
	}

	public function getPerformedBy() {
	return $this->performedBy;
	}

	public function setPerformedBy($performedBy) {
		$this->performedBy = $performedBy;
	}

	public function getCreatedTime() {
		return $this->createdTime;
	}

	public function setCreatedTime($createdTime) {
		$this->createdTime = $createdTime;
	}

	public function jsonSerialize() {
		return array(
			'stateName' => $this->stateName,
			'performedBy' => $this->performedBy,
			'createdTime' => $this->createdTime,
		);
	}
}