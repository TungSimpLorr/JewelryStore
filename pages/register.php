<?php
$path = realpath(__DIR__ . '/../includes/connect.php');
include $path;

$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = $_POST['title'];
    $lastname = trim($_POST['lastname']);
    $firstname = trim($_POST['firstname']);
    $email = trim($_POST['email']);
    $ten_dang_nhap = trim($_POST['ten_dang_nhap']);
    $dob = $_POST['dob'];
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];
    if ($password !== $confirm_password) {
        $error = "Mật khẩu nhập lại không khớp!";
    } else {
    
        $stmt = $conn->prepare("SELECT id_nguoi_dung FROM nguoi_dung WHERE ten_dang_nhap = ?");
$stmt->bind_param("s", $ten_dang_nhap);
$stmt->execute();
$stmt->store_result();
if ($stmt->num_rows > 0) {
    $error = "Tên đăng nhập đã tồn tại!";
        } else {
            // Mã hóa mật khẩu
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);
           
           $stmt = $conn->prepare("INSERT INTO nguoi_dung (ten_dang_nhap, email, mat_khau, ho_ten) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $ten_dang_nhap, $email, $hashed_password, $fullname);
            if ($stmt->execute()) {
                $success = "Đăng ký thành công! Bạn có thể đăng nhập.";
            } else {
                $error = "Đăng ký thất bại. Vui lòng thử lại!";
            }
        }
        $stmt->close();
    }
}
?>

<head>
    <meta charset="UTF-8">
    <title>Đăng ký</title>
</head>
<style>
    
.auth-container {
    max-width: 420px;
    margin: 48px auto;
    background: #fff;
    padding: 36px 32px 28px 32px;
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.12);
}
.auth-title {
    text-align: center;
    font-size: 2em;
    font-weight: bold;
    margin-bottom: 28px;
    color: #222;
    font-family:'Times New Roman', Times, serif;

}
.auth-form label {
    display: block;
    margin-bottom: 6px;
    font-weight: 500;
    color: #222;
    margin-top: 18px;
    font-family:'Times New Roman', Times, serif;
}
.auth-form input,
.auth-form select {
    width: 100%;
    padding: 11px 12px;
    margin-bottom: 2px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 16px;
    background: #fafafa;
    transition: border 0.2s;
    font-family:'Times New Roman', Times, serif;
}
.auth-form input:focus,
.auth-form select:focus {
    border: 1.5px solid #222;
    outline: none;
    background: #fff;
}
.auth-form .action-btn {
    width: 100%;
    margin: 24px 0 0 0;
    font-size: 18px;
    padding: 11px 0;
    background: #222;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: background 0.2s;
    font-family:'Times New Roman', Times, serif;
}
.auth-form .action-btn:hover {
    background: #222;
}
.auth-switch {
    text-align: center;
    margin-top: 18px;
}
.auth-switch a {
    color: #222;
    text-decoration: none;
    font-weight: bold;
}
.auth-switch a:hover {
    text-decoration: underline;
}
.auth-error {
    color: #e74c3c;
    text-align: center;
    margin-bottom: 12px;
}
</style>
<body>
    <div class="auth-container">
        <div class="auth-title">Tạo tài khoản</div>
        <?php if ($error): ?>
            <div class="auth-error"><?php echo $error; ?></div>
        <?php elseif ($success): ?>
            <div class="auth-success" style="color: #219150; text-align:center; margin-bottom:12px;"><?php echo $success; ?></div>
        <?php endif; ?>
        <form class="auth-form" action="register.php" method="post">
            <label for="title">Danh xưng</label>
            <select id="title" name="title" required>
                <option value="Mr">Mr</option>
                <option value="Ms">Ms</option>
                <option value="Mrs">Mrs</option>
            </select>
            <label for="lastname">Họ *</label>
            <input type="text" id="lastname" name="lastname" required>
            <label for="firstname">Tên *</label>
            <input type="text" id="firstname" name="firstname" required>
            <label for="email">Email *</label>
            <input type="email" id="email" name="email" required>
            <label for="ten_dang_nhap">Tên đăng nhập *</label>
<input type="text" id="ten_dang_nhap" name="ten_dang_nhap" required>
            <label for="dob">Ngày sinh</label>
            <input type="date" id="dob" name="dob">
            <label for="password">Mật khẩu *</label>
            <input type="password" id="password" name="password" required>
            <label for="confirm_password">Nhập lại mật khẩu *</label>
            <input type="password" id="confirm_password" name="confirm_password" required>
            <button type="submit" class="action-btn">Đăng ký</button>
        </form>
        <div class="auth-switch">
            Đã có tài khoản? <a href="/Jewelry%20Store/index.php">Đăng nhập</a>
        </div>
    </div>
</body>
