<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
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
    $filterToday = isset($_GET['today']) ? ($_GET['today'] === 'true') : false;

    if ($filterToday) {
        $sql = "SELECT * FROM ticket WHERE DATE(timeCreated) = CURDATE() AND (status = 'Pending' OR status = 'Serving')";
        $stmt = $pdo->prepare($sql);
    } else {
        $sql = "SELECT * FROM ticket";
        $stmt = $pdo->prepare($sql);
    }

    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result);
}

function handlePost($pdo, $input) {
    $sql = "INSERT INTO ticket (timeCreated, number, serviceCode, serviceType, userAssigned, stationName, stationNumber, timeTaken, timeDone, status, log, priority, priorityType, printStatus, callCheck, ticketName, blinker, gender) VALUES (:timeCreated, :number, :serviceCode, :serviceType, :userAssigned, :stationName, :stationNumber, :timeTaken, :timeDone, :status, :log, :priority, :priorityType, :printStatus, :callCheck, :ticketName, :blinker, :gender)";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        'timeCreated' => $input['timeCreated'],
        'number' => $input['number'],
        'serviceCode' => $input['serviceCode'],
        'serviceType' => $input['serviceType'],
        'userAssigned' => $input['userAssigned'],
        'stationName' => $input['stationName'],
        'stationNumber' => $input['stationNumber'],
        'timeTaken' => $input['timeTaken'],
        'timeDone' => $input['timeDone'],
        'status' => $input['status'],
        'log' => $input['log'],
        'priority' => $input['priority'],
        'priorityType' => $input['priorityType'],
        'printStatus' => $input['printStatus'],
        'callCheck' => $input['callCheck'],
        'ticketName' => $input['ticketName'],
        'blinker' => $input['blinker'],
        'gender' => $input['gender']
    ]);
    echo json_encode(['message' => 'Ticket created successfully']);
}

function handlePut($pdo, $input) {
    if (!isset($input['id'])) {
        echo json_encode(['message' => 'Ticket ID is required']);
        return;
    }

    $id = $input['id'];
    unset($input['id']); // remove ID from fields to update

    if (empty($input)) {
        echo json_encode(['message' => 'No fields to update']);
        return;
    }

    // Build dynamic SQL
    $fields = [];
    $params = [];
    foreach ($input as $key => $value) {
        $fields[] = "$key = :$key";
        $params[$key] = $value;
    }
    $params['id'] = $id;

    $sql = "UPDATE ticket SET " . implode(', ', $fields) . " WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    echo json_encode(['message' => 'Ticket updated successfully']);
}


function handleDelete($pdo, $input) {
    $sql = "DELETE FROM ticket WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $input['id']]);
    echo json_encode(['message' => 'Ticket deleted successfully']);
}
?>
