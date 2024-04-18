<?php
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @Entity (repositoryClass="InvoicesRepository")
 * @Table(name="invoices", uniqueConstraints={ @UniqueConstraint(name="unique_code", columns={ "id" }) } )
 **/
class Invoice implements JsonSerializable {

    /**
     * @Id
     * @Column(type="string")
     */
    protected $id;

    /**
     * @Column(name = "type", type = "string")
     */
    protected $type;

    /**
     * @Column(name = "sub_type", type="string")
     */
    protected $subType;

    /**
     * @Column(name = "source", type="string")
     */
    protected $source;

    /**
     * @Column(name = "payment_type", type="string")
     */
    protected $paymentType;

    /**
     * @Column(name = "payment_status", type="string")
     */
    protected $paymentStatus;

    /**
     * @Column(name = "delivery_status", type="string")
     */
    protected $deliveryStatus;

    /**
     * @Column(name = "order_status", type="string", nullable=true)
     */
    protected $orderStatus;

    /**
     * @Column(type="float", name = "total")
     */
    protected $total;

    /**
     * @Column(type="float", name = "net_total")
     */
    protected $netTotal;

    /**
     * @Column(type = "float", name = "grand_total")
     */
    protected $grandTotal;

    /**
     * @Column(type="float", name = "total_commission", nullable=true)
     */
    protected $totalCommission;

    /**
     * @Column(type="float", name = "discount")
     */
    protected $discount;

    /** 
     * @Column(type = "string", name = "discount_type") 
     */
    protected $discountType;

    /**
     * @Column(type="float", name = "vat_percentage")
     */
    protected $vatPercentage;

    /**
     * @Column(type="float", name = "vat_amount")
     */
    protected $vatAmount;

    /**
     * @Column(type="datetime", name="created_at", options={"default": "CURRENT_TIMESTAMP"}, nullable=false)
     */
    protected $createdTime;

    /**
     * @Column(type="string", name="date", nullable=false)
     */
    protected $date;

    /** 
     * @Column(type="datetime", name="payment_receive_date", options={"default": "CURRENT_TIMESTAMP"}, nullable=true) 
     */
    protected $paymentReceiveDate;

    /** 
     * @Column(type = "string", name = "remark", nullable=true) 
     */
    protected $remark;

    /** 
     * @Column(type = "string", name = "transaction_id", nullable=true) 
     */
    protected $transactionId;

    /** 
     * @Column(type = "string", name = "transaction_status", nullable=true) 
     */
    protected $transactionStatus;
    

    /**
     * @OneToMany(targetEntity="InvoiceItem", mappedBy="invoice")
     */
    protected $items;

    /**
     * @ManyToOne(targetEntity = "User")
     * @JoinColumn(name = "created_by_user_id", referencedColumnName = "id")
     */
    protected $createdBy;

    /**
     *
     * @ManyToOne(targetEntity="Invoice", inversedBy="linkedInvoices")
     * @JoinColumn(name="parent_id", referencedColumnName="id")
     */
    protected $parentInvoice;

    /**
     *
     * @OneToMany(targetEntity="Invoice", mappedBy="parentInvoice")
     */
    protected $linkedInvoices;

    /**
     * @ManyToOne(targetEntity="Customer", inversedBy="invoices")
     * @JoinColumn(name="customer_id", referencedColumnName="id")
     */
    protected $customer;

    /** 
     * @Column(type="string", nullable=true)
    */
    protected $name;

    /** 
     * @Column(type="string", nullable=true)
    */
    protected $email;

    /**
     * @Column(type="string", name="contact_no", nullable=true)
     */
    protected $contactNo;

    /**
     * @Column(type="string", name="contact_Address", nullable=true)
     */
    protected $contactAddress;

    /**
     * @ManyToOne(targetEntity="Branch")
     * @JoinColumn(name = "branch_id", referencedColumnName = "id")
     */
    protected $branch;

    protected $computed;

    public function __construct() {
        $this->items = new ArrayCollection();
    }

    public function getId() {
        return $this->id;
    }

    public function setId($id) {
        $this->id = $id;
    }

    public function getType() {
        return $this->type;
    }

    public function setType($type) {
        $this->type = $type;
    }

    public function getSubType() {
        return $this->subType;
    }

    public function setSubType($subType) {
        $this->subType = $subType;
    }

