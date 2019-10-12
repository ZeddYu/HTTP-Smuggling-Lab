<?php
echo 'This is LAMP:80<br>';
var_dump(getallheaders());
$data = file_get_contents("php://input");
print_r($data);