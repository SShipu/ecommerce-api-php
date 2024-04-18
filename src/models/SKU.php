<?php

use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="SKUsRepository")
 * @Table(name="skus", uniqueConstraints={ @UniqueConstraint(name = "unique_code", columns= { "code" } ) } )
 **/
class SKU implements JsonSerializable {

    /**
     * @Id
     * @Column(type="string", name="code")
     */
    protected $code;

    /**
     * @Column(type="float")
     */
    protected $price;

    /**
     * @Column(type="float")
     */
    protected $discountPrice;

    /**
     * @Column(type="string") *
     */
    protected $label;

    /**
     * @Column(type="boolean")
     */
    protected $lapse;

    /**
     * @ManyToMany(targetEntity="ItemAttributeValue", fetch = "EAGER", cascade={"remove"})
     * @JoinTable(
     *     name = "sku_attribute_values",
     *     joinColumns={ @JoinColumn(name="sku_code", referencedColumnName= "code") },
     *     inverseJoinColumns={ @JoinColumn(name="attribute_value_id", referencedColumnName="id") } )
     */
    protected $attributeValues;

    /**
     * @ManyToOne(targetEntity = "Product", inversedBy="skus", fetch = "EAGER")
     * @JoinColumn(name="product_id", referencedColumnName="id")
     */
    protected $product;

    /**
     * @OneToMany(targetEntity = "StockV2", mappedBy="sku", fetch = "EAGER")
     */
    protected $stocks;


    public function __construct() {
        $this->attributeValues = new ArrayCollection();
        $this->stocks = new ArrayCollection();
    }

    public function getCode() {
        return $this->code;
    }

    public function setCode($code) {
        $this->code = $code;
    }

    public function getPrice() {
        return $this->price;
    }

    public function setPrice($price) {
        $this->price = $price;
    }

    public function getDiscountPrice() {
        return $this->discountPrice;
    }

    public function setDiscountPrice($discountPrice) {
        $this->discountPrice = $discountPrice;
    }

    public function getLabel() {
        return $this->label;
    }

    public function setLabel($label) {
        $this->label = $label;
    }

    public function getLapse() {
        return $this->lapse;
    }

    public function setLapse($lapse) {
        $this->lapse = $lapse;
    }

    public function getAttributeValues() {
        return $this->attributeValues;
    }

    public function setAttributeValues($attributeValues) {
        $this->attributeValues = $attributeValues;
    }

    public function addAttributeValue($attributeValue) {
        $this->attributeValues[] = $attributeValue;
    }

    public function getProduct() {
        return $this->product;
    }

    public function setProduct($product) {
        $this->product = $product;
    }

    public function getStocks() {
      return $this->stocks;
    }

    public function setStocks($stocks) {
      $this->stocks = $stocks;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function longJsonSerialize() {

        $attributeVals = array();
        foreach ($this->attributeValues as $attributeVal) {
            array_push($attributeVals, $attributeVal->jsonSerialize());
        }

        $stocks = array();
        foreach ($this->stocks as $stock) {
            array_push($stocks, $stock->jsonSerialize());
        }

        return array(
            'code' => $this->code,
            'price' => $this->price,
            'discountPrice' => $this->discountPrice,
            'label' => $this->label,
            'attributeValues' => $attributeVals,
            'lapse' => $this->lapse,
            'product' => $this->product,
            'stocks' => $stocks
        );
    }

    public function jsonSerialize() {

        $attributeVals = array();
        foreach ($this->attributeValues as $attributeVal) {
            array_push($attributeVals, $attributeVal->jsonSerialize());
        }

        $stocks = array();
        foreach ($this->stocks as $stock) {
            array_push($stocks, $stock->jsonSerialize());
        }

        return array(
            'code' => $this->code,
            'price' => $this->price,
            'discountPrice' => $this->discountPrice,
            'label' => $this->label,
            'attributeValues' => $attributeVals,
            'lapse' => $this->lapse,
            'stocks' => $stocks,
        );
    }
    public function shortJsonSerialize() {

        $attributeVals = array();
        foreach ($this->attributeValues as $attributeVal) {
            array_push($attributeVals, $attributeVal->jsonSerialize());
        }
        
        return array(
            'code' => $this->code,
            'price' => $this->price,
            'discountPrice' => $this->discountPrice,
            'label' => $this->label,
            'attributeValues' => $attributeVals,
            'lapse' => $this->lapse,
            'product' => $this->product->shortJsonSerialize()
        );
    }

    public function hasEnoughStock($quantity, $branchId) {
        foreach($this->stocks as $stock) {
            if ($stock->getBranch() != null && $stock->getBranch()->getId() == $branchId) {
                return $stock->getTotal() >= $quantity;
            }
        }
        return FALSE;
    }

    public function isProperPrice($price) {
        return $price == $this->discountPrice || $this->price == $price;
    }
}