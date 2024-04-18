<?php

/**
 * @Entity (repositoryClass="MfgOrdersV2Repository")
 * @Table(name="mfg_order_states_v2")
 **/

class MfgOrderStateV2 implements JsonSerializable {

    /**
     * @Id
     * @ManyToOne(targetEntity = "MfgOrderV2", fetch = "EAGER", inversedBy = "states")
     * @JoinColumn(name = "mfg_order_id", referencedColumnName = "id")
     */
    protected $mfgOrder;

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

	public function __construct($mfgOrder, $stateName) {
		$this->mfgOrder = $mfgOrder;
		$this->stateName = $stateName;
	}

	public function getMfgOrder() {
			return $this->mfgOrder;
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