    public function getSource() {
        return $this->source;
    }

    public function setSource($source) {
        $this->source = $source;
    }

    public function getPaymentType() {
            return $this->paymentType;
    }

    public function setPaymentType($paymentType) {
        $this->paymentType = $paymentType;
    }

    public function getPaymentStatus() {
            return $this->paymentStatus;
    }

    public function setPaymentStatus($paymentStatus) {
        $this->paymentStatus = $paymentStatus;
    }
    
    public function getDeliveryStatus() {
            return $this->deliveryStatus;
    }

    public function setDeliveryStatus($deliveryStatus) {
        $this->deliveryStatus = $deliveryStatus;
    }

    public function getOrderStatus() {
            return $this->orderStatus;
    }

    public function setOrderStatus($orderStatus) {
        $this->orderStatus = $orderStatus;
    }
    
    public function getTotal() {
        return $this->total;
    }

    public function setTotal($total) {
        $this->total = $total;
    }

    public function getNetTotal() {
        return $this->netTotal;
    }

    public function setNetTotal($netTotal) {
        $this->netTotal = $netTotal;
    }

    public function getGrandTotal() {
        return $this->grandTotal;
    }

    public function setGrandTotal($grandTotal) {
        $this->grandTotal = $grandTotal;
    }

    public function getTotalCommission() {
        return $this->totalCommission;
    }

    public function setTotalCommission($totalCommission) {
        $this->totalCommission = $totalCommission;
    }

    public function getVatPercentage() {
        return $this->vatPercentage;
    }

    public function setVatPercentage($vatPercentage) {
        $this->vatPercentage = $vatPercentage;
    }

    public function getVatAmount() {
        return $this->vatAmount;
    }

    public function setVatAmount($vatAmount) {
        $this->vatAmount = $vatAmount;
    }

    public function getDiscount() {
        return $this->discount;
    }

    public function setDiscount($discount) {
        $this->discount = $discount;
    }

    public function getDiscountType() {
        return $this->discountType;
    }

    public function setDiscountType($discountType) {
        $this->discountType = $discountType;
    }

    public function getRemark() {
        return $this->remark;
    }

    public function setRemark($remark) {
        $this->remark = $remark;
    }

    public function getTransactionId() {
        return $this->transactionId;
    }

    public function setTransactionId($transactionId) {
        $this->transactionId = $transactionId;
    }
    
    public function getTransactionStatus() {
        return $this->transactionStatus;
    }

    public function setTransactionStatus($transactionStatus) {
        $this->transactionStatus = $transactionStatus;
    }

    public function getCreatedTime() {
        return $this->createdTime;
    }

    public function setCreatedTime($createdTime) {
        $this->createdTime = $createdTime;
    }

    public function getDate() {
        return $this->date;
    }

    public function setDate($date) {
        $this->date = $date;
    }

    public function getPaymentReceiveDate() {
        return $this->paymentReceiveDate;
    }

