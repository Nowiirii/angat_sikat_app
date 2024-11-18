<?php
include('connection.php');

// Initialize an array to hold validation errors
$errors = [];
$data = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve POST variables
    $item_id = $_POST['item_id'];
    $description = $_POST['description'];
    $quantity = $_POST['quantity'];
    $unit = $_POST['unit'];
    $amount = $_POST['amount'];

    // Validate input
    if (empty($description) || empty($quantity) || empty($unit) || empty($amount)) {
        $errors[] = 'All fields are required.';
    }

    // Check for validation errors before proceeding
    if (!empty($errors)) {
        $data['success'] = false;
        $data['errors'] = $errors;
        echo json_encode($data);
        exit;
    } else {
        // Prepare the SQL query using a prepared statement
        $query = "UPDATE event_items SET description = ?, quantity = ?, unit = ?, amount = ? WHERE item_id = ?";
        $stmt = $conn->prepare($query);

        if ($stmt) {
            // Bind parameters and execute the query
            $stmt->bind_param('sidsi', $description, $quantity, $unit, $amount, $item_id);

            if ($stmt->execute()) {
                $data['success'] = true;
                $data['message'] = 'Item updated successfully!';
            } else {
                $data['success'] = false;
                $data['errors'] = ['database' => 'Failed to update item in the database.'];
            }

            $stmt->close();
        } else {
            $data['success'] = false;
            $data['errors'] = ['database' => 'Failed to prepare the update statement.'];
        }
    }
}

// Output the JSON response
echo json_encode($data);
?>
