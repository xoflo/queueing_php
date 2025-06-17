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
    $sql = "SELECT * FROM station";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result);
}

function handlePost($pdo, $input) {
    $sql = "INSERT INTO station (sessionPing, stationNumber, inSession, userInSession, ticketServing, stationName) VALUES (:sessionPing, :stationNumber, :inSession, :userInSession, :ticketServing, :stationName)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['sessionPing' => $input['sessionPing'], 'stationNumber' => $input['stationNumber'], 'inSession' => $input['inSession'], 'userInSession' => $input['userInSession'], 'ticketServing' => $input['ticketServing'], 'stationName' => $input['stationName']]);
    echo json_encode(['message' => 'Station created successfully']);
}

function handlePut($pdo, $input) {
    $sql = "UPDATE station SET sessionPing = :sessionPing,stationNumber = :stationNumber, inSession = :inSession, userInSession = :userInSession, ticketServing = :ticketServing, stationName = :stationName WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['sessionPing' => $input['sessionPing'], 'stationNumber' => $input['stationNumber'], 'inSession' => $input['inSession'], 'userInSession' => $input['userInSession'], 'ticketServing' => $input['ticketServing'], 'stationName' => $input['stationName'], 'id' => $input['id']]);
    echo json_encode(['message' => 'Station updated successfully']);
}

function handleDelete($pdo, $input) {
    $sql = "DELETE FROM station WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id']]);
    echo json_encode(['message' => 'Station deleted successfully']);
}
?>