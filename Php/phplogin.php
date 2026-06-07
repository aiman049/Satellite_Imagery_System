<?php

require_once 'PHP Connection File.php';

$fullname = $_POST['fullname'];
$phone    = $_POST['phone'];
$email    = $_POST['email'];
$password = hash('sha256', $_POST['password']);

$sql = "INSERT INTO User
        (User_Name, Phone, Email, Password, Role)
        VALUES
        ('$fullname', '$phone', '$email', '$password', 'User')";

if($conn->query($sql))
{
    echo "Registration Successful";
}
else
{
    echo "Error: " . $conn->error;
}

?>