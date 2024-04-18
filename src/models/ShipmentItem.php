<?php

/**
 * @Entity (repositoryClass="ShipmentItemsRepository")
 * @Table(name="shipment_items")
 **/
class ShipmentItem implements JsonSerializable {

    /**
     * @Id
     * @ManyToOne(targetEntity = "Shipment", fetch = "EAGER", inversedBy = "items")
     * @JoinColumn(name = "shipment_id", referencedColumnName = "id")
     */
    protected $shipment;

    /**
     * @Id
     * @Column(type="integer")
     */
    protected $seq;

    /**
     * @ManyToOne(targetEntity = "SKU")
     * @JoinColumn(name = "sku_code", referencedColumnName = "code")
     *
     */
    protected $sku;

    /**
     * @Column(type="float", name = "quantity")
     */
    protected $quantity;

    public function __construct($seq, $shipment) {
        $this->seq = $seq;
        $this->shipment = $shipment;
    }

    public function getSeq() {
        return $this->seq;
    }

    public function setSeq($seq) {
        $this->seq = $seq;
    }

    public function getSku() {
        return $this->sku;
    }

    public function setSku($sku) {
        $this->sku = $sku;
    }

    public function getQuantity() {
        return $this->quantity;
    }

    public function setQuantity($quantity) {
        $this->quantity = $quantity;
    }

    public function getShipment() {
      return $this->shipment;
    }

    public function setShipment($shipment) {
      $this->shipment = $shipment;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {

        return array(
            'seq' => $this->seq,
            'shipmentId' => $this->shipment->getId(),
            'quantity' => $this->quantity,
            'sku' => $this->sku->shortJsonSerialize(),

        );
    }
}