    public function setPaymentReceiveDate($paymentReceiveDate) {
        $this->paymentReceiveDate = $paymentReceiveDate;
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

    public function getCreatedBy() {
        return $this->createdBy;
    }

    public function setCreatedBy($createdBy) {
        $this->createdBy = $createdBy;
    }

    public function getParentInvoice() {
        return $this->parentInvoice;
    }

    public function setParentInvoice($parentInvoice) {
        $this->parentInvoice = $parentInvoice;
    }

    public function getLinkedInvoices() {
        return $this->linkedInvoices;
    }

    public function setLinkedInvoices($linkedInvoices) {
        $this->linkedInvoices = $linkedInvoices;
    }

    public function addLinkedInvoice($linkedInvoice) {
        $this->linkedInvoice[] = $linkedInvoice;
    }

    public function getCustomer() {
        return $this->customer;
    }

    public function setCustomer($customer) {
        return $this->customer = $customer;
    }

    public function getName() {
        return $this->name;
    }

    public function setName($name) {
        return $this->name = $name;
    }

    public function getEmail() {
        return $this->email;
    }

    public function setEmail($email) {
        return $this->email = $email;
    }

    public function getContactNo() {
        return $this->contactNo;
    }

    public function setContactNo($contactNo) {
        return $this->contactNo = $contactNo;
    }

    public function getContactAddress() {
        return $this->contactAddress;
    }

    public function setContactAddress($contactAddress) {
        return $this->contactAddress = $contactAddress;
    }

    public function getBranch() {
        return $this->branch;
    }

    public function setBranch($branch) {
        return $this->branch = $branch;
    }

    public function getComputed() {
        return $this->computed;
    }

    public function setComputed($computed) {
        // echo "in find one :: " . count($computed);
        $this->computed = $computed;
        // echo "h1";
        // print_r(count($this->computed));
    }

    public function expose() {
        return get_object_vars($this);
    }

    public function shortJsonSerialize() {
        $items = array();
        foreach($this->items as $item) {
            array_push($items, $item->jsonSerialize());
        }

        $linkedInvoicestems = array();
        foreach($this->linkedInvoices as $item) {
            array_push($linkedInvoicestems, $item->shortJsonSerialize());
        }

        $customer = null;
        if ($this->name && $this->contactNo && $this->contactAddress != '') {
            $customer = array(
                'name' => $this->name,
                'email' => $this->email,
                'contactNo' => $this->contactNo,
                'contactAddress' => $this->contactAddress,
            );
        }else if ($this->customer != null){
            $customer = $this->customer;
        }

        $json = array(
            'id' => $this->id,
            'branch' => $this->branch,
            'source' => $this->source,
            'type' => $this->type,
            'subType' => $this->subType,
            'paymentStatus' => $this->paymentStatus,
            'deliveryStatus' => $this->deliveryStatus,
            'orderStatus' => $this->orderStatus,
            'total' => $this->total,
            'netTotal' => $this->netTotal,
            'grandTotal' => $this->grandTotal,
            'totalCommission' => $this->totalCommission,
            'discount' => $this->discount,
            'discountType' => $this->discountType,
            'remark' => $this->remark,
            'transactionId' => $this->transactionId,
            'transactionStatus' => $this->transactionStatus,
            'vatPercentage' => $this->vatPercentage,
            'vatAmount' => $this->vatAmount,
            'createdTime' => $this->createdTime,
            'date' => $this->date,
            'paymentReceiveDate' => $this->paymentReceiveDate,
            // 'linkedInvoices' => $this->linkedInvoices,
            'linkedInvoices' => count($linkedInvoicestems),
            'items' => $items
        );

        if ($customer != null) {
            $json['customer'] = $customer;
        }

        return $json;
    }

    public function jsonSerialize() {
        $items = array();
        foreach($this->items as $item) {
            array_push($items, $item->jsonSerialize());
        }

        $linkedInvoicestems = array();
        foreach($this->linkedInvoices as $item) {
            array_push($linkedInvoicestems, $item->shortJsonSerialize());
        }

        $customer = null;
        if ($this->name && $this->contactNo && $this->contactAddress != '') {
            $customer = array(
                'name' => $this->name,
                'email' => $this->email,
                'contactNo' => $this->contactNo,
                'contactAddress' => $this->contactAddress,
            );
        }else if ($this->customer != null){
            $customer = $this->customer;
        }
        
        $json =  array(
            'id' => $this->id,
            'branch' => $this->branch,
            'source' => $this->source,
            'type' => $this->type,
            'subType' => $this->subType,
            'paymentStatus' => $this->paymentStatus,
            'deliveryStatus' => $this->deliveryStatus,
            'orderStatus' => $this->orderStatus,
            'total' => $this->total,
            'netTotal' => $this->netTotal,
            'grandTotal' => $this->grandTotal,
            'totalCommission' => $this->totalCommission,
            'discount' => $this->discount,
            'discountType' => $this->discountType,
            'remark' => $this->remark,
            'transactionId' => $this->transactionId,
            'transactionStatus' => $this->transactionStatus,
            'vatPercentage' => $this->vatPercentage,
            'vatAmount' => $this->vatAmount,
            'createdTime' => $this->createdTime,
            'createdBy' => $this->createdBy,
            'date' => $this->date,
            'paymentReceiveDate' => $this->paymentReceiveDate,
            'parentInvoice' => $this->parentInvoice,
            // 'linkedInvoices' => $this->linkedInvoices,
            'linkedInvoices' => $linkedInvoicestems,
            'items' => $items,
            'computed' => $this->computed
            
        );

        if ($customer != null) {
            $json['customer'] = $customer;
        }

        return $json;
    }
}