<?php

	/**
	* @Entity (repositoryClass="ConfigurationsRepository")
	* @Table(name="configurations")
	**/
	class Configuration implements JsonSerializable {

		/** 
		 * @Id @Column(type="integer", name="id")
		*/
		protected $id;

		/** 
		 * @Column(type="boolean", options={"defaut": "0"}, name="vat_applicable")
		*/
		protected $vatApplicable;

		/** 
		 * @Column(type="float", name="vat_percentage")
		*/
		protected $vatPercentage;

		/** 
		 * @Column(type="integer", name="stock_threshold")
		*/
		protected $stockThreshold;

		public function getId() {
			return $this->id;
		}
		public function setId($id) {
			$this->id = $id;
		}

		public function getVatApplicable() {
			return $this->vatApplicable;
		}

		public function setVatApplicable($vatApplicable) {
			$this->vatApplicable = $vatApplicable;
		}

		public function getVatPercentage() {
			return $this->vatPercentage;
		}

		public function setVatPercentage($vatPercentage) {
			$this->vatPercentage = $vatPercentage;
		}

		public function getStockThreshold() {
			return $this->stockThreshold;
		}

		public function setStockThreshold($stockThreshold) {
			$this->stockThreshold = $stockThreshold;
		}

		public function expose() {
        	return get_object_vars($this);
    	}

		public function jsonSerialize() {
			return array(
				'id' => $this->id,
				'vatApplicable' => $this->vatApplicable,
				'vatPercentage' => $this->vatPercentage,
				'stockThreshold' => $this->stockThreshold,
			);
		}
	}