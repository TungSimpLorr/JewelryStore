<?php 
error_reporting(E_ALL);
ini_set('display_errors', 1);

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$path = realpath(__DIR__ . '/../includes/connect.php');
include $path;

if ($conn->connect_error) {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Database connection failed: ' . $conn->connect_error]);
    exit();
}

if(isset($_POST['kiemtrataikhoan'])) {

$tennguoidung = $_POST['tennguoidung'];
$matkhau = $_POST['matkhau'];

$sql_user = "SELECT * FROM nguoi_dung WHERE ten_dang_nhap = '$tennguoidung' AND mat_khau = '$matkhau'";
$result_user = $conn->query($sql_user);
$user_account = $result_user->fetch_assoc();


$sql_admin = "SELECT * FROM quan_tri_vien WHERE ten_dang_nhap = '$tennguoidung' AND mat_khau = '$matkhau'";
$result_admin = $conn->query($sql_admin);
$admin_account = $result_admin->fetch_assoc();

if ($user_account) {
 
    $_SESSION['user_logged_in'] = true;
    $_SESSION['user_id'] = $user_account['id_nguoi_dung'];
    $_SESSION['username'] = $user_account['ten_dang_nhap'];
    $_SESSION['user_type'] = 'user';
    
    if (!isset($_SESSION['tendangnhap']) || !is_array($_SESSION['tendangnhap'])) {
        $_SESSION['tendangnhap'] = [];
    }
    $found = false;
    foreach ($_SESSION['tendangnhap'] as &$item) {
        if ($item['tendangnhap'] == $user_account['ten_dang_nhap']) {
            $found = true;
            break;
        }
    }
    unset($item);
    if (!$found) {
        $_SESSION['tendangnhap'][] = [
            'tendangnhap' => $user_account['ten_dang_nhap'],
            'matkhau' => $user_account['mat_khau'],
        ];
    }
    
    header('Content-Type: application/json');
    echo json_encode(['success' => true, 'message' => 'Đăng nhập thành công!', 'user_type' => 'user']);
    exit();
    
} elseif ($admin_account) {
  
    $_SESSION['user_logged_in'] = true;
    $_SESSION['user_id'] = $admin_account['id_quan_tri'];
    $_SESSION['username'] = $admin_account['ten_dang_nhap'];
    $_SESSION['user_type'] = 'admin';
    $_SESSION['admin_name'] = $admin_account['ho_ten'];
    
    header('Content-Type: application/json');
    echo json_encode(['success' => true, 'message' => 'Đăng nhập admin thành công!', 'user_type' => 'admin']);
    exit();
    
} else {
 
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Đăng nhập thất bại. Vui lòng kiểm tra lại tên đăng nhập và mật khẩu.']);
    exit();
}
}


if(isset($_POST['logout'])) {
    session_destroy();
    header('Content-Type: application/json');
    echo json_encode(['success' => true, 'message' => 'Đăng xuất thành công!']);
    exit();
}


if(isset($_POST['check_login_status'])) {
    header('Content-Type: application/json');
    if(isset($_SESSION['user_logged_in']) && $_SESSION['user_logged_in'] === true) {
        echo json_encode(['logged_in' => true, 'username' => $_SESSION['username']]);
    } else {
        echo json_encode(['logged_in' => false]);
    }
    exit();
}

?>