<?php
	use Doctrine\Common\Collections\ArrayCollection;

	/**
    * @Entity (repositoryClass="MfgOrderSetsRepository")
    * @Table(name="mfg_order_sets", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "name" }) } )
	**/
	class MfgOrderSet implements JsonSerializable {

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
         * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
         */
        protected $createdTime;

        /**
         * @OneToMany(targetEntity="MfgOrderItem", mappedBy="set")
         */
        protected $items;

        public function __construct() {
            $this->items = new ArrayCollection();
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

        public function getItems() {
            return $this->items;
        }

        public function setItems($items) {
            $this->items = $items;
        }

        public function addItem($item) {
            $this->items[] = $item;
        }

        public function getCreatedTime() {
            return $this->createdTime;
        }

        public function setCreatedTime($createdTime) {
            $this->createdTime = $createdTime;
        }

		public function jsonSerialize() {
            
            $itemsArray = array();
            foreach ($this->items as $item) {
                if ($item != null) {
                    array_push($itemsArray, $item->jsonSerialize());
                }
            }
			return array(
				'id' => $this->id,
				'name' => $this->name,
				'items' => $itemsArray,
			);
		}
	}