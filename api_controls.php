<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");
include 'db.php';

$method = $_SERVER['REQUEST_METHOD'];
$input = json_decode(file_get_contents('php://input'), true);

switch ($method) {
    case 'GET':
        handleGet($pdo);
        break;
    case 'POST':
        handlePost($pdo, $input);
        break;
    case 'PUT':
        handlePut($pdo, $input);
        break;
    case 'DELETE':
        handleDelete($pdo, $input);
        break;
    default:
        echo json_encode(['message' => 'Invalid request method']);
        break;
}

function handleGet($pdo) {
    $sql = "SELECT * FROM controls";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result);
}

function handlePost($pdo, $input) {
    $sql = "INSERT INTO controls (id, controlName, value) VALUES (:id, :controlName, :value)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id'], 'controlName' => $input['controlName'], 'value' => $input['value']]);
    echo json_encode(['message' => 'Control created successfully']);
}

function handlePut($pdo, $input) {
    $sql = "UPDATE controls SET id = :id, controlName = :controlName, value = :value WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id'], 'controlName' => $input['controlName'], 'value' => $input['value']]);
    echo json_encode(['message' => 'Control updated successfully']);
}

function handleDelete($pdo, $input) {
    $sql = "DELETE FROM controls WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id']]);
    echo json_encode(['message' => 'Control deleted successfully']);
}
?>