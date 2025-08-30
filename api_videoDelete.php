<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

if (isset($_POST['filename'])) {
    $targetDir = "videos/";
    $filename = basename($_POST['filename']); // Prevent path traversal
    $targetFile = $targetDir . $filename;

    if (file_exists($targetFile)) {
        if (unlink($targetFile)) {
            echo "Deleted: $filename";
        } else {
            echo "Failed to delete: $filename";
        }
    } else {
        echo "File does not exist: $filename";
    }
} else {
    echo "No filename provided!";
}