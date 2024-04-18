<?php

/**
 * @Entity (repositoryClass="InvoiceItemsRepository")
 * @Table(name="invoice_items")
 **/
class InvoiceItem implements JsonSerializable {

    /**
     * @Id
     * @ManyToOne(targetEntity = "Invoice", fetch = "EAGER", inversedBy = "items")
     * @JoinColumn(name = "invoice_id", referencedColumnName = "id")
     */
    protected $invoice;

    /**
     * @Id
     * @Column(type="integer")
     */
    protected $seq;

    /** 
     * @Column(type="string", name="sku") 
     */
    protected $sku;

    /**
     * @Column(type="float")
     */
    protected $price;

    /**
     * @Column(type="float")
     */
    protected $quantity;

    /**
     * @Column(type="float", name = "sub_total")
     */
    protected $subTotal;

    /**
     * @Column(type="string")
     */
    protected $title;

    /**
     * @Column(type="string", name = "image_url", nullable=true)
     */
    protected $mainImageUrl;

    public function __construct($seq, $invoice) {
        $this->seq = $seq;
        $this->invoice = $invoice;
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

    public function getPrice() {
        return $this->price;
    }

    public function setPrice($price) {
        $this->price = $price;
    }

    public function getQuantity() {
        return $this->quantity;
    }

    public function setQuantity($quantity) {
        $this->quantity = $quantity;
    }

    public function getSubTotal() {
        return $this->subTotal;
    }

    public function setSubTotal($subTotal) {
        $this->subTotal = $subTotal;
    }

    public function getTitle() {
        return $this->title;
    }

    public function setTitle($title) {
        $this->title = $title;
    }

    public function getMainImageUrl() {
        return $this->mainImageUrl;
    }

    public function setMainImageUrl($mainImageUrl) {
        $this->mainImageUrl = $mainImageUrl;
    }

    public function getInvoice() {
      return $this->invoice;
    }

    public function setInvoice($invoice) {
      $this->invoice = $invoice;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {
        return array(
            'seq' => $this->seq,
            'invoiceId' => $this->invoice->getId(),
            'sku' => $this->sku,
            'title' => $this->title,
            'subTotal' => $this->subTotal,
            'price' => $this->price,
            'quantity' => $this->quantity,
            'mainImageUrl' => $this->mainImageUrl,
        );
    }
}