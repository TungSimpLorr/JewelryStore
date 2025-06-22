<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "jewelry_db";
$conn = new mysqli($host, $username, $password, $database);
if ($conn->connect_error) {
    die(" ket noi khong thanh cong  " . $conn->connect_error);
}
$conn->set_charset("utf8");
?>