<?php
use Doctrine\ORM\EntityRepository;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;

class SearchIndicesRepository extends EntityRepository
{

    public function createSearchIndex($data) {
        $em1 = getEntityManager();
        $prod = $em1->find('Product', $data);
        if ($prod == null) {
            throw new NotFoundException();
        }
        $searchIndex = $em1->find('SearchIndex', $data);
       
        if ($searchIndex == null) {
            $searchIndex = new SearchIndex($prod);
        }
        
        $lookupId = '';
        $lookupName = '';
        foreach ($prod->getLookups() as $lookup) {
            $lookupId = $lookupId . "#" . $lookup->getId();
            $string = str_replace(" ", "-", strtolower($lookup->getName()));
            $lookupName = $lookupName . "#" . $string;
        }

        
        
        $lookupIds = $lookupId. "#";
        $lookupNames = $lookupName. "#";
        $searchIndex->setLookups($lookupIds);
        $searchIndex->setLookupNames($lookupNames);

        $tagName = '';
        $tagArr = explode(",",$prod->getTags());
        // echo "tag Array - ";
        // print_r($tagArr);die();
        foreach ($tagArr as $tag) {
            $tagName = $tagName . "#" . $tag;
        }
        $tags = $tagName . "#";
        // echo "tag Array 2 - ";
        // echo $tags;die();
        $searchIndex->setTags($tags);

        $attributeValueId = '';
        $attributeValueName = '';
        foreach ($prod->getSkus() as $sku) {
            foreach ($sku->getAttributeValues() as $attriVal) {
                $attributeValueId = $attributeValueId . "#" . $attriVal->getId();
                $string = str_replace(" ", "-", strtolower($attriVal->getValue()));
                $attributeValueName = $attributeValueName . "#" . $string;
            }
        }
        $attributeValueIds = $attributeValueId . "#";
        $attributeValueNames = $attributeValueName . "#";
        $searchIndex->setAttributeValues($attributeValueIds);
        $searchIndex->setAttributeValueNames($attributeValueNames);
        $em1->persist($searchIndex);

        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            echo $ex->getMessage();die();
            throw new ConflictException();
        }
        
    }

    public function createAllSearchIndex() {
        $em1 = getEntityManager();

        
        $products = $em1->createQuery("SELECT p FROM Product p")->getResult();
        if ($products == null) {
           throw new NotFoundException();
        }
        foreach ($products as $product) {
            
            $searchIndex = $em1->find("SearchIndex", array("product" => $product->getId()));
            // $em1->find('SearchIndex', $product);
       
            if ($searchIndex == null) {
                $searchIndex = new SearchIndex($product);
            }
            
            $lookupId = '';
            $lookupName = '';
            foreach ($product->getLookups() as $lookup) {
                $lookupId = $lookupId . "#" . $lookup->getId();
                $string = str_replace(" ", "-", strtolower($lookup->getName()));
                $lookupName = $lookupName . "#" . $string;
            }
            $lookupIds = $lookupId. "#";
            $lookupNames = $lookupName. "#";
            $searchIndex->setLookups($lookupIds);
            $searchIndex->setLookupNames($lookupNames);

            $attributeValueId = '';
            $attributeValueName = '';
            foreach ($product->getSkus() as $sku) {
                foreach ($sku->getAttributeValues() as $attriVal) {
                    $attributeValueId = $attributeValueId . "#" . $attriVal->getId();
                    $string = str_replace(" ", "-", strtolower($attriVal->getValue()));
                    $attributeValueName = $attributeValueName . "#" . $string;
                }
            }
            $attributeValueIds = $attributeValueId . "#";
            $attributeValueNames = $attributeValueName . "#";
            $searchIndex->setAttributeValues($attributeValueIds);
            $searchIndex->setAttributeValueNames($attributeValueNames);

            $tags = $product->getTags();
            $searchIndex->setTags($tags);
            $em1->persist($searchIndex);
            
        }

        try {
            $em1->flush();
        } catch(UniqueConstraintViolationException $ex) {
            // echo $ex->getMessage();die();
            throw new ConflictException();
        }
    }
}

$searchIndicesRepository = $em->getRepository('SearchIndex');