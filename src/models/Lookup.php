<?php

use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="LookupsRepository")
 * @Table(name="lookups", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "type", "name", "parent_id" }) } )
 **/
class Lookup implements JsonSerializable
{

    /**
     * @Id
     * @Column(type="integer")
     * @GeneratedValue
     */
    protected $id;

    /**
     * @Column(name="type", type="string")
     */
    protected $type;

    /**
     * @Column(name="name", type="string")
     */
    protected $name;

    /**
     * @Column(type="integer")
     */
    protected $seq;

    /**
     * Many Categories have One Category.
     * @ManyToOne(targetEntity="Lookup", inversedBy="children")
     * @JoinColumn(name="parent_id", referencedColumnName="id")
     */
    protected $parent;

    /**
     * One Category has Many Categories.
     * @OneToMany(targetEntity="Lookup", mappedBy="parent")
     */
    protected $children;

    /**
     * @Column(type="string", name="image_url", nullable=true)
     */
    protected $imageUrl;

    /** @Column(type="integer") **/
    protected $count;

    /**
     * @ManyToMany(targetEntity = "ItemAttribute")
     */
    protected $attributes;

    /**
     * @Column(type="string")
     */
    protected $status;

    public function __construct() {
        $this->children = new ArrayCollection();
        $this->attributes = new ArrayCollection();
    }

    public function getId() {
        return $this->id;
    }

    public function setType($type) {
        $this->type = $type;
    }

    public function getType() {
        return $this->type;
    }

    public function getName() {
        return $this->name;
    }

    public function setName($name) {
        $this->name = $name;
    }

    public function getParent() {
        return $this->parent;
    }

    public function setParent($parent) {
        $this->parent = $parent;
    }

    public function getImageUrl() {
        return $this->imageUrl;
    }

    public function setImageUrl($imageUrl) {
        $this->imageUrl = $imageUrl;
    }

    public function getCount() {
        return $this->count;
    }

    public function setCount($count) {
        $this->count = $count;
    }

    public function getAttributes() {
        return $this->attributes;
    }

    public function setAttributes($attributes) {
        $this->attributes = $attributes;
    }

    public function addAttribute($attribute) {
        $this->attributes[] = $attribute;
    }

    public function getChildren() {
        return $this->children;
    }

    public function setChildren($children) {
        $this->children = $children;
    }

    public function addChild($child) {
        $this->children[] = $child;
    }

    public function setStatus($status) {
        $this->status = $status;
    }

    public function getStatus() {
        return $this->status;
    }

    public function getSeq() {
        return $this->seq;
    }

    public function setSeq($seq) {
        $this->seq = $seq;
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function jsonSerialize() {
        $attrArray = array();
        foreach ($this->attributes as $attr) {
            array_push($attrArray, $attr->jsonSerialize());
        }
        $childArray = array();
        foreach ($this->children as $child) {
            array_push($childArray, $child->jsonSerialize());
        }
        
        $parent = null;
        if ($this->parent != null) {
            $parent = array(
                'id' => $this->parent->id,
                'type' => $this->parent->type,
                'name' => $this->parent->name,
                'seq' => $this->seq,
            );
            //print_r($parent);
        }

        $json = array(
            'id' => $this->id,
            'type' => $this->type,
            'name' => $this->name,
            'imageUrl' => $this->imageUrl,
            'attributes' => $this->attributes,
            'count' => $this->count,
            'status' => $this->status,
            'attributes' => $attrArray,
            'children' => $childArray,
            'seq' => $this->seq,
        );

        if ($parent != null) {
            $json['parent'] = $parent;
        }

        return $json;
    }
}