<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Doctrine\DBAL\Exception\DBALException;
use Doctrine\DBAL\Exception\ORMException;

class InvoicesRepository extends EntityRepository {

    public function createSalesInvoice($data, $skus, $sellerId) {
        $em1 = getEntityManager();

        $user = $em1->find('User', $sellerId);

        date_default_timezone_set("Asia/Dhaka");
        $t = microtime(true);
        $micro = sprintf("%06d",($t - floor($t)) * 1000000);
        $dateMicroSec = "'". date('Ymdhis'.$micro, $t) ."'";
        $invoiceId = strtoupper(base_convert($dateMicroSec, 10, 36)) . '-' . $sellerId . '-' . $data->branchId;
        $onlyDate = date('Y-m-d');
        if ($data->source == 'POS' || $data->source == 'ONLINE') {
            
            $invoice = new Invoice();
            $invoice->setId($invoiceId);
            $invoice->setType('SALES');
            $invoice->setSubType('SALES');
            $invoice->setSource($data->source);
            $invoice->setPaymentType('CASH');
            $invoice->setPaymentStatus('RECEIVED');
            $invoice->setDeliveryStatus('COMPLETE');
            $invoice->setOrderStatus('');
            $invoice->setTotal($data->total);
            $invoice->setVatPercentage($data->vatPercentage);
            $invoice->setVatAmount($data->vatAmount);
            $invoice->setNetTotal($data->netTotal);
            $invoice->setGrandTotal($data->grandTotal);
            $invoice->setDiscount($data->discount);
            $invoice->setDiscountType($data->discountType);
            $invoice->setCreatedTime(new \DateTime('now'));
            $invoice->setDate($onlyDate);
            $invoice->setCreatedBy($user);
            if (isset($data->remark) && $data->remark != null) {
                $invoice->setRemark($data->remark);
            } else {
                $invoice->setRemark("");
            }
            $invoice->setName(''); 
            $invoice->setEmail(''); 
            $invoice->setContactNo(''); 
            $invoice->setContactAddress('');

            $branch = $em1->find('Branch', $data->branchId);
            if ($branch != null) {
                $invoice->setBranch($branch);
                if ($branch->getCommissionPercentage() != null) {
                    $commission = $branch->getCommissionPercentage();
                    $totalCommission = $data->grandTotal * ( $commission / 100 );
                    $invoice->setTotalCommission($totalCommission);
                }
            }
        }
        $em1->persist($invoice);

        global $stocksV2Repository;
        for ($i = 0; $i < count($data->skus); $i++) {
            $skuData = $data->skus[$i];
            $item = new InvoiceItem($i, $invoice);
            $item->setSku($skuData->code);
            $item->setPrice($skuData->price);
            $item->setQuantity($skuData->quantity);
            $item->setSubTotal($skuData->price * $skuData->quantity);
            
            $sku1 = $skus[$i];
            $item->setTitle($sku1[0]->getProduct()->getTitle() . "-" . $sku1[0]->getLabel());
            if ($sku1[0]->getProduct()->getImages()->count() > 0)
                $item->setMainImageUrl($sku1[0]->getProduct()->getImages()[0]->getId());
            $em1->persist($item);
            $stocksV2Repository->saleStock($em1, $skuData->code, $branch, $skuData->quantity);
           
            $sku2 = $em1->find('SKU', $skuData->code);
            if ($sku2 == null) {
                throw new NotFoundException();
            }

            $prodStat = $em1->find('ProductStat', array("sku" => $skuData->code, "date" => $onlyDate, "branch" => $branch));
            if ($prodStat != null && $prodStat->getDate() == $onlyDate) {
                $prodStat->setCounter($prodStat->getCounter() + $skuData->quantity);
                $em1->persist($prodStat);
            }else {
                $prodStat = new ProductStat($sku2, $onlyDate, $branch);
                $prodStat->setCounter($skuData->quantity);
                $prodStat->setSource($invoice->getSource());
                $prodStat->setProduct($sku2->getProduct());
                $prodStat->setCreatedTime(new \DateTime('now'));
                $em1->persist($prodStat);
            }
        }
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
            echo "h1";
            die();
        } catch (PDOException $ex) {
            echo $ex->getMessage();
            echo "h2";
            die();
        } catch (DBALException $ex) {
            echo $ex->getMessage();
            echo "h3";
            die();
        } catch(ORMException $ex) {
            echo $ex->getMessage();
            echo "h4";
            die();
        } catch(Exception $ex) {
            echo $ex->getMessage();
            echo "h5";
            die();
        } 
        return $invoiceId;
    }

    public function placeEcommerceOrder($data, $skus, $customerId) {
        $em1 = getEntityManager();

        // $user = $em1->find('User', $sellerId);
        
        date_default_timezone_set("Asia/Dhaka");
        $t = microtime(true);
        $micro = sprintf("%06d",($t - floor($t)) * 1000000);
        $dateMicroSec = "'". date('Ymdhis'.$micro, $t) ."'";

        if ($customerId != null) {
            $customer = $em1->find('Customer', $customerId);
            $invoiceId = strtoupper(base_convert($dateMicroSec, 10, 36)) . '-' . $customerId . '-' . $data->branchId;
        }else {
            $invoiceId = strtoupper(base_convert($dateMicroSec, 10, 36)) . '-' . rand(10,100) . '-' . $data->branchId;
        }
        $onlyDate = date('Y-m-d');
        if ($data->source == 'ECOMMERCE') {
            $invoice = new Invoice();
            $invoice->setId($invoiceId);
            $invoice->setType('SALES');
            $invoice->setSubType('SALES');
            $invoice->setSource($data->source);
            // $invoice->setPaymentType('CASH ON DELIVERY');
            $invoice->setPaymentType($data->paymentType);
            $invoice->setPaymentStatus('PENDING');
            $invoice->setDeliveryStatus('PENDING');
            $invoice->setOrderStatus('PLACED');
            $invoice->setTotal($data->total);
            $invoice->setVatPercentage($data->vatPercentage);
            $invoice->setVatAmount($data->vatAmount);
            $invoice->setNetTotal($data->netTotal);
            $invoice->setGrandTotal($data->grandTotal);
            $invoice->setDiscount($data->discount);
            $invoice->setDiscountType($data->discountType);
            $invoice->setCreatedTime(new \DateTime('now'));
            $invoice->setDate($onlyDate);
            // $invoice->setCreatedBy($user);
            // $invoice->setCreatedBy(-1);
            if (isset($data->remark) && $data->remark != null) {
                $invoice->setRemark($data->remark);
            } else {
                $invoice->setRemark("");
            }
            if ($customerId == null || $customerId == "") {
                if ($data->name && $data->contactNo && $data->contactAddress != '') {
                    $invoice->setName($data->name); 
                    $invoice->setEmail($data->email); 
                    $invoice->setContactNo($data->contactNo); 
                    $invoice->setContactAddress($data->contactAddress);
                }else {
                    throw new BadRequestException();
                }
            }else { 
                $invoice->setCustomer($customer); //sellerId in customerId 
            }
            $branch = $em1->find('Branch', $data->branchId);
            if ($branch != null)
                $invoice->setBranch($branch);
        }
        $em1->persist($invoice);

        // global $stocksV2Repository;
        for ($i = 0; $i < count($data->skus); $i++) {
            $skuData = $data->skus[$i];
            $item = new InvoiceItem($i, $invoice);
            $item->setSku($skuData->code);
            $item->setPrice($skuData->price);
            $item->setQuantity($skuData->quantity);
            $item->setSubTotal($skuData->price * $skuData->quantity);
            
            $sku = $skus[$i];
            $item->setTitle($sku[0]->getProduct()->getTitle() . "-" . $sku[0]->getLabel());
            if ($sku[0]->getProduct()->getImages()->count() > 0)
                $item->setMainImageUrl($sku[0]->getProduct()->getImages()[0]->getId());
            $em1->persist($item);
        }
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
            die();
        } catch (PDOException $ex) {
            echo $ex->getMessage();
            die();
        } catch (DBALException $ex) {
            echo $ex->getMessage();
            die();
        } catch(ORMException $ex) {
            echo $ex->getMessage();
            die();
        } catch(Exception $ex) {
            echo $ex->getMessage();
            die();
        } 
        return $invoiceId;
    }

    public function confirmEcommerceOrder($data, $branchId) {
        $em1 = getEntityManager();

        $order = $em1->find('Invoice', $data->id);
        
        if ($order == null) {
            throw new NotFoundException();
        }
        if ($order->getOrderStatus() != "PLACED") {
            throw new PreconditionFailedException();
        }

        if ($branchId != -1 && $order->getBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }
        
        $order->setOrderStatus('CONFIRMED');
        $em1->persist($order);
        for ($i=0; $i < count($order->getItems()); $i++) { 
            $skus = $order->getItems()[$i];
            $sku = $em1->find('SKU', $skus->getSku());

            if ($sku == null) {
                throw new NotFoundException();
            }
            $stock = $em1->find("StockV2", array("sku" => $skus->getSku(), "branch" => $branchId));
            if ($stock == null) {
                throw new NotFoundException();
            }
            if ($skus->getQuantity() <= $stock->getTotal()) {
                $stock->setSalesBooked($stock->getSalesBooked() + $skus->getQuantity());
                $stock->setTotal($stock->getTotal() - $skus->getQuantity());
                $em1->persist($stock);
            } else {
                throw new PreconditionFailedException();
            }
        }

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function dispatchEcommerceOrder($data, $branchId) {
        $em1 = getEntityManager();

        $order = $em1->find('Invoice', $data->id);
        
        if ($order == null) {
            throw new NotFoundException();
        }
        if ($order->getOrderStatus() != "CONFIRMED") {
            throw new PreconditionFailedException();
        }

        if ($branchId != -1 && $order->getBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }
        
        $order->setOrderStatus('DISPATCHED');
        $em1->persist($order);
        for ($i=0; $i < count($order->getItems()); $i++) { 
            $skus = $order->getItems()[$i];
            $sku = $em1->find('SKU', $skus->getSku());

            if ($sku == null) {
                throw new NotFoundException();
            }
            $stock = $em1->find("StockV2", array("sku" => $skus->getSku(), "branch" => $branchId));
            if ($stock == null) {
                throw new NotFoundException();
            }
            if ($skus->getQuantity() <= $stock->getSalesBooked()) {
                $stock->setSalesBooked($stock->getSalesBooked() - $skus->getQuantity());
                // $stock->setTotal($stock->getTotal() - $skus->getQuantity());
                $em1->persist($stock);
            } else {
                throw new PreconditionFailedException();
            }
        }

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function cancelEcommerceOrder($data, $branchId) {
        $em1 = getEntityManager();

        $order = $em1->find('Invoice', $data->id);
        
        if ($order == null) {
            throw new NotFoundException();
        }
        if ($order->getOrderStatus() == "DISPATCHED") {
            throw new PreconditionFailedException();
        }

        if ($branchId != -1 && $order->getBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }
        
        if ($order->getOrderStatus() == "CONFIRMED") {
            $order->setOrderStatus('CANCELED');
            $em1->persist($order);
            for ($i=0; $i < count($order->getItems()); $i++) { 
                $skus = $order->getItems()[$i];
                $sku = $em1->find('SKU', $skus->getSku());

                if ($sku == null) {
                    throw new NotFoundException();
                }
                $stock = $em1->find("StockV2", array("sku" => $skus->getSku(), "branch" => $branchId));
                if ($stock == null) {
                    throw new NotFoundException();
                }
                if ($skus->getQuantity() <= $stock->getSalesBooked()) {
                    $stock->setSalesBooked($stock->getSalesBooked() - $skus->getQuantity());
                    $stock->setTotal($stock->getTotal() + $skus->getQuantity());
                    $em1->persist($stock);
                } else {
                    throw new PreconditionFailedException();
                }
            }

        } else if ($order->getOrderStatus() == "PLACED") {
            $order->setOrderStatus('CANCELED');
            $em1->persist($order);
        }

        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function cashReceivedEcommerceOrder($data, $branchId) {
        $em1 = getEntityManager();
        
        date_default_timezone_set("Asia/Dhaka");
        
        $order = $em1->find('Invoice', $data->id);
        
        if ($order == null) {
            throw new NotFoundException();
        }
        if (
            ($order->getOrderStatus() == "PLACED") || 
            ($order->getOrderStatus() == "CANCELED")
        ) {
            throw new PreconditionFailedException();
        }

        if ($order->getPaymentStatus() == "RECEIVED") {
            throw new PreconditionFailedException();
        }

        if ($branchId != -1 && $order->getBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }
        
        if (($order->getOrderStatus() == "CONFIRMED") || ($order->getOrderStatus() == "DISPATCHED")) {
            $order->setPaymentStatus('RECEIVED');
            $order->setPaymentReceiveDate(new \DateTime('now'));
            $em1->persist($order);
        }
        
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function paymentReceivedEcommerceOrder($data, $branchId) {
        $em1 = getEntityManager();
        
        date_default_timezone_set("Asia/Dhaka");
        
        $order = $em1->find('Invoice', $data->id);
        
        if ($order == null) {
            throw new NotFoundException();
        }
        // ($order->getOrderStatus() == "PLACED") || 
        if (
            ($order->getOrderStatus() == "CANCELED")
        ) {
            echo "1";
            throw new PreconditionFailedException();
        }

        if ($order->getPaymentStatus() == "RECEIVED") {
            echo "2";
            throw new PreconditionFailedException();
        }

        // if (($order->getPaymentStatus() != null) || ($order->getPaymentStatus() != "FAILED")) {
        if ($order->getPaymentStatus() == "Successful") {
            echo "3";
            throw new PreconditionFailedException();
        }

        if ($branchId != -1 && $order->getBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }
        
        if (
            ($order->getOrderStatus() == "PLACED") || 
            ($order->getOrderStatus() == "CONFIRMED") || 
            ($order->getOrderStatus() == "DISPATCHED")
        ) {
            $order->setPaymentStatus('RECEIVED');
            $order->setTransactionId($data->tarnsId);
            $order->setTransactionStatus($data->payStatus);
            $order->setPaymentReceiveDate(new \DateTime('now'));
            $em1->persist($order);
        }
        
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function deliveryCompleteEcommerceOrder($data, $branchId) {
        $em1 = getEntityManager();        
        $order = $em1->find('Invoice', $data->id);
        
        if ($order == null) {
            throw new NotFoundException();
        }
        if ($order->getOrderStatus() != "DISPATCHED") {
            throw new PreconditionFailedException();
        }

        if ($branchId != -1 && $order->getBranch()->getId() != $branchId) {
            throw new ResourceLockedException();
        }
        
        if ($order->getDeliveryStatus() == "PENDING") {
            $order->setDeliveryStatus('DELIVERED');
            $em1->persist($order);
            
            for ($i = 0; $i < count($order->getItems()); $i++) {
                $skuData = $order->getItems()[$i];
                
                $sku = $em1->find('SKU', $skuData->getSku());
                if ($sku == null) {
                    echo "skuCode null";
                    throw new NotFoundException();
                }

                $prodStat = $em1->find('ProductStat', array("sku" => $skuData->getSku(), "date" => $order->getDate(), "branch" => $order->getBranch()));
                if ($prodStat != null && $prodStat->getDate() == $order->getDate()) {
                    echo "hi somrat";
                    $prodStat->setCounter($prodStat->getCounter() + $skuData->getQuantity());
                    $em1->persist($prodStat);
                }else {
                    echo "bye somrat";
                    $prodStat = new ProductStat($sku, $order->getDate(), $order->getBranch());
                    $prodStat->setCounter($skuData->getQuantity());
                    $prodStat->setSource($order->getSource());
                    $prodStat->setProduct($sku->getProduct());
                    $prodStat->setCreatedTime(new \DateTime('now'));
                    $em1->persist($prodStat);
                }
            }
        }else {
            throw new PreconditionFailedException();
        }
        
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
    }

    public function returnSalesInvoice($data, $skus, $oldSkus, $sellerId) {
        $em1 = getEntityManager();
        $returnArray = array();

        $user = $em1->find('User', $sellerId);
        $parentInvoice = $em1->find('Invoice', $data->returnId);
        if ($parentInvoice == null) {
            throw new NotFoundException();
        }
        date_default_timezone_set("Asia/Dhaka");
        $onlyDate = date('Y-m-d');
        $t = microtime(true);
        $micro = sprintf("%06d",($t - floor($t)) * 1000000);
        $dateMicroSec = "'". date('Ymdhis'.$micro, $t) ."'";
        $invoiceId = strtoupper(base_convert($dateMicroSec, 10, 36)) . '-' . $sellerId . '-' . $data->branchId;

        if (count($data->skus) != 0 ) {    

            $invoice = new Invoice();
            $invoice->setId($invoiceId);
            $invoice->setType('SALES');
            $invoice->setSubType('SALES');
            $invoice->setPaymentType('CASH');
            $invoice->setPaymentStatus('RECEIVED');
            $invoice->setDeliveryStatus('COMPLETE');
            $invoice->setOrderStatus('');
            $invoice->setSource($data->source);
            $invoice->setTotal($data->total);
            $invoice->setVatPercentage($data->vatPercentage);
            $invoice->setVatAmount($data->vatAmount);
            $invoice->setNetTotal($data->netTotal);
            $invoice->setGrandTotal($data->grandTotal);
            $invoice->setDiscount($data->discount);
            $invoice->setDiscountType($data->discountType);
            $invoice->setCreatedTime(new \DateTime('now'));
            $invoice->setDate($onlyDate);
            $invoice->setCreatedBy($user);
            $invoice->setParentInvoice($parentInvoice);
            if (isset($data->remark) && $data->remark != null) {
                $invoice->setRemark($data->remark);
            } else {
                $invoice->setRemark("");
            }
            $invoice->setName(''); 
            $invoice->setEmail(''); 
            $invoice->setContactNo(''); 
            $invoice->setContactAddress('');

            $branch = $em1->find('Branch', $data->branchId);
            if ($branch != null)
            $invoice->setBranch($branch);
            
            $em1->persist($invoice);

            global $stocksV2Repository;
            $parentInvoice->addLinkedInvoice($invoice);
            $em1->persist($parentInvoice);

            for ($i = 0; $i < count($data->skus); $i++) {
                $skuData = $data->skus[$i];
                $item = new InvoiceItem($i, $invoice);
                $item->setSku($skuData->code);
                $item->setPrice($skuData->price);
                $item->setQuantity($skuData->quantity);
                $item->setSubTotal($skuData->price * $skuData->quantity);
                
                $sku1 = $skus[$i];
                $item->setTitle($sku1[0]->getProduct()->getTitle() . "-" . $sku1[0]->getLabel());
                if ($sku1[0]->getProduct()->getImages()->count() > 0)
                    $item->setMainImageUrl($sku1[0]->getProduct()->getImages()[0]->getId());
                else {
                    $item->setMainImageUrl("");
                }
                $em1->persist($item);
                $stocksV2Repository->saleStock($em1, $skuData->code, $branch, $skuData->quantity);

                $sku2 = $em1->find('SKU', $skuData->code);
                if ($sku2 == null) {
                    throw new NotFoundException();
                }

                $prodStat = $em1->find('ProductStat', array("sku" => $skuData->code, "date" => $onlyDate, "branch" => $branch));
                if ($prodStat != null && $prodStat->getDate() == $onlyDate) {
                    $prodStat->setCounter($prodStat->getCounter() + $skuData->quantity);
                    $em1->persist($prodStat);
                }else {
                    $prodStat = new ProductStat($sku2, $onlyDate, $branch);
                    $prodStat->setCounter($skuData->quantity);
                    $prodStat->setSource($invoice->getSource());
                    $prodStat->setProduct($sku2->getProduct());
                    $prodStat->setCreatedTime(new \DateTime('now'));
                    $em1->persist($prodStat);
                }
            }
            if ($invoice->getId() != null) {
                array_push($returnArray, array('sales' => $invoice->getId()));
            }
        }
        try {
            $em1->flush();
        }  catch (UniqueConstraintViolationException $ex) {
            echo $ex->getMessage();
            die();
        }
        
        $oldinvoice2 = $em1->find('Invoice', $data->returnId);

        if ($oldinvoice2 == null) {
            throw new NotFoundException();
        }
        
        date_default_timezone_set("Asia/Dhaka");
        $t = microtime(true);
        $micro = sprintf("%06d",($t - floor($t)) * 1000000);
        $dateMicroSecn = "'". date('Ymdhis'.$micro, $t) ."'";
        $invoiceId2 = strtoupper(base_convert($dateMicroSecn, 10, 36)) . '-' . $sellerId . '-' . $data->branchId;
        if (count($data->oldSkus) != 0 ) {
            $returnedInvoice = new Invoice();
            $returnedInvoice->setId($invoiceId2);
            $returnedInvoice->setType('SALES');
            $returnedInvoice->setSubType('RETURN');
            $returnedInvoice->setPaymentType('CASH');
            $returnedInvoice->setPaymentStatus('RECEIVED');
            $returnedInvoice->setDeliveryStatus('COMPLETE');
            $returnedInvoice->setOrderStatus('');
            $returnedInvoice->setSource($data->source);
            $returnedInvoice->setTotal($data->oldTotal);
            $returnedInvoice->setVatPercentage(0);
            $returnedInvoice->setVatAmount(0);
            $returnedInvoice->setNetTotal($data->netoldTotal);
            $returnedInvoice->setGrandTotal($data->grandoldTotal);
            $returnedInvoice->setDiscount(0);
            $returnedInvoice->setDiscountType($data->discountType);
            $returnedInvoice->setCreatedTime(new \DateTime('now'));
            $returnedInvoice->setDate($onlyDate);
            $returnedInvoice->setCreatedBy($user);
            $returnedInvoice->setParentInvoice($parentInvoice);
            if (isset($data->remark) && $data->remark != null) {
                $returnedInvoice->setRemark($data->remark);
            } else {
                $returnedInvoice->setRemark("");
            }
            $returnedInvoice->setName(''); 
            $returnedInvoice->setEmail(''); 
            $returnedInvoice->setContactNo(''); 
            $returnedInvoice->setContactAddress('');

            $branch = $em1->find('Branch', $data->branchId);
            if ($branch != null)
            $returnedInvoice->setBranch($branch);
            
            $em1->persist($returnedInvoice);
        
                        
            $parentInvoice->addLinkedInvoice($returnedInvoice);
            $em1->persist($parentInvoice);
            for ($i = 0; $i < count($data->oldSkus); $i++) {
                $skuData = $data->oldSkus[$i];
                if ($skuData == null) {
                    throw new NotFoundException();
                }
                $item = new InvoiceItem($i, $returnedInvoice);
                $item->setSku($skuData->code);
                $item->setPrice($skuData->price);
                $item->setQuantity($skuData->quantity);
                $item->setSubTotal($skuData->price * $skuData->quantity);
                
                $sku1 = $oldSkus[$i];
                $item->setTitle($sku1[0]->getProduct()->getTitle() . "-" . $sku1[0]->getLabel());
                if ($sku1[0]->getProduct()->getImages()->count() > 0)
                    $item->setMainImageUrl($sku1[0]->getProduct()->getImages()[0]->getId());
                else {
                    $item->setMainImageUrl("");
                }
                $em1->persist($item);

                $stock = $em1->find("StockV2", array("sku" => $skuData->code, "branch" => $oldinvoice2->getBranch()->getId()));
                if ($stock == null) {
                    throw new NotFoundException();
                }
                $stock->setTotal($stock->getTotal() + $skuData->quantity);
                $em1->persist($stock);
            }
            if ($returnedInvoice->getId() != null) {
                array_push($returnArray, array('return' => $returnedInvoice->getId()));
            }
        }
        
        try {
            $em1->flush();
        }  catch (UniqueConstraintViolationException $ex) {
            echo $ex->getMessage();
            echo "h1";
            die();
        } catch (DBALException $ex) {
            echo $ex->getMessage();
            echo "h2";
            die();
        } catch(ORMException $ex) {
            echo $ex->getMessage();
            echo "h3";
            die();
        } catch(Exception $ex) {
            echo $ex->getMessage();
            echo "h4";
            die();
        }
        
        

        return $returnArray;

    }

    public function save($data, $userId) {
        $em1 = getEntityManager();
        $invoice = new Invoice();
        $invoice->setTotal($data->total);
        $invoice->setGrandTotal($data->grandTotal);
        $invoice->setDiscount($data->discount);
        $invoice->setDiscountType($data->discountType);
        $invoice->setCreatedTime(new \DateTime('now'));
        $invoice->setDate(date('Ymd'));
        $user = $em1->find('User', $userId);
        foreach ($user->getBranches() as $branchId) {
            $branch = $em1->find('Branch', $branchId);
        }
        date_default_timezone_set("Asia/Dhaka");
        if ($branch != null) {
            $invoiceId = date('Ymdhis') . '-' . $userId . '-' . $branch->getId();
        } else {
            $invoiceId = date('Ymdhis') . '-' . $userId . '-' . mt_rand(10, 99);
        }
        $invoice->setId($invoiceId);
        $em1->persist($invoice);
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }
        return $invoice->getId();
    }

    public function update($data) {
        $em1 = getEntityManager();
        $invoice = $em1->find('Invoice', $data->code);
        if ($invoice != null) {
            $invoice->setPrice($data->price);
            $invoice->setDiscountPrice($data->discountPrice);
        } else {
            sendEmptyJsonResponse(404);
        }
        $em1->persist($invoice);
        $em1->flush();
        return $invoice->getCode();
    }

    private function computedInvoice($id) {
        $em1 = getEntityManager();
        $skuArray = array();
        $invoice = $em1->find('Invoice', $id);

        $rootInvoice = null;

        if ($invoice->getParentInvoice() == null) {
            $rootInvoice = $invoice;
        } else {
            $rootInvoice = $invoice->getParentInvoice();
        }


        $items = array();
        foreach ($rootInvoice->getItems() as $item) {
            array_push($items, $item);
        }

        foreach($rootInvoice->getLinkedInvoices() as $childInvoice) {
            foreach($childInvoice->getItems() as $item) {
                $loc = $this->arrayLocation($items, $item);
                if ($loc != -1) {
                    if ($childInvoice->getSubType() == 'SALES') {
                        $items[$loc]->setQuantity($items[$loc]->getQuantity() + $item->getQuantity());
                    } else if ($childInvoice->getSubType() == 'RETURN') {
                        $items[$loc]->setQuantity($items[$loc]->getQuantity() - $item->getQuantity());
                    }
                } else {
                    if ($childInvoice->getSubType() == 'SALES') {
                        array_push($items, $item);
                    } else if ($childInvoice->getSubType() == 'RETURN') {
                        array_push($items, $item);
                        /* should never happen, if its here front end is not validating properly */
                        $items[count($items) - 1]->setQuantity($items[count($items) - 1]->getQuantity() * 1);
                    }
                }
                
            }
            
        }
        
        return $items;

        

    }

    private function arrayLocation($arr, $item) {
        $sz = count($arr);
        for ($i = 0; $i < $sz; $i++) {
            if ($arr[$i]->getSku() == $item->getSku()) {
                return $i;
            }
        }
        return -1;
    }

    public function findOne($id, $limit, $startIndex) {
        $dql = "SELECT i FROM Invoice i WHERE i.id = '$id' ORDER BY i.createdTime desc";
        $query = getEntityManager()->createQuery($dql)
                                    ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findByInvoiceId($id) {
        $invoice = getEntityManager()->find('Invoice', $id);
        if ($invoice != null) {
            $computedItems = $this->computedInvoice($invoice);
            $invoice->setComputed($computedItems);
        }
        return $invoice;
    }

    public function delete($code) {
        $dql = "DELETE Invoice s WHERE s.code = $code";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

    public function listInvoice($branchId, $source, $deliveryStatus, $paymentStatus, $type, $startDate, $endDate, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('i')
            ->from('Invoice', 'i');

        if ($branchId != -1) {
            $qb->join('i.branch', 'b')
                ->where("b.id  = $branchId");
        }
        
        if ($source != null){
            $qb->andWhere("i.source = '$source'");
        }

        if ($deliveryStatus != null){
            $qb->andWhere("i.deliveryStatus = '$deliveryStatus'");
        }

        if ($paymentStatus != null){
            $qb->andWhere("i.paymentStatus = '$paymentStatus'");
        }

        if ($type != null){
            $qb->andWhere("i.subType = '$type'");
        }

        if ($startDate != null && $endDate != null) {
            $startTime = $startDate . " 00:00:00";
            $endTime = $endDate . " 23:59:59";
            $qb->andWhere("i.createdTime between '$startTime' AND '$endTime'");
        }
        
        $qb->orderBy('i.createdTime', 'DESC');
        // echo $qb->getQuery()->getSQL();die();
        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    public function listEcommerceInvoice($branchId, $deliveryStatus, $paymentStatus, $orderStatus, $contactNo, $startDate, $endDate, $limit, $startIndex) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select('i')
            ->from('Invoice', 'i')
            ->where("i.source  = 'ECOMMERCE'");

        
        if ($branchId != -1) {
            $qb->join('i.branch', 'b')
                ->andWhere("b.id  = $branchId");
        }

        if ($deliveryStatus != null){
            $qb->andWhere("i.deliveryStatus = '$deliveryStatus'");
        }

        if ($paymentStatus != null){
            $qb->andWhere("i.paymentStatus = '$paymentStatus'");
        }

        if ($orderStatus != null){
            $qb->andWhere("i.orderStatus = '$orderStatus'");
        }

        if ($contactNo != null){
            // $qb->andWhere("i.contactNo = '$contactNo'");
            $qb->andWhere($qb->expr()->like('i.contactNo', "'%" . $contactNo . "%'"));

        }

        if ($startDate != null && $endDate != null) {
            $startTime = $startDate . " 00:00:00";
            $endTime = $endDate . " 23:59:59";
            $qb->andWhere("i.createdTime between '$startTime' AND '$endTime'");
        }
        
        $qb->orderBy('i.createdTime', 'DESC');
        
        $qb->setMaxResults($limit)
            ->setFirstResult($startIndex);
        return $qb->getQuery()->getResult();
    }

    public function aggregateTotal($branchId, $startDate, $endDate) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select(array('i.source', 'i.type', 'i.subType', 'SUM(i.total) as total', 'SUM(i.grandTotal) as grandTotal' , 'SUM(i.netTotal) as netTotal', 'SUM(i.vatAmount) as vat', 'b.id as branchId' , 'b.branchName'))
           ->from('Invoice', 'i')
           ->join('i.branch', 'b')
           ->addGroupBy('i.source')
           ->addGroupBy('i.type')
           ->addGroupBy('i.subType')
           ->addGroupBy('b.id');

       if ($branchId != -1) {
          $qb->andWhere("b.id = $branchId");
       }
       
       if ($startDate != null && $endDate != null) {
          $startTime = $startDate . " 00:00:00";
          $endTime = $endDate . " 23:59:59";
          $qb->andWhere("i.createdTime between '$startTime' AND '$endTime'");
       }
       return $qb->getQuery()->getResult();
    }

    public function aggregateDateWise($branchId, $startDate, $endDate) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select(array('i.date', 'i.source', 'i.type', 'i.subType', 'SUM(i.total) as total', 'SUM(i.grandTotal) as grandTotal' , 'SUM(i.netTotal) as netTotal', 'SUM(i.vatAmount) as vat', 'b.id as branchId' , 'b.branchName'))
           ->from('Invoice', 'i')
           ->join('i.branch', 'b')
           ->addGroupBy('i.source')
           ->addGroupBy('i.type')
           ->addGroupBy('i.subType')
           ->addGroupBy('i.date')
           ->addGroupBy('b.id');

        if ($branchId != -1) {
            $qb->andWhere("b.id = $branchId");
        }

        // if ($source != null){
        //     $qb->andWhere("i.source = '$source'");
        // }

        if ($startDate != null && $endDate != null) {
            $startTime = $startDate . " 00:00:00";
            $endTime = $endDate . " 23:59:59";
            $qb->andWhere("i.createdTime between '$startTime' AND '$endTime'");
        }
        //    echo $qb->getDql();   
        //    echo $qb->getQuery()->getSQL();die();
        return $qb->getQuery()->getResult();
    }
    public function aggregateDateWiseForStats($branchId, $prodId, $startDate, $endDate) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select(array('i.date', 'i.source', 'i.type', 'i.subType', 'SUM(i.total) as total', 'SUM(i.grandTotal) as grandTotal' , 'SUM(i.netTotal) as netTotal', 'SUM(i.vatAmount) as vat', 'ii.quantity' , 'ii.title' , 'b.id as branchId' , 'b.branchName'))
           ->from('Invoice', 'i')
           ->join('i.branch', 'b')
           ->join('i.items', 'ii')
        //    ->join('ii.sku', 's')
           ->addGroupBy('i.source')
           ->addGroupBy('i.type')
           ->addGroupBy('i.subType')
           ->addGroupBy('i.date')
           ->addGroupBy('b.id');

        if ($branchId != -1) {
            $qb->andWhere("b.id = $branchId");
        }

        if ($prodId != null) {
            $qb->andWhere($qb->expr()->like('ii.sku', "'" . $prodId . "%'"));
            // $qb->andWhere("ii. = '$prodId'");
        }

        if ($startDate != null && $endDate != null) {
            $startTime = $startDate . " 00:00:00";
            $endTime = $endDate . " 23:59:59";
            $qb->andWhere("i.createdTime between '$startTime' AND '$endTime'");
        }
        //    echo $qb->getDql(); die();
        //    echo $qb->getQuery()->getSQL();die();
        return $qb->getQuery()->getResult();
    }

    public function aggregateFranchiseSalesDateWise($branchId, $startDate, $endDate) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select(array('i.date', 'i.source', 'i.type', 'i.subType', 'SUM(i.total) as total', 'SUM(i.grandTotal) as grandTotal' , 'SUM(i.totalCommission) as totalCommission' , 'SUM(i.netTotal) as netTotal', 'SUM(i.vatAmount) as vat', 'b.id as branchId' , 'b.branchName' , 'b.commissionPercentage'))
           ->from('Invoice', 'i')
           ->join('i.branch', 'b')
           ->addGroupBy('i.source')
           ->addGroupBy('i.type')
           ->addGroupBy('i.subType')
           ->addGroupBy('i.date')
           ->addGroupBy('b.id');

        if ($branchId != -1) {
            $qb->andWhere("b.id = $branchId");
            $qb->andWhere("b.type = 'FRANCHISE-SHOWROOM'");
        }

        if ($startDate != null && $endDate != null) {
            $startTime = $startDate . " 00:00:00";
            $endTime = $endDate . " 23:59:59";
            $qb->andWhere("i.createdTime between '$startTime' AND '$endTime'");
        }
        
        return $qb->getQuery()->getResult();
    }

    public function aggregateFranchiseTotal($branchId, $startDate, $endDate) {
        $em1 = getEntityManager();
        $qb = $em1->createQueryBuilder();
        $qb->select(array('i.source', 'i.type', 'i.subType', 'SUM(i.total) as total', 'SUM(i.grandTotal) as grandTotal' , 'SUM(i.totalCommission) as totalCommission' , 'SUM(i.netTotal) as netTotal', 'SUM(i.vatAmount) as vat', 'b.id as branchId' , 'b.branchName' , 'b.commissionPercentage'))
           ->from('Invoice', 'i')
           ->join('i.branch', 'b')
           ->addGroupBy('i.source')
           ->addGroupBy('i.type')
           ->addGroupBy('i.subType')
           ->addGroupBy('b.id');

       if ($branchId != -1) {
          $qb->andWhere("b.id = $branchId");
       }
       
       if ($startDate != null && $endDate != null) {
          $startTime = $startDate . " 00:00:00";
          $endTime = $endDate . " 23:59:59";
          $qb->andWhere("i.createdTime between '$startTime' AND '$endTime'");
       }
       return $qb->getQuery()->getResult();
    }
}

$invoicesRepository = $em->getRepository('Invoice');