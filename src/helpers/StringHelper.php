<?php
class StringHelper {
  public static function abbreviate($str) {
      $parts = preg_split('/\s+/', $str);

      $abbr = '';
      if (count($parts) == 1) {
        $abbr .= $parts[0][0];
        for ($i = 1; $i < strlen($parts[0]); $i++){
          if (ctype_alpha($parts[0][$i]) &&
            strtolower($parts[0][$i]) != 'a' &&
            strtolower($parts[0][$i]) != 'e' &&
            strtolower($parts[0][$i]) != 'i' &&
            strtolower($parts[0][$i]) != 'o' &&
            strtolower($parts[0][$i]) != 'u')

            $abbr .= $parts[0][$i];
            if (strlen($abbr) >= 3) {
                return strtoupper($abbr);
            }
        }
      } else {
        $abbr .= $parts[0][0];
        for ($i = 1; $i < count($parts); $i++) {
            if (ctype_alpha($parts[$i][0]) &&
              strtolower($parts[$i][0]) != 'a' &&
              strtolower($parts[$i][0]) != 'e' &&
              strtolower($parts[$i][0]) != 'i' &&
              strtolower($parts[$i][0]) != 'o' &&
              strtolower($parts[$i][0]) != 'u')

              $abbr .= $parts[$i][0];
              if (strlen($abbr) >= 3) {
                  return strtoupper($abbr);
              }
          }
      }


      return strtoupper($abbr);
  }
}
?>
