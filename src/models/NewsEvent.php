<?php
    use Doctrine\Common\Collections\ArrayCollection;

	/**
	* @Entity (repositoryClass="NewsEventsRepository")
	* @Table(name="news_events", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "title" }) } )
	**/
	class NewsEvent implements JsonSerializable {

		/** 
		 * @Id 
		 * @Column(type="integer") 
		 * @GeneratedValue 
		 */
		protected $id;

		/**
         * @Column(type="string")   
        */
        protected $title;

        /**
         * @Column(type="string")
         */
        protected $date;

        /**
         * @Column(type="string")
         */
        protected $type;

        /**
         * @Column(type="text", length=65535)
         */
        protected $description;

        /**
         * @ManyToMany(targetEntity="OttomanFile")
         */
        protected $images;

        /**
         * @Column(name="created_at", type="datetime", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
         */
        protected $createdTime;
        
        public function __construct() {
            $this->images = new ArrayCollection();
        }

		public function getId() {
			return $this->id;
		}

        public function getTitle() {
            return $this->title;
        }
    
        public function setTitle($title) {
            $this->title = $title;
        }

        public function getDate() {
            return $this->date;
        }
    
        public function setDate($date) {
            $this->date = $date;
        }

        public function getType() {
            return $this->type;
        }
    
        public function setType($type) {
            $this->type = $type;
        }

        public function getDescription() {
            return $this->description;
        }
    
        public function setDescription($description) {
            $this->description = $description;
        }

        public function getImages() {
            return $this->images;
        }
    
        public function setImages($images) {
            $this->images = $images;
        }
    
        public function addImage($image) {
            $this->images[] = $image;
        }

        public function getCreatedTime() {
            return $this->createdTime;
        }
    
        public function setCreatedTime($createdTime) {
            $this->createdTime = $createdTime;
        }

		public function jsonSerialize() {
            $imagesArray = array();
            foreach ($this->images as $sku) {
                array_push($imagesArray, $sku->jsonSerialize());
            }

			return array(
				'id' => $this->id,
				'title' => $this->title,
				'date' => $this->date,
                'type' => $this->type,
                'description' => $this->description,
                'images' => $imagesArray,
                'createdTime' => $this->createdTime,
			);
		}
	}