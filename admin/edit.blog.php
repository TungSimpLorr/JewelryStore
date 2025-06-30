<?php
include '../includes/connect.php';
$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($id <= 0) { echo "<div class='error'>Không tìm thấy bài viết!</div>"; exit; }
$stmt = $conn->prepare("SELECT * FROM bai_viet WHERE id_bai_viet = ?");
$stmt->bind_param('i', $id);
$stmt->execute();
$bv = $stmt->get_result()->fetch_assoc();
if (!$bv) { echo "<div class='error'>Không tìm thấy bài viết!</div>"; exit; }
$msg = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $tieude = $_POST['tieude'] ?? '';
    $noidung = $_POST['noidung'] ?? '';
    $trangthai = isset($_POST['trangthai']) ? 1 : 0;
    
    // Xử lý upload file
    $anh = $bv['url_anh']; // Giữ lại ảnh cũ mặc định
    
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
    }
    
    if ($tieude && $anh && $noidung && empty($msg)) {
        $stmt = $conn->prepare("UPDATE bai_viet SET tieu_de=?, url_anh=?, noi_dung=?, trang_thai=? WHERE id_bai_viet=?");
        $stmt->bind_param('sssii', $tieude, $anh, $noidung, $trangthai, $id);
        if ($stmt->execute()) {
            $msg = '<div class="success">Cập nhật bài viết thành công!</div>';
            $stmt = $conn->prepare("SELECT * FROM bai_viet WHERE id_bai_viet = ?");
            $stmt->bind_param('i', $id);
            $stmt->execute();
            $bv = $stmt->get_result()->fetch_assoc();
        } else {
            $msg = '<div class="error">Lỗi: Không cập nhật được bài viết.</div>';
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
    <title>Sửa bài viết</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="manage-products.css">
    <link rel="stylesheet" href="edit-blog.css">
</head>
<body>
<main>
    <div class="blog-form">
        <h2 style="text-align:center; margin-bottom:30px;">Sửa bài viết</h2>
        <?php echo $msg; ?>
        <form method="post" enctype="multipart/form-data">
            <label>Tiêu đề:<input type="text" name="tieude" value="<?php echo htmlspecialchars($bv['tieu_de']); ?>" required></label>
            <label>Ảnh đại diện:<input type="file" name="anh" accept="image/*"></label>
            <?php if (!empty($bv['url_anh'])): ?>
            <div style="margin: 10px 0; padding: 10px; background: #f9f9f9; border-radius: 4px;">
                <strong>Ảnh hiện tại:</strong><br>
                <img src="../<?php echo htmlspecialchars($bv['url_anh']); ?>" style="max-width: 200px; max-height: 150px; margin-top: 5px;">
                <p style="margin: 5px 0 0 0; font-size: 12px; color: #666;">Để giữ ảnh hiện tại, không chọn file mới</p>
            </div>
            <?php endif; ?>
            <label>Nội dung:<textarea name="noidung" rows="6" required><?php echo htmlspecialchars($bv['noi_dung']); ?></textarea></label>
            <label class="checkbox-label"><span>Hiển thị</span><input type="checkbox" name="trangthai" <?php if($bv['trang_thai']) echo 'checked'; ?>></label>
            <div class="form-actions">
                <button type="submit" class="add-btn">Lưu thay đổi</button>
                <a href="manage-blogs.php" class="edit-btn">Quay lại</a>
            </div>
        </form>
    </div>
</main>
</body>
</html> 