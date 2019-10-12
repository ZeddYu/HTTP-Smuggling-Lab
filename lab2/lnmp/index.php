<?php
echo 'This is Nginx<br>';
if (!function_exists('getallheaders')) {

    function getallheaders() {
        $headers = array();
        foreach ($_SERVER as $name => $value) {
            if (substr($name, 0, 5) == 'HTTP_') {
                $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
            }
        }
        return $headers;
    }

}
var_dump(getallheaders());
$data = file_get_contents("php://input");
print_r($data);