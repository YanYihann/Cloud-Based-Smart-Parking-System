<?php
session_start();
require 'db_connect.php';

// Allow guests
$is_member = isset($_SESSION['is_member']) ? $_SESSION['is_member'] : 0;
$username = isset($_SESSION['username']) ? $_SESSION['username'] : 'Guest';
$error = '';
$success = isset($_GET['success']) ? $_GET['success'] : '';
$selected_area = isset($_POST['area']) ? $_POST['area'] : '';
$selected_location = isset($_POST['location']) ? $_POST['location'] : '';

// Get available parking spots per floor
$stmt = $conn->prepare("SELECT location, COUNT(*) as available_count FROM parking_spots WHERE status = 'Available' GROUP BY location");
$stmt->execute();
$result = $stmt->get_result();
$available_spots = [
    'Underground' => ['U1' => 0, 'U2' => 0, 'U3' => 0],
    'Overground' => ['O1' => 0, 'O2' => 0]
];
while ($row = $result->fetch_assoc()) {
    $loc = $row['location'];
    if (in_array($loc, ['U1', 'U2', 'U3'])) {
        $available_spots['Underground'][$loc] = $row['available_count'];
    } elseif (in_array($loc, ['O1', 'O2'])) {
        $available_spots['Overground'][$loc] = $row['available_count'];
    }
}
$stmt->close();

// Get member's active bookings
$active_bookings = [];
if ($is_member) {
    $stmt = $conn->prepare("SELECT b.id, b.spot_id, b.entry_time, b.payment_status FROM bookings b WHERE b.username = ? AND b.payment_status = 'Confirmed' AND b.exit_time IS NULL");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $active_bookings[] = $row;
    }
    $stmt->close();

    // Debug: Check if bookings are fetched
    if (empty($active_bookings)) {
        // Log all bookings for this user to diagnose
        $stmt = $conn->prepare("SELECT b.id, b.spot_id, b.entry_time, b.payment_status, b.exit_time FROM bookings b WHERE b.username = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();
        $all_bookings = [];
        while ($row = $result->fetch_assoc()) {
            $all_bookings[] = $row;
        }
        $stmt->close();
        if (!empty($all_bookings)) {
            $error = "No active bookings found, but bookings exist. Check payment_status or exit_time.";
        }
    }
}

