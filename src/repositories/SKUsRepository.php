<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class SKUsRepository extends EntityRepository {

    public function batchSave($datas) {

        /**
         * TODO: throw error if more than one lapse is found
         */


        $codes = array();

        $em1 = getEntityManager();

        for ($i = 0; $i < count($datas); $i++) {
            $sku = new SKU();
            $sku->setPrice($datas[$i]->price);
            $sku->setDiscountPrice($datas[$i]->discountPrice);
            $sku->setLapse(isset($datas[$i]->lapse) && strtolower($datas[$i]->lapse == 'true'));

            $attrValues = array();
            // sort($datas[$i]->attributeValueIds);
            foreach ($datas[$i]->attributeValueIds as $attrValueId) {
                $attrValue = $em1->find('ItemAttributeValue', $attrValueId);
                if ($attrValue != null) {
                    $sku->addAttributeValue($attrValue);
                    array_push($attrValues, $attrValue);
                }
            }

            $product = $em1->find('Product', $datas[$i]->productId);

            if ($product != null) {
                $sku->setProduct($product);
            }

            $code = $datas[$i]->productId . '-' . $product->getCode();
            $label = '';
            foreach ($attrValues as $attrValue) {
                $code = $code . '-' . $attrValue->getId();
                $label = $label . $attrValue->getValue() . ',';
            }

            $lblLen = strlen($label);
            if ($lblLen > 0) {
                $label = substr($label, 0, $lblLen - 1);
            }

            $sku->setCode($code);
            $sku->setLabel($label);

            $product->addSku($sku);
            $em1->persist($sku);
            $em1->persist($product);

            array_push($codes, $sku->getCode());

        }
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            echo $ex->getMessage();die();
            throw new ConflictException();
        }
        return $codes;
    }

    public function save($data) {

        $em1 = getEntityManager();

        $sku = new SKU();
        $sku->setPrice($data->price);
        $sku->setDiscountPrice($data->discountPrice);
        $sku->setLapse(isset($data->lapse) && strtolower($data->lapse == 'true'));

        $attrValues = array();
        // sort($data->attributeValueIds);
        foreach ($data->attributeValueIds as $attrValueId) {
            $attrValue = $em1->find('ItemAttributeValue', $attrValueId);
            if ($attrValue != null) {
                $sku->addAttributeValue($attrValue);
                array_push($attrValues, $attrValue);
            }
        }

        $product = $em1->find('Product', $data->productId);
        if ($product != null) {
            $sku->setProduct($product);

        }
        $code = $data->productId . '-' . $product->getCode();
        $label = '';
        foreach ($attrValues as $attrValue) {
            $code = $code . '-' . $attrValue->getId();
            $label = $label . $attrValue->getValue() . ',';
        }

        $lblLen = strlen($label);
        if ($lblLen > 0) {
            $label = substr($label, 0, $lblLen - 1);
        }

        $sku->setCode($code);
        $sku->setLabel($label);

        $em1->persist($sku);

        $product->addSku($sku);

        $em1->persist($product);
        try {
            $em1->flush();
        } catch (UniqueConstraintViolationException $ex) {
            throw new ConflictException();
        }

        return $sku->getCode();
    }

    public function update($data) {
        $em1 = getEntityManager();
        $sku = $em1->find('SKU', $data->code);
        if ($sku != null) {
            $sku->setPrice($data->price);
            $sku->setDiscountPrice($data->discountPrice);

            try {
                $em1->persist($sku);
                $em1->flush();
            } catch (UniqueConstraintViolationException $ex) {
                echo $ex->getMessage();die();
                throw new ConflictException();
            }
        } else {
            throw new NotFoundException();
        }
    }

    public function findAllPaginated($limit, $startIndex) {
        $dql = "SELECT s FROM SKU s ORDER BY s.code ASC";

        $query = getEntityManager()->createQuery($dql)
                                   ->setMaxResults($limit)
                                   ->setFirstResult($startIndex);
        return $query->getResult();
    }

    public function findOne($id) {
        return $this->findOneBy(array('id' => $id));
    }

    /* returns single object */
    // public function findByCode($code) {
    //     return $this->findOneBy(array('code' => $code));
    // }

    /* returns single array */
    public function findByCode($code) {
        $dql = "SELECT s, p FROM SKU s JOIN s.product p WHERE s.code = '$code' AND p.status = 'ACTIVE' ORDER BY s.code ASC";
        
        $query = getEntityManager()->createQuery($dql);
        return $query->getResult();
    }

    public function delete($code) {
        $dql = "DELETE SKU s WHERE s.code = $code";
        $query = getEntityManager()->createQuery($dql);
        return $query->execute();
    }

}

$skusRepository = $em->getRepository('SKU');