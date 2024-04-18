<?php
// src/ItemAttributeValue.php

/**
 * @Entity (repositoryClass="ItemAttributeValuesRepository")
 * @Table(name="item_attribute_values", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "attribute_id", "value" }) } )
 **/

class ItemAttributeValue implements JsonSerializable
{

    /**
     * @Id
     * @Column(type="integer")
     * @GeneratedValue
     */
    protected $id;

    /**
     * @Column(type="string")
     */
    protected $value;

    /**
     * @Column(type="string")
     */
    protected $extra;

    /**
     * @ManyToOne(targetEntity="ItemAttribute", inversedBy="values", fetch="EAGER")
     * @JoinColumn(name="attribute_id", referencedColumnName="id")
     */
    protected $attribute;

     /**
     * @Column(type="integer")
     */
    protected $seq;

    public function getId() {
        return $this->id;
    }

    public function getValue() {
        return $this->value;
    }

    public function setValue($value) {
        $this->value = $value;
    }

    public function getAttribute() {
        return $this->attribute;
    }

    public function setAttribute($attribute) {
        $this->attribute = $attribute;
    }

    public function getExtra() {
        return $this->extra;
    }

    public function setExtra($extra) {
        $this->extra = $extra;
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
        return array(
            'id' => $this->id,
            'value' => $this->value,
            'extra' => $this->extra,
            'seq' => $this->seq,
            'attribute' => $this->attribute->shortJsonSerialize(),
        );
    }
}