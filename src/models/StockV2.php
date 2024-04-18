<?php

/**
 * @Entity (repositoryClass="StocksV2Repository")
 * @Table(name="stocks_v2", uniqueConstraints={ @UniqueConstraint(name="unique_sku_branch", columns={ "sku_code", "branch_id" }) }  )
 **/
class StockV2 implements JsonSerializable {
    /**
     * @Id
     * @ManyToOne(targetEntity = "SKU")
     * @JoinColumn(name = "sku_code", referencedColumnName = "code")
     */
    protected $sku;

    /**
     * @Id
     * @ManyToOne(targetEntity="Branch")
     * @JoinColumn(name="branch_id", referencedColumnName="id")
     */
    protected $branch;

    /**
     * @Column(type="integer", name="total")
     */
    protected $total;

    /**
     * @Column(type="integer")
     */
    protected $damaged;

    /**
     * @Column(type="integer", name="on_hold")
     */
    protected $onHold;

    /** 
     * @Column(type="integer", name="sales_booked") 
     */
    protected $salesBooked;

    public function __construct($sku, $branch) {
        $this->sku = $sku;
        $this->branch = $branch;
    }

    public function getBranch() {
      return $this->branch;
    }

    public function setBranch($branch) {
      $this->branch = $branch;
    }

    public function getSku() {
      return $this->sku;
    }

    public function setSku($sku) {
      $this->sku = $sku;
    }

    public function getTotal() {
        return $this->total;
    }

    public function setTotal($total) {
        $this->total = $total;
    }

    public function getDamaged() {
        return $this->damaged;
    }

    public function setDamaged($damaged) {
        $this->damaged = $damaged;
    }

    public function getOnHold() {
        return $this->onHold;
    }

    public function setOnHold($onHold) {
        $this->onHold = $onHold;
    }

    public function getSalesBooked() {
        return $this->salesBooked;
    }

    public function setSalesBooked($salesBooked) {
        $this->salesBooked = $salesBooked;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {
        return array(
            'total' => $this->total,
            'damaged' => $this->damaged,
            'onHold' => $this->onHold,
            'salesBooked' => $this->salesBooked,
            'branch' => $this->branch->jsonSerialize(),
            'sku' => $this->sku->shortJsonSerialize()
        );
    }
}