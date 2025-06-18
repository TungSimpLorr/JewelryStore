<?php
// Thông tin kết nối đến MySQL
$host = "localhost";
$username = "root";
$password = "";
$database = "jewelry_store_db"; // 👉\ Đảm bảo đúng tên CSDL bạn đã tạo

// Khởi tạo kết nối
$conn = new mysqli($host, $username, $password, $database);

// Kiểm tra lỗi kết nối
if ($conn->connect_error) {
    die(" Kết nối thất bại: " . $conn->connect_error);
}

// Thiết lập mã hóa ký tự
$conn->set_charset("utf8");
?>