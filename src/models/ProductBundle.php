<?php
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="ProductBundlesRepository")
 * @Table(name="product_bundles", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "name" }) } )
 **/
class productBundle implements JsonSerializable
{
    /** 
     * @Id @Column(type="integer") 
     * @GeneratedValue 
     */
    protected $id;

    /** 
     * @Column(type="string") 
     */
    protected $name;

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
     * @ManyToMany(targetEntity="Product")
     */
    protected $products;

    /**
     * @ManyToMany(targetEntity="OttomanFile")
     */
    protected $images;

    /** 
     * @Column(type="boolean", options={"defaut": "0"}) 
     */
    private $special;

    public function __construct() {
        $this->products = new ArrayCollection();
    }

    public function getId() {
        return $this->id;
    }

    public function getName() {
        return $this->name;
    }

    public function setName($name) {
        $this->name = $name;
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

    public function getProducts() {
        return $this->products;
    }

    public function setProducts($products) { 
        $this->products = $products;
    }

    public function addProduct($product) {
        $this->products[] = $product;
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

    public function getSpecial() {
        return $this->special;
    }

    public function setSpecial($special) {
        $this->special = $special;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {
        $products = array();
        foreach ($this->products as $prod) {
            // $prodArray = array('id' => $prod->getId(), 'name' => $prod->getTitle(), 'price' => $prod->getPrice(), 'sku' => $prod->getSkus(), 'images' => $prod->getImages());
            // array_push($products, $prodArray);
            array_push($products, $prod);
        }
        $imagesArray = array();
        foreach ($this->images as $img) {
            array_push($imagesArray, $img->jsonSerialize());
        }
        return array(
            'id' => $this->id,
            'name' => $this->name,
            'price' => $this->price,
            'discountPrice' => $this->discountPrice,
            'discountPercentage' => $this->discountPercentage,
            'special' => $this->special,
            'products' => $products,
            'images' => $imagesArray,
        );
    }

    public function shortJsonSerialize() {
        return array(
            'id' => $this->id,
            'name' => $this->name,
            'price' => $this->price,
            'discountPrice' => $this->discountPrice,
            'discountPercentage' => $this->discountPercentage,
            'special' => $this->special,
            // 'images' => $this->images,
        );
    }
}