// Handle booking request (members only)
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['book'])) {
    if (!$is_member) {
        $error = "Only members can book parking spots. Please register or login.";
    } else {
        $area = $_POST['area'];
        $location = $_POST['location'];
        $time = $_POST['time'];

        if (!preg_match("/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$/", $time)) {
            $error = "Invalid time format, please use YYYY-MM-DD HH:MM (e.g., 2025-04-21 10:00)";
        } elseif ($available_spots[$area][$location] == 0) {
            $error = "No available parking spots on $location floor";
        } else {
            // Get user's license plate
            $stmt = $conn->prepare("SELECT license_plate FROM users WHERE username = ?");
            $stmt->bind_param("s", $username);
            $stmt->execute();
            $result = $stmt->get_result();
            $user = $result->fetch_assoc();
            $license_plate = $user['license_plate'];
            $stmt->close();

            $stmt = $conn->prepare("SELECT spot_id FROM parking_spots WHERE location = ? AND status = 'Available' LIMIT 1 FOR UPDATE");
            $stmt->bind_param("s", $location);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $spot = $result->fetch_assoc();
                $spot_id = $spot['spot_id'];

                $stmt = $conn->prepare("UPDATE parking_spots SET status = 'Booked' WHERE spot_id = ?");
                $stmt->bind_param("s", $spot_id);
                if ($stmt->execute()) {
                    $stmt = $conn->prepare("INSERT INTO bookings (username, license_plate, spot_id, entry_time, payment_status) VALUES (?, ?, ?, ?, 'Pending')");
                    $entry_time = DateTime::createFromFormat('Y-m-d H:i', $time)->format('Y-m-d H:i:s');
                    $stmt->bind_param("ssss", $username, $license_plate, $spot_id, $entry_time);
                    if ($stmt->execute()) {
                        header("Location: payment.php?spot_id=" . urlencode($spot_id));
                        exit();
                    } else {
                        $error = "Failed to record booking, please try again";
                        $stmt = $conn->prepare("UPDATE parking_spots SET status = 'Available' WHERE spot_id = ?");
                        $stmt->bind_param("s", $spot_id);
                        $stmt->execute();
                    }
                } else {
                    $error = "Booking failed, please try again";
                }
            } else {
                $error = "No available parking spots on $location floor";
            }
            $stmt->close();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart Parking System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Welcome, <?php echo htmlspecialchars($username); ?></h2>
        <?php if ($is_member) { ?>
            <p>
                <a href="profile.php">Profile</a> | 
                <a href="orders.php">Orders</a> | 
                <a href="leave_payment.php">Pay and Leave</a> | 
                <a href="logout.php">Logout</a>
            </p>
        <?php } else { ?>
            <p>
                <a href="index.php">Login</a> | 
                <a href="register.php">Register as Member</a> | 
                <a href="leave_payment.php">Pay and Leave</a>
            </p>
        <?php } ?>

        <h3>Parking Availability</h3>
        <?php if ($success) { ?>
            <div class="success">
                <p><?php echo $success; ?></p>
            </div>
        <?php } ?>
        <?php if ($error) { ?>
            <p class="error"><?php echo $error; ?></p>
        <?php } ?>

        <!-- Display Active Bookings (Members Only) -->
        <?php if ($is_member) { ?>
            <div class="active-bookings">
                <h4>Your Current Bookings</h4>
                <?php if (empty($active_bookings)) { ?>
                    <p>You have no active bookings.</p>
                <?php } else { ?>
                    <?php foreach ($active_bookings as $booking) { ?>
                        <p>
                            Parking Spot: <strong><?php echo htmlspecialchars($booking['spot_id']); ?></strong>
                            - Entry Time: <?php echo htmlspecialchars($booking['entry_time']); ?>
                            - Status: <?php echo htmlspecialchars($booking['payment_status']); ?>
                            <form method="POST" action="leave_payment.php" style="display:inline;">
                                <input type="hidden" name="booking_id" value="<?php echo $booking['id']; ?>">
                                <input type="hidden" name="spot_id" value="<?php echo $booking['spot_id']; ?>">
                                <button type="submit" name="leave">Leave and Pay</button>
                            </form>
                        </p>
                    <?php } ?>
                <?php } ?>
            </div>
        <?php } ?>

        <!-- Select Area (for Members Booking) -->
        <?php if ($is_member) { ?>
            <form method="POST" action="">
                <label>Select Area:</label>
                <div class="area-buttons">
                    <button type="submit" name="area" value="Underground">Underground</button>
                    <button type="submit" name="area" value="Overground">Overground</button>
                </div>
                <input type="hidden" name="selected_area" value="<?php echo htmlspecialchars($selected_area); ?>">
            </form>
        <?php } ?>

        <!-- Display Floors and Available Spots -->
        <div class="availability">
            <h4>Available Spots by Area</h4>
            <h5>Underground</h5>
            <?php foreach (['U1', 'U2', 'U3'] as $loc) { ?>
                <p><strong><?php echo $loc; ?></strong>: <?php echo $available_spots['Underground'][$loc]; ?> available spots</p>
            <?php } ?>
            <h5>Overground</h5>
            <?php foreach (['O1', 'O2'] as $loc) { ?>
                <p><strong><?php echo $loc; ?></strong>: <?php echo $available_spots['Overground'][$loc]; ?> available spots</p>
            <?php } ?>
        </div>

        <!-- Booking Form (Members Only) -->
        <?php if ($is_member && $selected_area) { ?>
            <form method="POST" action="">
                <h4>Book a Parking Spot</h4>
                <label>Select Floor:</label>
                <select name="location" required>
                    <option value="">Please select a floor</option>
                    <?php
                    $locations = $selected_area === 'Underground' ? ['U1', 'U2', 'U3'] : ['O1', 'O2'];
                    foreach ($locations as $loc) { ?>
                        <option value="<?php echo $loc; ?>" <?php if ($selected_location === $loc) echo 'selected'; ?> <?php if ($available_spots[$selected_area][$loc] == 0) echo 'disabled'; ?>>
                            <?php echo $loc; ?> (<?php echo $available_spots[$selected_area][$loc]; ?> available)
                        </option>
                    <?php } ?>
                </select>
                <label>Time:</label>
                <input type="text" name="time" placeholder="e.g., 2025-04-21 10:00" value="<?php echo isset($_POST['time']) ? htmlspecialchars($_POST['time']) : ''; ?>" required>
                <input type="hidden" name="area" value="<?php echo htmlspecialchars($selected_area); ?>">
                <button type="submit" name="book">Confirm Booking</button>
            </form>
        <?php } ?>
    </div>
</body>
</html>