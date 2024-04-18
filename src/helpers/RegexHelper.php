<?php

class RegexHelper {

    public static function isSkuCode($str) {

        if (str_contains($str, '#')) {
            $parts = explode("#",$str);
            $str = $parts[0];
        }

        // echo $str;
        $pattern = "/^\d+-(.*)-\d+-\d+$/i";
        return preg_match($pattern, $str) == 1;
    }

    public static function parseSkuCode($str) {
      if (str_contains($str, '#')) {
          $parts = explode("#",$str);
          $str = $parts[0];
      }
      return $str;
    }

    public static function isProductCode($str) {

        if (str_contains($str, '#')) {
            $parts = explode("#",$str);
            $str = $parts[0];
        }

        // echo $str;
        $pattern = "/^[A-Z]{1,5}\d{1,5}$/i";
        return preg_match($pattern, $str) == 1;
    }

    public static function parseProductCode($str) {
      if (str_contains($str, '#')) {
          $parts = explode("#", $str);
          $str = $parts[0];
      }
      return $str;
    }

}
