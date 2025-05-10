<?php
session_start();
require 'db_connect.php';

if (!isset($_SESSION['username']) || !isset($_SESSION['is_member']) || $_SESSION['is_member'] != 1) {
    header("Location: index.php");
    exit();
}

$username = $_SESSION['username'];
$error = '';
$success = '';

$bookings = [];
$stmt = $conn->prepare("SELECT b.id, b.spot_id, b.entry_time, b.exit_time, b.payment_status FROM bookings b WHERE b.username = ? ORDER BY b.entry_time DESC");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $bookings[] = $row;
}
$stmt->close();

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['modify'])) {
    $booking_id = $_POST['booking_id'];
    $new_time = $_POST['new_time'];

    if (!preg_match("/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/", $new_time)) {
        $error = "Invalid time format, please use YYYY-MM-DD HH:MM (e.g., 2025-04-21 10:00)";
    } else {
        $stmt = $conn->prepare("SELECT spot_id FROM bookings WHERE id = ? AND username = ? AND payment_status = 'Confirmed' AND exit_time IS NULL");
        $stmt->bind_param("is", $booking_id, $username);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows == 0) {
            $error = "Invalid or inactive booking";
        } else {
            $stmt = $conn->prepare("UPDATE bookings SET entry_time = ? WHERE id = ?");
            $entry_time = DateTime::createFromFormat('Y-m-d H:i', $new_time)->format('Y-m-d H:i:s');
            $stmt->bind_param("si", $entry_time, $booking_id);
            if ($stmt->execute()) {
                $success = "Booking updated successfully";
            } else {
                $error = "Failed to update booking, please try again";
            }
        }
        $stmt->close();
    }
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['cancel'])) {
    $booking_id = $_POST['booking_id'];

    $stmt = $conn->prepare("SELECT spot_id FROM bookings WHERE id = ? AND username = ? AND payment_status = 'Confirmed' AND exit_time IS NULL");
    $stmt->bind_param("is", $booking_id, $username);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows == 0) {
        $error = "Invalid or inactive booking";
    } else {
        $booking = $result->fetch_assoc();
        $spot_id = $booking['spot_id'];

        $stmt = $conn->prepare("UPDATE bookings SET exit_time = NOW() WHERE id = ?");
        $stmt->bind_param("i", $booking_id);
        if ($stmt->execute()) {
            $stmt = $conn->prepare("UPDATE parking_spots SET status = 'Available' WHERE spot_id = ?");
            $stmt->bind_param("s", $spot_id);
            if ($stmt->execute()) {
                $success = "Booking cancelled successfully";
            } else {
                $error = "Failed to release parking spot, please try again";
            }
        } else {
            $error = "Failed to cancel booking, please try again";
        }
        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart Parking System - Orders</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Your Orders</h2>
        <p><a href="main.php">Back to Parking Page</a></p>
        <?php if ($success) { ?>
            <div class="success">
                <p><?php echo $success; ?></p>
            </div>
        <?php } ?>
        <?php if ($error) { ?>
            <p class="error"><?php echo $error; ?></p>
        <?php } ?>

        <h3>Booking History</h3>
        <?php if (empty($bookings)) { ?>
            <p>No bookings found.</p>
        <?php } else { ?>
            <table border="1" style="width: 100%; border-collapse: collapse;">
                <tr>
                    <th>Spot ID</th>
                    <th>Entry Time</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <?php foreach ($bookings as $booking) { ?>
                    <tr>
                        <td><?php echo htmlspecialchars($booking['spot_id']); ?></td>
                        <td><?php echo htmlspecialchars($booking['entry_time']); ?></td>
                        <td>
                            <?php
                            if ($booking['exit_time']) {
                                echo "Completed";
                            } elseif ($booking['payment_status'] == 'Pending') {
                                echo "Pending Payment";
                            } else {
                                echo "Active";
                            }
                            ?>
                        </td>
                        <td>
                            <?php if (!$booking['exit_time'] && $booking['payment_status'] == 'Confirmed') { ?>
                                <form method="POST" action="" style="display:inline;">
                                    <input type="hidden" name="booking_id" value="<?php echo $booking['id']; ?>">
                                    <input type="text" name="new_time" placeholder="YYYY-MM-DD HH:MM" required>
                                    <button type="submit" name="modify">Modify Time</button>
                                </form>
                                <form method="POST" action="" style="display:inline;">
                                    <input type="hidden" name="booking_id" value="<?php echo $booking['id']; ?>">
                                    <button type="submit" name="cancel">Cancel</button>
                                </form>
                            <?php } ?>
                        </td>
                    </tr>
                <?php } ?>
            </table>
        <?php } ?>
    </div>
</body>
</html>