<?php
// src/OttomanFile.php

/**
 * @Entity (repositoryClass="OttomanFilesRepository")
 * @Table(name="ottoman_files", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "id", "sort_order" }) } )
 **/

class OttomanFile implements JsonSerializable
{

    /**
     * @Id
     * @Column(type="string")
     */
    protected $id;

    /**
     * @Column(type="string")
     */
    protected $type;
    /**
     * @Column(type="string")
     */
    protected $extension;
    /**
     * @Column(type="string")
     */
    protected $image;

    /**
     * @Column(type="integer",name="sort_order")
     */
    protected $order;

    /**
     * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
     */
    protected $createdTime;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    public function getType()
    {
        return $this->type;
    }

    public function setType($type)
    {
        $this->type = $type;
    }
    public function getExtension()
    {
        return $this->extension;
    }

    public function setExtension($extension)
    {
        $this->extension = $extension;
    }
    public function getImage()
    {
        return $this->image;
    }

    public function setImage($image)
    {
        $this->image = $image;
    }

    public function getOrder()
    {
        return $this->order;
    }

    public function setOrder($order)
    {
        $this->order = $order;
    }

    public function onPrePersist($createdTime)
    {
        // WILL be saved in the database
        $this->createdTime = $createdTime;
        // $this->createdTime = new \DateTime('now');
    }

    public function expose()
    {
        return get_object_vars($this);
    }

    public function jsonSerialize()
    {

        return array(
            'id' => $this->id,
            'type' => $this->type,
            'extension' => $this->extension,
            'image' => $this->image,
            'order' => $this->order,

        );
    }
}