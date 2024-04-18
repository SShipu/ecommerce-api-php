<?php

/**
* @Entity (repositoryClass="SearchIndicesRepository")
* @Table(name="search_indices")
**/
class SearchIndex implements JsonSerializable {

	/**
	 * @Id 
	 * @OneToOne(targetEntity = "Product")
	 * @JoinColumn(name="product_id", referencedColumnName="id")
	 */
	protected $product;

	/** 
	 * @Column(type="string", name="lookups") 
	 */
	protected $lookups;

	/** 
	 * @Column(type="string", name="lookup_names") 
	 */
	protected $lookupNames;

    /** 
	 * @Column(type="string", name="tags") 
	 */
	protected $tags;

	/** 
	 * @Column(type="string", name="attribute_values") 
	 */
	protected $attributeValues;

	/** 
	 * @Column(type="string", name="attribute_value_names") 
	 */
	protected $attributeValueNames;

	public function __construct($product) {
        $this->product = $product;
    }
	public function getId() {
		return $this->product;
	}

	public function getLookups() {
		return $this->lookups;
	}
	
	public function setLookups($lookups) {
		$this->lookups = $lookups;
	}

	public function getLookupNames() {
		return $this->lookupNames;
	}
	
	public function setLookupNames($lookupNames) {
		$this->lookupNames = $lookupNames;
	}

    public function getTags() {
		return $this->tags;
	}
	
	public function setTags($tags) {
		$this->tags = $tags;
	}

	public function getAttributeValues() {
		return $this->attributeValues;
	}
	
	public function setAttributeValues($attributeValues) {
		$this->attributeValues = $attributeValues;
	}

	public function getAttributeValueNames() {
		return $this->attributeValueNames;
	}
	
	public function setAttributeValueNames($attributeValueNames) {
		$this->attributeValueNames = $attributeValueNames;
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
		return array(
			'product' => $this->product->getId(),
			'lookups' => $this->lookups,
			'lookupNames' => $this->lookupNames,
			'tags' => $this->tags,
			'attributeValues' => $this->attributeValues,
			'attributeValueNames' => $this->attributeValueNames,
		);
	}
}