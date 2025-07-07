<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$path = realpath(__DIR__ . '/../includes/connect.php');
include $path;

if (!isset($_SESSION['user_logged_in']) || $_SESSION['user_logged_in'] !== true) {
    header('Location: cart.php?error=not_logged_in');
    exit();
}


if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: cart.php?error=invalid_request');
    exit();
}

$name = $_POST['name'] ?? '';
$phone = $_POST['phone'] ?? '';
$address = $_POST['address'] ?? '';
$payment_method = $_POST['payment'] ?? '';


$cart = isset($_SESSION['cart']) && is_array($_SESSION['cart']) ? $_SESSION['cart'] : [];


if (empty($cart)) {
    header('Location: cart.php?error=empty_cart');
    exit();
}


$total_amount = 0;
foreach ($cart as $item) {
    $total_amount += $item['price'] * $item['quantity'];
}
$delivery_fee = 30000; 
$total_amount += $delivery_fee;

try {
    
    
    $sql_order = "INSERT INTO don_hang (id_nguoi_dung, ho_ten_khach_hang, tong_tien, trang_thai_don_hang, dia_chi_giao_hang, phuong_thuc_thanh_toan) 
                   VALUES ('{$_SESSION['user_id']}', '$name', '$total_amount', 'Pending', '$address', '$payment_method')";
    
    if (!$conn->query($sql_order)) {
        throw new Exception("Lỗi khi tạo đơn hàng: " . $conn->error);
    }
    
    $order_id = $conn->insert_id;
    

    foreach ($cart as $item) {
        $sql_detail = "INSERT INTO chi_tiet_don_hang (id_don_hang, id_san_pham, so_luong, gia_tai_thoi_diem) 
                       VALUES ('$order_id', '{$item['id']}', '{$item['quantity']}', '{$item['price']}')";
        
        if (!$conn->query($sql_detail)) {
            throw new Exception("Lỗi khi lưu chi tiết đơn hàng: " . $conn->error);
        }
    }
    
 
    unset($_SESSION['cart']);
    

    $_SESSION['order_success'] = [
        'order_id' => $order_id,
        'total_amount' => $total_amount,
        'customer_name' => $name,
        'customer_phone' => $phone,
        'customer_address' => $address,
        'payment_method' => $payment_method,
        'order_date' => date('Y-m-d H:i:s')
    ];
    
   
    header('Location: order.php');
    exit();
    
} catch (Exception $e) {
   
    $_SESSION['payment_errors'] = [$e->getMessage()];
    
    header('Location: cart.php');
    exit();
}
    
   
    if (isset($_SESSION['payment_errors']) && !empty($_SESSION['payment_errors'])) {
        echo '<div class="alert alert-danger">';
        foreach ($_SESSION['payment_errors'] as $error) {
            echo htmlspecialchars($error) . '<br>';
        }
        echo '</div>';
        unset($_SESSION['payment_errors']);
    }
    ?>
