<?php
session_start();
require 'db_connect.php';

if (!isset($_SESSION['username']) || !isset($_SESSION['is_member']) || $_SESSION['is_member'] != 1 || !isset($_GET['spot_id'])) {
    header("Location: index.php");
    exit();
}

$username = $_SESSION['username'];
$spot_id = $_GET['spot_id'];
$error = '';
$success = '';

$stmt = $conn->prepare("SELECT status FROM parking_spots WHERE spot_id = ?");
$stmt->bind_param("s", $spot_id);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows == 0 || $result->fetch_assoc()['status'] !== 'Booked') {
    $error = "Invalid parking spot or already booked";
    $stmt->close();
} else {
    $stmt->close();

    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['confirm_payment'])) {
        $stmt = $conn->prepare("UPDATE bookings SET payment_status = 'Confirmed' WHERE spot_id = ? AND username = ? AND payment_status = 'Pending'");
        $stmt->bind_param("ss", $spot_id, $username);
        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                $success = "Payment successful! Parking spot $spot_id confirmed";
                header("Location: main.php?success=" . urlencode($success) . "&spot_id=" . urlencode($spot_id));
                exit();
            } else {
                $error = "No pending booking found for this spot. It may already be confirmed or invalid.";
            }
        } else {
            $error = "Payment confirmation failed, please try again";
        }
        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pay Parking Deposit</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Pay Parking Deposit</h2>
        <p>Please scan the QR code below to pay a 10 yuan deposit to confirm booking for spot <strong><?php echo htmlspecialchars($spot_id); ?></strong></p>
        
        <?php if ($error) { ?>
            <p class="error"><?php echo $error; ?></p>
        <?php } ?>
        
        <div class="qr-code">
            <img src="images/qr_code.png" alt="Payment QR Code" width="200">
        </div>
        
        <form method="POST" action="">
            <button type="submit" name="confirm_payment">Simulate Payment Confirmation</button>
        </form>
        
        <a href="main.php">Back to Booking Page</a>
    </div>
</body>
</html>