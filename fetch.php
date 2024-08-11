<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

if (file_exists('pixels.json')) {
    $json = file_get_contents('pixels.json');
    echo $json;
} else {
    echo json_encode(['error' => 'No pixel data found']);
}
?>
