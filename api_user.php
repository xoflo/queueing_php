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
    $sql = "SELECT * FROM user";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result);
}

function handlePost($pdo, $input) {
    $sql = "INSERT INTO user (username, pass, userType, serviceType, loggedIn, servicesSet) VALUES (:username, :pass, :userType, :serviceType, :loggedIn, :servicesSet)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['username' => $input['username'], 'pass' => $input['pass'], 'userType' => $input['userType'], 'serviceType' => $input['serviceType'], 'loggedIn' => $input['loggedIn'], 'servicesSet' => $input['servicesSet']]);
    echo json_encode(['message' => 'User created successfully']);
}

function handlePut($pdo, $input) {
    $sql = "UPDATE user SET username = :username, pass = :pass, userType = :userType, serviceType = :serviceType, loggedIn = :loggedIn, servicesSet = :servicesSet WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['username' => $input['username'], 'pass' => $input['pass'], 'userType' => $input['userType'], 'serviceType' => $input['serviceType'], 'loggedIn' => $input['loggedIn'], 'servicesSet' => $input['servicesSet'], 'id' => $input['id']]);
    echo json_encode(['message' => 'User updated successfully']);
}

function handleDelete($pdo, $input) {
    $sql = "DELETE FROM user WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id']]);
    echo json_encode(['message' => 'User deleted successfully']);
}
?>