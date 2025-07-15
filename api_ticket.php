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
    $sql = "SELECT * FROM ticket";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result);
}

function handlePost($pdo, $input) {
    $sql = "INSERT INTO ticket (timeCreated, number, serviceCode, serviceType, userAssigned, stationName, stationNumber, timeTaken, timeDone, status, log, priority, priorityType, printStatus, callCheck, ticketName, blinker, gender) VALUES (:timeCreated, :number, :serviceCode, :serviceType, :userAssigned, :stationName, :stationNumber, :timeTaken, :timeDone, :status, :log, :priority, :priorityType, :printStatus, :callCheck, :ticketName, :blinker, :gender)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['timeCreated' => $input['timeCreated'], 'number' => $input['number'], 'serviceCode' => $input['serviceCode'], 'serviceType' => $input['serviceType'], 'userAssigned' => $input['userAssigned'], 'stationName' => $input['stationName'], 'stationNumber' => $input['stationNumber'], 'timeTaken' => $input['timeTaken'], 'timeDone' => $input['timeDone'], 'status' => $input['status'], 'log' => $input['log'], 'priority' => $input['priority'], 'priorityType' => $input['priorityType'], 'printStatus' => $input['printStatus'], 'callCheck' => $input['callCheck'], 'ticketName' => $input['ticketName'], 'blinker' => $input['blinker'], 'gender' => $input['gender']]);
    echo json_encode(['message' => 'Ticket created successfully']);
}

function handlePut($pdo, $input) {
    $sql = "UPDATE ticket SET timeCreated = :timeCreated, number = :number, serviceCode = :serviceCode, serviceType = :serviceType, userAssigned = :userAssigned, stationName = :stationName, stationNumber = :stationNumber, timeTaken = :timeTaken, timeDone = :timeDone, status = :status, log = :log, priority = :priority, priorityType = :priorityType, printStatus = :printStatus, callCheck = :callCheck, ticketName = :ticketName, blinker = :blinker, gender = :gender  WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['timeCreated' => $input['timeCreated'], 'number' => $input['number'], 'serviceCode' => $input['serviceCode'], 'serviceType' => $input['serviceType'], 'userAssigned' => $input['userAssigned'], 'stationName' => $input['stationName'], 'stationNumber' => $input['stationNumber'], 'timeTaken' => $input['timeTaken'], 'timeDone' => $input['timeDone'], 'status' => $input['status'], 'log' => $input['log'], 'priority' => $input['priority'], 'priorityType' => $input['priorityType'], 'printStatus' => $input['printStatus'], 'callCheck' => $input['callCheck'], 'ticketName' => $input['ticketName'], 'blinker' => $input['blinker'],'gender' => $input['gender'], 'id' => $input['id']]);
    echo json_encode(['message' => 'Ticket updated successfully']);
}

function handleDelete($pdo, $input) {
    $sql = "DELETE FROM ticket WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id']]);
    echo json_encode(['message' => 'Ticket deleted successfully']);
}
?>