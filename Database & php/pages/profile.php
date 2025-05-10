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

$stmt = $conn->prepare("SELECT full_name, email, phone, license_plate FROM users WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$user = $stmt->get_result()->fetch_assoc();
$stmt->close();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $full_name = $_POST['full_name'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $license_plate = $_POST['license_plate'];
    $password = !empty($_POST['password']) ? password_hash($_POST['password'], PASSWORD_DEFAULT) : $user['password'];

    if (empty($full_name) || empty($email) || empty($phone) || empty($license_plate)) {
        $error = "All fields are required";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "Invalid email format";
    } else {
        $stmt = $conn->prepare("UPDATE users SET full_name = ?, email = ?, phone = ?, license_plate = ?, password = ? WHERE username = ?");
        $stmt->bind_param("ssssss", $full_name, $email, $phone, $license_plate, $password, $username);
        if ($stmt->execute()) {
            $success = "Profile updated successfully";
        } else {
            $error = "Failed to update profile, please try again";
        }
        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart Parking System - Profile</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Your Profile</h2>
        <p><a href="main.php">Back to Parking Page</a></p>
        <?php if ($success) { ?>
            <div class="success">
                <p><?php echo $success; ?></p>
            </div>
        <?php } ?>
        <?php if ($error) { ?>
            <p class="error"><?php echo $error; ?></p>
        <?php } ?>

        <form method="POST" action="">
            <label>Username:</label>
            <input type="text" value="<?php echo htmlspecialchars($username); ?>" disabled><br>
            <label>Full Name:</label>
            <input type="text" name="full_name" value="<?php echo htmlspecialchars($user['full_name']); ?>" required><br>
            <label>Email:</label>
            <input type="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>" required><br>
            <label>Phone Number:</label>
            <input type="text" name="phone" value="<?php echo htmlspecialchars($user['phone']); ?>" required><br>
            <label>License Plate:</label>
            <input type="text" name="license_plate" value="<?php echo htmlspecialchars($user['license_plate']); ?>" required><br>
            <label>New Password (leave blank to keep current):</label>
            <input type="password" name="password"><br>
            <button type="submit">Update Profile</button>
        </form>
    </div>
</body>
</html>