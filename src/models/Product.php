<?php
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="ProductsRepository")
 * @Table(name="products", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "code", "title" }) } )
 **/
class Product implements JsonSerializable {

    /**
     * @Id
     * @Column(type="integer")
     * @GeneratedValue
     */
    protected $id;

    /**
     * @Column(type="string")
     */
    protected $title;

    /**
     * @Column(type="string")
     */
    protected $code;

    /**
     * @Column(type="float")
     */
    protected $price;

    /**
     * @Column(type="float", name="discount_price")
     */
    protected $discountPrice;

    /**
     * @Column(type="float", name="discount_percentage")
     */
    protected $discountPercentage;

    /**
     * @Column(type="string", name="default_sku_code")
     */
    protected $defaultSkuCode;

    /**
     * @Column(type="string")
     */
    protected $description;

    /**
     * @Column(name = "plain_description", type="string")
     */
    protected $plainDescription;

    /**
     * @Column(name = "description_format", type = "string")
     */
    protected $descriptionFormat;

    /**
     * @Column(type="string")
     */
    protected $status;

    /**
     * @Column(type = "float")
     */
    protected $popularity;

    /**
     * @Column(name = "times_sold", type = "integer")
     */
    protected $timesSold;

    /**
     * @Column(name = "rating", type = "float")
     */
    protected $rating;

    /**
     * @Column(name = "view_count", type = "integer")
     */
     protected $viewCount;

    /** 
	 * @Column(type="string", name="tags") 
	 */
	protected $tags;

    /**
     * @ManyToMany(targetEntity="Lookup")
     */
    protected $lookups;

    /**
     * @OneToMany(targetEntity = "SKU", mappedBy = "product", fetch = "EAGER", cascade={"remove"})
     */
    protected $skus;

    /**
     * @ManyToMany(targetEntity="OttomanFile")
     */
    protected $images;

    /**
     * One Product has One Featured Product.
     * @OneToOne(targetEntity="FeaturedProduct", mappedBy="product")
     */
    private $featured;

    /**
     * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
     */
    protected $createdTime;

    public function __construct() {
        $this->images = new ArrayCollection();
    }

    public function getId() {
        return $this->id;
    }

    public function getTitle() {
        return $this->title;
    }

    public function setTitle($title) {
        $this->title = $title;
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

    public function getDiscountPercentage() {
        return $this->discountPercentage;
    }

    public function setDiscountPercentage($discountPercentage) {
        $this->discountPercentage = $discountPercentage;
    }

    public function getDefaultSkuCode() {
        return $this->defaultSkuCode;
    }

    public function setDefaultSkuCode($defaultSkuCode) {
        $this->defaultSkuCode = $defaultSkuCode;
    }

    public function getDescription() {
        return $this->description;
    }

    public function setDescription($description) {
        $this->description = $description;
    }

    public function getPlainDescription() {
      return $this->plainDescription;
    }

    public function setPlainDescription($plainDescription) {
      $this->plainDescription = $plainDescription;
    }

    public function getDescriptionFormat() {
      return $this->descriptionFormat;
    }

    public function setDescriptionFormat($descriptionFormat) {
      $this->descriptionFormat = $descriptionFormat;
    }

    public function setStatus($status) {
        $this->status = $status;
    }

    public function getStatus() {
        return $this->status;
    }

    public function getPopularity() {
      return $this->popularity;
    }

    public function setPopularity($popularity) {
       $this->popularity = $popularity;
    }

    public function getTimeSlold() {
      return $this->timesSold;
    }

    public function setTimesSold($timesSold) {
       $this->timesSold = $timesSold;
    }

    public function getRating() {
      return $this->rating;
    }

    public function setRating($rating) {
       $this->rating = $rating;
    }

    public function getViewCount() {
      return $this->viewCount;
    }

    public function setViewCount($viewCount) {
       $this->viewCount = $viewCount;
    }

    public function getTags() {
		return $this->tags;
	}
	
	public function setTags($tags) {
		$this->tags = $tags;
	}

    public function getLookups() {
        return $this->lookups;
    }

    public function setLookups($lookups) { // not using
        $this->lookups = $lookups;
    }

    public function addLookup($lookup) {
        $this->lookups[] = $lookup;
    }

    public function getImages() {
        return $this->images;
    }

    public function setImages($images) { // not using
        $this->images = $images;
    }

    public function addImage($image) {
        $this->images[] = $image;
    }

    public function getSkus() {
        return $this->skus;
    }

    public function setSkus($skus) { // not using
        $this->skus = $skus;
    }

    public function addSku($sku) {
        $this->skus[] = $sku;
    }

    public function getFeatured() {
        return $this->featured;
    }

    public function setFeatured($featured) {
        $this->featured = $featured;
    }

    public function removeSku($sku) {
      $this->skus->removeElement($sku);
    }

    public function getCreatedTime() {
        return $this->createdTime;
    }

    public function setCreatedTime($createdTime) {
        $this->createdTime = $createdTime;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {
        $lookupsArray = array();
        foreach ($this->lookups as $lookup) {
            array_push($lookupsArray, $lookup->jsonSerialize());
        }

        $skusArray = array();
        foreach ($this->skus as $sku) {
            array_push($skusArray, $sku->jsonSerialize());
        }
        $imagesArray = array();
        foreach ($this->images as $img) {
            array_push($imagesArray, $img->jsonSerialize());
        }

        $arr = array(
            'id' => $this->id,
            'title' => $this->title,
            'code' => $this->code,
            'price' => $this->price,
            'discountPrice' => $this->discountPrice,
            'discountPercentage' => $this->discountPercentage,
            'defaultSkuCode' => $this->defaultSkuCode,
            'description' => $this->description,
            'status' => $this->status,
            'lookups' => $lookupsArray,
            'skus' => $skusArray,
			'tags' => $this->tags,
            'images' => $imagesArray,
            'createdTime' => $this->createdTime,

        );

        if ($this->featured != null) {
            $arr['featured'] = true;
        }else {
            $arr['featured'] = false;
        }

        return $arr;
    }

    public function shortJsonSerialize() {
        $lookupsArray = array();
        foreach ($this->lookups as $lookup) {
            array_push($lookupsArray, $lookup->jsonSerialize());
        }

        $imagesArray = array();
        foreach ($this->images as $sku) {
            array_push($imagesArray, $sku->jsonSerialize());
        }

        $arr = array(
            'id' => $this->id,
            'title' => $this->title,
            'code' => $this->code,
            'price' => $this->price,
            'discountPrice' => $this->discountPrice,
            'discountPercentage' => $this->discountPercentage,
            'defaultSkuCode' => $this->defaultSkuCode,
            'description' => $this->description,
            'status' => $this->status,
            'lookups' => $lookupsArray,
            'images' => $imagesArray,
			'tags' => $this->tags,
            'createdTime' => $this->createdTime,


        );

        if ($this->featured != null) {
            $arr['featured'] = true;
        }else {
            $arr['featured'] = false;
        }

        return $arr;
    }
}