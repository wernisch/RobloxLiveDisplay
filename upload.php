<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');

$width = 128;
$height = 72;

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['image'])) {
    $image = imagecreatefromstring(file_get_contents($_FILES['image']['tmp_name']));
    
    if ($image === false) {
        echo json_encode(['error' => 'Failed to create image from data']);
        exit;
    }

    $pixels = [];
    for ($y = 0; $y < $height; $y++) {
        for ($x = 0; $x < $width; $x++) {
            $colorIndex = imagecolorat($image, $x, $y);
            $colors = imagecolorsforindex($image, $colorIndex);
            $hexColor = sprintf("#%02x%02x%02x", $colors['red'], $colors['green'], $colors['blue']);
            $pixels[] = ['x' => $x, 'y' => $y, 'color' => $hexColor];
        }
    }

    file_put_contents('pixels.json', json_encode(['pixels' => $pixels]));

    echo json_encode(['success' => true]);
    exit;
}

echo json_encode(['error' => 'Invalid request method']);
?>
