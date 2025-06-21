<?php
$conn = new mysqli("localhost", "root", "", "video_app");

if ($_FILES['file']['error'] === UPLOAD_ERR_OK) {
    $uploadDir = __DIR__ . '/videos/';
    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }

    $filename = basename($_FILES['file']['name']);
    $target = $uploadDir . $filename;

    if (move_uploaded_file($_FILES['file']['tmp_name'], $target)) {
        $relPath = "videos/" . $filename;
        $stmt = $conn->prepare("INSERT INTO videos (name, path) VALUES (?, ?)");
        $stmt->bind_param("ss", $filename, $relPath);
        $stmt->execute();

        echo "Success";
    } else {
        echo "Move failed";
    }
} else {
    echo "Upload error";
}
?>