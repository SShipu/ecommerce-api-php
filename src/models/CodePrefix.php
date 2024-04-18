<?php

/**
 * @Entity(repositoryClass="CodePrefixesRepository")
 * @Table(name="code_prefixes", uniqueConstraints={ @UniqueConstraint(name="unique_prefix", columns={ "prefix" }) } )
 **/
class CodePrefix {

    /**
     * @Id
     * @Column(type="string")
     */
    protected $prefix;

    /**
     * @Column(name = "last_seq", type = "integer")
     */
    protected $lastSeq;

    public function getPrefix() {
        return $this->prefix;
    }

    public function setPrefix($prefix) {
        $this->prefix = $prefix;
    }

    public function getLastSeq() {
        return $this->lastSeq;
    }

    public function setLastSeq($lastSeq) {
        $this->lastSeq = $lastSeq;
    }


}
?>
