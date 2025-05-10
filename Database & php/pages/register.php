<?php
require 'db_connect.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $email = $_POST['email'];
    $full_name = $_POST['full_name'];
    $phone = $_POST['phone'];
    $license_plate = $_POST['license_plate'];

    if (empty($username) || empty($password) || empty($email) || empty($full_name) || empty($phone) || empty($license_plate)) {
        $error = "All fields are required";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = "Invalid email format";
    } else {
        $stmt = $conn->prepare("SELECT username FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        if ($stmt->get_result()->num_rows > 0) {
            $error = "Username already exists";
        } else {
            $stmt = $conn->prepare("INSERT INTO users (username, password, email, full_name, phone, license_plate, is_member) VALUES (?, ?, ?, ?, ?, ?, 1)");
            $stmt->bind_param("ssssss", $username, $password, $email, $full_name, $phone, $license_plate);
            if ($stmt->execute()) {
                header("Location: index.php?success=Registration successful, please login");
                exit();
            } else {
                $error = "Registration failed, please try again";
            }
        }
        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart Parking System - Register</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Member Registration</h2>
        <?php if (isset($error)) echo "<p class='error'>$error</p>"; ?>
        <form method="POST" action="">
            <label>Username:</label>
            <input type="text" name="username" required><br>
            <label>Password:</label>
            <input type="password" name="password" required><br>
            <label>Email:</label>
            <input type="email" name="email" required><br>
            <label>Full Name:</label>
            <input type="text" name="full_name" required><br>
            <label>Phone Number:</label>
            <input type="text" name="phone" required><br>
            <label>License Plate:</label>
            <input type="text" name="license_plate" required><br>
            <button type="submit">Submit</button>
            <a href="index.php">Back to Login</a>
        </form>
    </div>
</body>
</html>