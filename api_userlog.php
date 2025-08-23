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
    $sql = "SELECT * FROM userlog";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result);
}

function handlePost($pdo, $input) {
    $sql = "INSERT INTO userlog (state, userId, user) VALUES (:state, :userId, :user)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['state' => $input['state'], 'userId' => $input['userId'], 'user' => $input['user']]);
    echo json_encode(['message' => 'Userlog created successfully']);
}

function handlePut($pdo, $input) {
    $sql = "UPDATE userlog SET state = :state, userId = :userId, user = :user WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['state' => $input['state'], 'userId' => $input['userId'], 'user' => $input['user'], 'id' => $input['id']]);
    echo json_encode(['message' => 'Userlog updated successfully']);
}

function handleDelete($pdo, $input) {
    $sql = "DELETE FROM userlog WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id']]);
    echo json_encode(['message' => 'Userlog deleted successfully']);
}
?>