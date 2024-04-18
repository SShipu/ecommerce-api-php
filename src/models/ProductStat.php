<?php
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="ProductStatsRepository")
 * @Table(name="product_stats")
 **/
class ProductStat implements JsonSerializable {

    /**
     * @Id
     * @ManyToOne(targetEntity = "SKU", fetch = "EAGER")
     * @JoinColumn(name = "sku_code", referencedColumnName = "code")
     */
    protected $sku;

    /**
     * @Id
     * @Column(name="date", type="string", nullable=false)
     */
    protected $date;

    /**
     * @Id
     * @ManyToOne(targetEntity="Branch")
     * @JoinColumn(name = "branch_id", referencedColumnName = "id")
     */
    protected $branch;

    /**
     * @Column(type="integer", name = "counter")
     */
    protected $counter;

    /**
     * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
     */
    protected $createdTime;

    /**
     * @Column(name="source", type="string")
     */
    protected $source;

    /**
     * @ManyToOne(targetEntity = "Product", fetch = "EAGER")
     * @JoinColumn(name="product_id", referencedColumnName="id")
     */
    protected $product;

    public function __construct($sku, $date, $branch) {
		$this->sku = $sku;
		$this->date = $date;
		$this->branch = $branch;
  	}

    public function setSku($sku) {
        $this->sku = $sku;
    }
    
    public function getSku() {
        return $this->sku;
    }

    public function addSku($sku) {
        $this->sku[] = $sku;
    }

    public function removeSku($sku) {
      $this->sku->removeElement($sku);
    }

    public function getDate() {
        return $this->date;
    }

    public function setDate($date) {
        $this->date = $date;
    }

    public function getSource() {
        return $this->source;
    }

    public function setSource($source) {
        $this->source = $source;
    }

    public function getCounter() {
        return $this->counter;
    }

    public function setCounter($counter) {
        return $this->counter = $counter;
    }

    public function getCreatedTime() {
        return $this->createdTime;
    }

    public function setCreatedTime($createdTime) {
        $this->createdTime = $createdTime;
    }

    public function getProduct() {
			return $this->product;
    }

    public function setProduct($product) {
        $this->product = $product;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {
        // $skusArray = array();
        // foreach ($this->sku as $sku) {
        //     array_push($skusArray, $sku);
        // }

        return array(
            
            'source' => $this->source,
            'date' => $this->date,
            'sku' => $this->sku,
            'counter' => $this->counter,
            'createdTime' => $this->createdTime,
            'product' => $this->product,
        );
        if ($this->branch != null) {
            $arr['branch'] = $this->branch->jsonSerialize();
        }
    }
}