<?php
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
    $sql = "SELECT * FROM service";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result);
}

function handlePost($pdo, $input) {
    $sql = "INSERT INTO service (serviceType, serviceCode) VALUES (:serviceType, :serviceCode)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['serviceType' => $input['serviceType'], 'serviceCode' => $input['serviceCode']]);
    echo json_encode(['message' => 'Service created successfully']);
}

function handlePut($pdo, $input) {
    $sql = "UPDATE service SET serviceType = :serviceType, serviceCode = :serviceCode WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['serviceType' => $input['serviceType'], 'serviceCode' => $input['serviceCode'], 'id' => $input['id']]);
    echo json_encode(['message' => 'Service updated successfully']);
}

function handleDelete($pdo, $input) {
    $sql = "DELETE FROM service WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id']]);
    echo json_encode(['message' => 'Service deleted successfully']);
}
?>