<?php
session_start();
require 'db_connect.php';

$is_member = isset($_SESSION['is_member']) ? $_SESSION['is_member'] : 0;
$username = isset($_SESSION['username']) ? $_SESSION['username'] : null;
$error = '';
$success = '';
$duration_hours = 0;
$total_fee = 0;
$spot_id = '';
$booking_id = 0;
$license_plate = '';

// Handle direct access or form submission
if ($is_member) {
    // Get member's license plate
    $stmt = $conn->prepare("SELECT license_plate FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        $license_plate = $user['license_plate'];
    } else {
        $error = "User not found";
    }
    $stmt->close();
} elseif ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['find_booking'])) {
    $license_plate = $_POST['license_plate'];
    if (empty($license_plate)) {
        $error = "License plate is required";
    }
}

// Lookup booking
if (empty($error) && $license_plate) {
    if ($is_member) {
        $stmt = $conn->prepare("SELECT b.id, b.spot_id, b.entry_time FROM bookings b WHERE b.username = ? AND b.payment_status = 'Confirmed' AND b.exit_time IS NULL AND b.license_plate = ?");
        $stmt->bind_param("ss", $username, $license_plate);
    } else {
        $stmt = $conn->prepare("SELECT b.id, b.spot_id, b.entry_time FROM bookings b WHERE b.username IS NULL AND b.payment_status = 'NonMember' AND b.exit_time IS NULL AND b.license_plate = ?");
        $stmt->bind_param("s", $license_plate);
    }

    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows == 0) {
        if (!$is_member) {
            // Simulate sensor data for non-members
            $stmt = $conn->prepare("SELECT spot_id FROM parking_spots WHERE status = 'Available' LIMIT 1");
            $stmt->execute();
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                $spot = $result->fetch_assoc();
                $spot_id = $spot['spot_id'];

                $stmt = $conn->prepare("UPDATE parking_spots SET status = 'Booked' WHERE spot_id = ?");
                $stmt->bind_param("s", $spot_id);
                $stmt->execute();

                $entry_time = date('Y-m-d H:i:s', strtotime('-' . rand(1, 5) . ' hours'));
                $stmt = $conn->prepare("INSERT INTO bookings (username, license_plate, spot_id, entry_time, payment_status) VALUES (NULL, ?, ?, ?, 'NonMember')");
                $stmt->bind_param("sss", $license_plate, $spot_id, $entry_time);
                if ($stmt->execute()) {
                    $booking_id = $conn->insert_id;
                    $entry_time = new DateTime($entry_time);
                    $leaving_time = new DateTime();
                    $interval = $entry_time->diff($leaving_time);

                    $hours = $interval->h + ($interval->days * 24);
                    if ($interval->i > 0 || $interval->s > 0) {
                        $hours++;
                    }
                    $duration_hours = max(1, $hours);
                    $total_fee = $duration_hours * 5;
                } else {
                    $error = "Failed to simulate parking record";
                }
            } else {
                $error = "No available parking spots";
            }
            $stmt->close();
        } else {
            $error = "No active booking found for your license plate";
        }
    } else {
        $booking = $result->fetch_assoc();
        $booking_id = $booking['id'];
        $spot_id = $booking['spot_id'];
        $entry_time = new DateTime($booking['entry_time']);
        $leaving_time = new DateTime();
        $interval = $entry_time->diff($leaving_time);

        $hours = $interval->h + ($interval->days * 24);
        if ($interval->i > 0 || $interval->s > 0) {
            $hours++;
        }
        $duration_hours = max(1, $hours);
        $total_fee = $duration_hours * 5;
        $stmt->close();
    }
}

// Handle payment confirmation from main.php or direct form
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['leave'], $_POST['booking_id'], $_POST['spot_id'])) {
    $booking_id = $_POST['booking_id'];
    $spot_id = $_POST['spot_id'];

    if ($is_member) {
        $stmt = $conn->prepare("SELECT entry_time, license_plate FROM bookings WHERE id = ? AND username = ? AND payment_status = 'Confirmed' AND exit_time IS NULL");
        $stmt->bind_param("is", $booking_id, $username);
    } else {
        $error = "Only members can pay via this route";
        $stmt = null;
    }

    if ($stmt) {
        $stmt->execute();
        $result = $stmt->get_result();
        if ($result->num_rows == 0) {
            $error = "Invalid booking or already paid";
            $stmt->close();
        } else {
            $booking = $result->fetch_assoc();
            $entry_time = new DateTime($booking['entry_time']);
            $license_plate = $booking['license_plate'];
            $leaving_time = new DateTime();
            $interval = $entry_time->diff($leaving_time);

            $hours = $interval->h + ($interval->days * 24);
            if ($interval->i > 0 || $interval->s > 0) {
                $hours++;
            }
            $duration_hours = max(1, $hours);
            $total_fee = $duration_hours * 5;

            $stmt->close();
        }
    }
}

