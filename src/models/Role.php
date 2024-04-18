<?php

	/**
	* @Entity (repositoryClass="RolesRepository")
	* @Table(name="roles", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "role" }) } )
	**/
	class Role implements JsonSerializable {

		/** 
		 * @Id 
		 * @Column(type="integer") 
		 * @GeneratedValue 
		 */
		protected $id;

		/** 
		 * @Column(type="string") 
		 */
		protected $role;

		public function getId() {
			return $this->id;
		}

		public function getRole() {
			return $this->role;
		}
		public function setRole($role) {
			$this->role = $role;
		}

		public function jsonSerialize() {
			return array(
				'id' => $this->id,
				'role' => $this->role,
			);
		}
	}