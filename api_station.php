<?php

header("Access-Control-Allow-Origin: *"); // Allow all origins, or specify like http://localhost:8080
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

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
    $sql = "INSERT INTO station (sessionPing, stationNumber, inSession, userInSession, ticketServing, stationName, displayIndex) VALUES (:sessionPing, :stationNumber, :inSession, :userInSession, :ticketServing, :stationName, :displayIndex)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['sessionPing' => $input['sessionPing'], 'stationNumber' => $input['stationNumber'], 'inSession' => $input['inSession'], 'userInSession' => $input['userInSession'], 'ticketServing' => $input['ticketServing'], 'stationName' => $input['stationName'], 'displayIndex' => $input['displayIndex']]);
    echo json_encode(['message' => 'Station created successfully']);
}

function handlePut($pdo, $input) {
    $sql = "UPDATE station SET sessionPing = :sessionPing,stationNumber = :stationNumber, inSession = :inSession, userInSession = :userInSession, ticketServing = :ticketServing, stationName = :stationName, displayIndex = :displayIndex WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['sessionPing' => $input['sessionPing'], 'stationNumber' => $input['stationNumber'], 'inSession' => $input['inSession'], 'userInSession' => $input['userInSession'], 'ticketServing' => $input['ticketServing'], 'stationName' => $input['stationName'], 'displayIndex' => $input['displayIndex'], 'id' => $input['id']]);
    echo json_encode(['message' => 'Station updated successfully']);
}

function handleDelete($pdo, $input) {
    $sql = "DELETE FROM station WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id']]);
    echo json_encode(['message' => 'Station deleted successfully']);
}
?>