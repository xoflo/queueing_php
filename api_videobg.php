<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if (isset($_FILES['file'])) {
    echo "File received: " . $_FILES['file']['name'] . "\n";
    echo "Size: " . $_FILES['file']['size'] . " bytes\n";

    $targetDir = "bgvideos/";
    if (!file_exists($targetDir)) {
        mkdir($targetDir, 0777, true);
    }

    $targetFile = $targetDir . basename($_FILES["file"]["name"]);
    if (move_uploaded_file($_FILES["file"]["tmp_name"], $targetFile)) {
        echo "Saved to: $targetFile";
    } else {
        echo "Failed to move uploaded file.";
    }
} else {
    echo "No file received!";
}