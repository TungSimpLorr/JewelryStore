<?php
include '../includes/connect.php';
$msg = '';
// Lấy danh sách danh mục
$categories = $conn->query("SELECT * FROM danh_muc_bai_viet");
// Lấy danh sách admin
$admins = $conn->query("SELECT id_quan_tri, ho_ten FROM quan_tri_vien");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $tieude = $_POST['tieude'] ?? '';
    $noidung = $_POST['noidung'] ?? '';
    $danhmuc = isset($_POST['danhmuc']) ? intval($_POST['danhmuc']) : 0;
    $admin = isset($_POST['admin']) ? intval($_POST['admin']) : 0;
    $trangthai = isset($_POST['trangthai']) ? 1 : 0;
    $ngay = date('Y-m-d');
    
    if ($tieude && $noidung && $danhmuc && $admin) {
        $stmt = $conn->prepare("INSERT INTO bai_viet (tieu_de, noi_dung, ngay_dang, id_danh_muc, id_nguoi_tao, trang_thai) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param('sssiii', $tieude, $noidung, $ngay, $danhmuc, $admin, $trangthai);
        if ($stmt->execute()) {
            $msg = '<div class="success">Thêm bài viết thành công!</div>';
        } else {
            $msg = '<div class="error">Lỗi: Không thêm được bài viết.</div>';
        }
    } else {
        $msg = '<div class="error">Vui lòng nhập đầy đủ thông tin!</div>';
    }
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm bài viết mới</title>
      <link rel="stylesheet" href="/Jewelry%20Store/css/admin.css" />
</head>
<body>
<main>
    <div class="blog-form">
        <h2 style="text-align:center; margin-bottom:30px;">Thêm bài viết mới</h2>
        <?php echo $msg; ?>
        <form method="post">
            <label><span>Tiêu đề:</span><input type="text" name="tieude" required></label>
            <label><span>Danh mục:</span>
                <select name="danhmuc" required>
                    <option value="">--Chọn danh mục--</option>
                    <?php if ($categories) while($cat = $categories->fetch_assoc()): ?>
                        <option value="<?php echo $cat['id_danh_muc']; ?>"><?php echo htmlspecialchars($cat['ten_danh_muc']); ?></option>
                    <?php endwhile; ?>
                </select>
            </label>
            <label><span>Người viết:</span>
                <select name="admin" required>
                    <option value="">--Chọn người viết--</option>
                    <?php if ($admins) while($ad = $admins->fetch_assoc()): ?>
                        <option value="<?php echo $ad['id_quan_tri']; ?>"><?php echo htmlspecialchars($ad['ho_ten']); ?></option>
                    <?php endwhile; ?>
                </select>
            </label>
            <label><span>Nội dung:</span><textarea name="noidung" rows="6" required></textarea></label>
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