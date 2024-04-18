<?php

/**
 * @Entity (repositoryClass="MfgOrderItemsRepository")
 * @Table(name="mfg_order_items")
 **/
class MfgOrderItem implements JsonSerializable {

    /**
     * @Id
     * @ManyToOne(targetEntity = "MfgOrderSet", fetch = "EAGER", inversedBy = "items")
     * @JoinColumn(name = "set_id", referencedColumnName = "id")
     */
    protected $set;

    /**
     * @Id
     * @Column(type="integer")
     */
    protected $seq;

	/**
	 * @Column(name = "quantity", type = "float")
	 */
	protected $quantity;

    /**
	 * @ManyToOne(targetEntity = "SKU")
	 * @JoinColumn(name = "sku_code", referencedColumnName = "code")
	 */
    protected $sku;

	public function __construct($set, $seq) {
			$this->set = $set;
			$this->seq = $seq;
	}

	public function getSet() {
			return $this->set;
	}

	public function setSet($set) {
			$this->set = $set;
	}

	public function getSeq() {
			return $this->seq;
	}

	public function setSeq($seq) {
			$this->seq = $seq;
	}

	public function getQuantity() {
			return $this->quantity;
	}

	public function setQuantity($quantity) {
			$this->quantity = $quantity;
	}

	public function getSku() {
			return $this->sku;
	}

	public function setSku($sku) {
			$this->sku = $sku;
	}


	public function jsonSerialize() {
			return array(
					'seq' => $this->seq,
					'quantity' => $this->quantity,
					'sku' => $this->sku->shortJsonSerialize()
			);
	}
}