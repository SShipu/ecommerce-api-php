<?php

	/**
	* @Entity (repositoryClass="FeaturedProductsRepository")
	* @Table(name="featured_products")
	**/
	class FeaturedProduct implements JsonSerializable {

		/**
		 * @Id 
		 * @OneToOne(targetEntity = "Product", inversedBy="featured")
		 * @JoinColumn(name="product_id", referencedColumnName="id")
		 */
		protected $product;

		public function getId() {
			return $this->product;
		}

		public function getProduct() {
			return $this->product;
		}

		public function setProduct($product) {
			$this->product = $product;
		}
		
		public function expose() {
			return get_object_vars($this);
		}

		public function jsonSerialize() {
			return array(
				'product' => $this->product,
			);
		}
	}