// Handle final payment confirmation
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['confirm_payment'], $_POST['booking_id'], $_POST['spot_id'])) {
    $booking_id = $_POST['booking_id'];
    $spot_id = $_POST['spot_id'];

    if ($is_member) {
        $stmt = $conn->prepare("SELECT entry_time, license_plate FROM bookings WHERE id = ? AND username = ? AND payment_status = 'Confirmed' AND exit_time IS NULL");
        $stmt->bind_param("is", $booking_id, $username);
    } else {
        $stmt = $conn->prepare("SELECT entry_time, license_plate FROM bookings WHERE id = ? AND username IS NULL AND payment_status = 'NonMember' AND exit_time IS NULL AND license_plate = ?");
        $license_plate = $_POST['license_plate'];
        $stmt->bind_param("is", $booking_id, $license_plate);
    }

    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows == 0) {
        $error = "Invalid booking or already paid";
        $stmt->close();
    } else {
        $booking = $result->fetch_assoc();
        $entry_time = new DateTime($booking['entry_time']);
        $license_plate = $booking['license_plate'];
        $leaving_time = new DateTime();
        $interval = $entry_time->diff($leaving_time);

        $hours = $interval->h + ($interval->days * 24);
        if ($interval->i > 0 || $interval->s > 0) {
            $hours++;
        }
        $duration_hours = max(1, $hours);
        $total_fee = $duration_hours * 5;

        $stmt->close();

        $stmt = $conn->prepare("UPDATE bookings SET exit_time = ? WHERE id = ?");
        $stmt->bind_param("si", $leaving_time->format('Y-m-d H:i:s'), $booking_id);
        if ($stmt->execute()) {
            $stmt = $conn->prepare("UPDATE parking_spots SET status = 'Available' WHERE spot_id = ?");
            $stmt->bind_param("s", $spot_id);
            if ($stmt->execute()) {
                $stmt = $conn->prepare("INSERT INTO payments (username, license_plate, spot_id, booking_id, duration_hours, total_fee, payment_time) VALUES (?, ?, ?, ?, ?, ?, ?)");
                $stmt->bind_param("sssiids", $username, $license_plate, $spot_id, $booking_id, $duration_hours, $total_fee, $leaving_time->format('Y-m-d H:i:s'));
                if ($stmt->execute()) {
                    $success = "Payment successful! Parking spot $spot_id released, total fee $total_fee yuan";
                    header("Location: main.php?success=" . urlencode($success));
                    exit();
                } else {
                    $error = "Failed to record payment, please try again";
                }
            } else {
                $error = "Failed to release parking spot, please try again";
            }
        } else {
            $error = "Failed to update booking status, please try again";
        }
        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Leave and Pay for Parking</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Leave and Pay for Parking</h2>
        <?php if ($error) { ?>
            <p class="error"><?php echo $error; ?></p>
        <?php } ?>
        <?php if ($duration_hours > 0) { ?>
            <p>Parking Spot: <strong><?php echo htmlspecialchars($spot_id); ?></strong></p>
            <p>Parking Duration: <?php echo $duration_hours; ?> hours</p>
            <p>Total Fee: <?php echo $total_fee; ?> yuan (5 yuan per hour)</p>
            <p>Please scan the QR code below to pay the fee</p>
            <div class="qr-code">
                <img src="images/leave_qr_code.png" alt="Payment QR Code" width="200">
            </div>
            <form method="POST" action="">
                <input type="hidden" name="booking_id" value="<?php echo htmlspecialchars($booking_id); ?>">
                <input type="hidden" name="spot_id" value="<?php echo htmlspecialchars($spot_id); ?>">
                <input type="hidden" name="license_plate" value="<?php echo htmlspecialchars($license_plate); ?>">
                <button type="submit" name="confirm_payment">Simulate Payment Confirmation</button>
            </form>
        <?php } elseif ($is_member) { ?>
            <form method="POST" action="">
                <p>Using registered license plate: <strong><?php echo htmlspecialchars($license_plate); ?></strong></p>
                <button type="submit" name="find_booking">Find Booking</button>
            </form>
        <?php } else { ?>
            <form method="POST" action="">
                <label>License Plate:</label>
                <input type="text" name="license_plate" required>
                <button type="submit" name="find_booking">Find Booking</button>
            </form>
        <?php } ?>
        <a href="main.php">Back to Parking Page</a>
    </div>
</body>
</html>