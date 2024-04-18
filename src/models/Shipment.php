<?php

use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="ShipmentsRepository")
 * @Table(name="shipments", uniqueConstraints={ @UniqueConstraint(name="unique_code", columns={ "id" }) } )
 **/
class Shipment implements JsonSerializable {

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
     * @Column(name = "status", type="string")
     */
     protected $status;

    /**
     * @Column(name="dispatch_date", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
     */
    protected $dispatchDate;

    /**
     * @Column(name="receive_date", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable="true")
     */
    protected $receiveDate;

    /**
     * @OneToMany(targetEntity="ShipmentItem", mappedBy="shipment")
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

    public function getStatus() {
        return $this->status;
    }

    public function setStatus($status) {
        $this->status = $status;
    }

    public function getDispatchDate()
    {
        return $this->dispatchDate;
    }

    public function setDispatchDate($dispatchDate)
    {
        $this->dispatchDate = $dispatchDate;
    }

    public function getReceiveDate()
    {
        return $this->receiveDate;
    }

    public function setReceiveDate($receiveDate)
    {
        $this->receiveDate = $receiveDate;
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

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {

        $items = array();
        foreach($this->items as $item) {
            array_push($items, $item->jsonSerialize());
        }

        return array(
            'id' => $this->id,
            'sourceBranch' => $this->sourceBranch,
            'destinationBranch' => $this->destinationBranch,
            'dispatchDate' => $this->dispatchDate,
            'receiveDate' => $this->receiveDate,
            'status' => $this->status,
            'items' => $items,
        );
    }
}