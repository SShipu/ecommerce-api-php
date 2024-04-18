<?php

/**
 * @Entity (repositoryClass="MfgOrdersV2Repository")
 * @Table(name="mfg_order_items_v2")
 **/
class MfgOrderItemV2 implements JsonSerializable {

    /**
     * @Id
     * @ManyToOne(targetEntity = "MfgOrderV2", fetch = "EAGER", inversedBy = "items")
     * @JoinColumn(name = "mfg_order_item_id", referencedColumnName = "id")
     */
    protected $mfgOrder;

    /**
     * @Id
     * @ManyToOne(targetEntity = "SKU", fetch = "EAGER")
     * @JoinColumn(name = "sku_code", referencedColumnName = "code")
     */
    protected $sku;

    /**
     * @Id
     * @Column(type="integer")
     */
    protected $seq;

  	/**
  	 * @Column(name = "quantity", type = "float")
  	 */
    protected $quantity;

  	public function __construct($mfgOrder, $sku, $seq) {
		$this->mfgOrder = $mfgOrder;
		$this->sku = $sku;
        $this->seq = $seq;
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