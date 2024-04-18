<?php
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="ItemAttributesRepository")
 * @Table(name="item_attributes", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "name" }) } )
 **/
class ItemAttribute implements JsonSerializable
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
     * @OneToMany(targetEntity="ItemAttributeValue", mappedBy="attribute", fetch="EAGER", cascade={"remove"})
     */
    private $values;

    /**
     * @Column(type="integer")
     */
    protected $seq;

    /** 
     * @Column(type="boolean", options={"defaut": "0"}) 
     */
    private $lapse;

    public function __construct() {
        $this->values = new ArrayCollection();
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

    public function getValues() {
        return $this->values;
    }

    public function setValues($values) {
        $this->values = $values;
    }

    public function getLapse() {
        return $this->lapse;
    }

    public function setLapse($lapse) {
        $this->lapse = $lapse;
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
        $values = array();
        foreach ($this->values as $val) {
            $valArray = array('value' => $val->getValue(), 'id' => $val->getId(), 'seq' => $val->getSeq(),'extra' => $val->getExtra());
            array_push($values, $valArray);
        }
        return array(
            'id' => $this->id,
            'name' => $this->name,
            'lapse' => $this->lapse,
            'seq' => $this->seq,
            'values' => $values,
        );
    }

    public function shortJsonSerialize() {
        return array(
            'id' => $this->id,
            'name' => $this->name,
            'lapse' => $this->lapse,
            'seq' => $this->seq,
        );
    }
}