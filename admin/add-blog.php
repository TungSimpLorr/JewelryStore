<?php
include '../includes/connect.php';
$msg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $tieude = $_POST['tieude'] ?? '';
    $noidung = $_POST['noidung'] ?? '';
    $trangthai = isset($_POST['trangthai']) ? 1 : 0;
    $ngay = date('Y-m-d');
    
    // Xử lý upload file
    $anh = '';
    if (isset($_FILES['anh']) && $_FILES['anh']['error'] === UPLOAD_ERR_OK) {
        $upload_dir = '../images/blogs/';
        
        // Tạo thư mục nếu chưa tồn tại
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0755, true);
        }
        
        $file_info = pathinfo($_FILES['anh']['name']);
        $file_extension = strtolower($file_info['extension']);
        
        // Kiểm tra định dạng file
        $allowed_extensions = ['jpg', 'jpeg', 'png', 'gif'];
        if (!in_array($file_extension, $allowed_extensions)) {
            $msg = '<div class="error">Chỉ chấp nhận file ảnh (JPG, PNG, GIF)!</div>';
        } else {
            // Tạo tên file mới để tránh trùng lặp
            $new_filename = 'blog_' . time() . '_' . uniqid() . '.' . $file_extension;
            $upload_path = $upload_dir . $new_filename;
            
            if (move_uploaded_file($_FILES['anh']['tmp_name'], $upload_path)) {
                $anh = $new_filename;
            } else {
                $msg = '<div class="error">Lỗi khi tải file lên!</div>';
            }
        }
    } else {
        $msg = '<div class="error">Vui lòng chọn file ảnh!</div>';
    }
    
    if ($tieude && $anh && $noidung && empty($msg)) {
        $stmt = $conn->prepare("INSERT INTO bai_viet (tieu_de, url_anh, noi_dung, ngay_dang, trang_thai) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param('ssssi', $tieude, $anh, $noidung, $ngay, $trangthai);
        if ($stmt->execute()) {
            $msg = '<div class="success">Thêm bài viết thành công!</div>';
        } else {
            $msg = '<div class="error">Lỗi: Không thêm được bài viết.</div>';
        }
    } elseif (empty($msg)) {
        $msg = '<div class="error">Vui lòng nhập đầy đủ thông tin!</div>';
    }
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm bài viết mới</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="manage-products.css">
    <link rel="stylesheet" href="add-blog.css">
</head>
<body>
<main>
    <div class="blog-form">
        <h2 style="text-align:center; margin-bottom:30px;">Thêm bài viết mới</h2>
        <?php echo $msg; ?>
        <form method="post" enctype="multipart/form-data">
            <label>Tiêu đề:<input type="text" name="tieude" required></label>
            <label>Ảnh đại diện:<input type="file" name="anh" accept="image/*" required></label>
            <label>Nội dung:<textarea name="noidung" rows="6" required></textarea></label>
            <label class="checkbox-label"><span>Hiển thị</span><input type="checkbox" name="trangthai" checked></label>
            <div class="form-actions">
                <button type="submit" class="add-btn">Thêm bài viết</button>
                <a href="manage-blogs.php" class="edit-btn">Quay lại</a>
            </div>
        </form>
    </div>
</main>

</body>
</html> 