<?php

	/**
	* @Entity (repositoryClass="BranchesRepository")
	* @Table(name="branches", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "branch_name" }) } )
	**/
	class Branch implements JsonSerializable {

		/** 
		 * @Id @Column(type="integer") 
		 * @GeneratedValue 
		*/
		protected $id;

		/** 
		 * @Column(type="string", name="branch_name") 
		*/
		protected $branchName;

		/** 
		 * @Column(type="string", name="branch_address") 
		*/
		protected $branchAddress;

        /** 
		 * @Column(type="string", name="city") 
		*/
		protected $city;

        /** 
		 * @Column(type="string", name="postal_code") 
		*/
		protected $postalCode;

        /** 
		 * @Column(type="string", name="map_longitude") 
		*/
		protected $mapLongitude;

        /** 
		 * @Column(type="string", name="map_latitude") 
		*/
		protected $mapLatitude;

		/** 
		 * @Column(type="string", name="note") 
		*/
		protected $note;

		/** 
		 * @Column(type="string", name="type") 
		*/
		protected $type;

        /** 
		 * @Column(type="integer", name="commission_percentage", nullable=true) 
		*/
		protected $commissionPercentage;

        /** 
         * @Column(type="boolean", name="is_ecommerce", options={"defaut": "0"}) 
        */
        private $isEcommerce;

		public function getId() {
			return $this->id;
		}

		public function getBranchName() {
			return $this->branchName;
		}
		public function setBranchName($branchName) {
			$this->branchName = $branchName;
		}

		public function getMapLongitude() {
			return $this->mapLongitude;
		}
		public function setMapLongitude($mapLongitude) {
			$this->mapLongitude = $mapLongitude;
		}

        public function getMapLatitude() {
			return $this->mapLatitude;
		}
		public function setMapLatitude($mapLatitude) {
			$this->mapLatitude = $mapLatitude;
		}

        public function getCity() {
			return $this->city;
		}
		public function setCity($city) {
			$this->city = $city;
		}

        public function getPostalCode() {
			return $this->postalCode;
		}
		public function setPostalCode($postalCode) {
			$this->postalCode = $postalCode;
		}

        public function getBranchAddress() {
			return $this->branchAddress;
		}
		public function setBranchAddress($branchAddress) {
			$this->branchAddress = $branchAddress;
		}

		public function getNote() {
			return $this->note;
		}
		public function setNote($note) {
			$this->note = $note;
		}

		public function getType() {
			return $this->type;
		}

		public function setType($type) {
			$this->type = $type;
		}

        public function getCommissionPercentage() {
			return $this->commissionPercentage;
		}

		public function setCommissionPercentage($commissionPercentage) {
			$this->commissionPercentage = $commissionPercentage;
		}

        public function getIsEcommerce() {
            return $this->isEcommerce;
        }

        public function setIsEcommerce($isEcommerce) {
            $this->isEcommerce = $isEcommerce;
        }

		public function expose() {
			return get_object_vars($this);
		}

		public function jsonSerialize() {
			return array(
				'id' => $this->id,
				'branchName' => $this->branchName,
				'branchAddress' => $this->branchAddress,
				'city' => $this->city,
				'postalCode' => $this->postalCode,
				'mapLatitude' => $this->mapLatitude,
				'mapLongitude' => $this->mapLongitude,
				'note' => $this->note,
				'type' => $this->type,
				'commissionPercentage' => $this->commissionPercentage,
                'isEcommerce' => $this->isEcommerce,

			);
		}
	}