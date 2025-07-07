<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm mới</title>
      <link rel="stylesheet" href="/Jewelry%20Store/css/admin.css" />
</head>
<body>
<?php
include '../includes/connect.php';
// Lấy loại và thương hiệu
$loai = $conn->query("SELECT * FROM loai_san_pham");
$thuonghieu = $conn->query("SELECT * FROM thuong_hieu");
$msg = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $ten = $_POST['ten'] ?? '';
    $gia = $_POST['gia'] ?? 0;
    $loai_id = $_POST['loai'] ?? 0;
    $th_id = $_POST['thuonghieu'] ?? 0;
    $anh = $_POST['anh'] ?? '';
    $mota = $_POST['mota'] ?? '';
    $trangthai = isset($_POST['trangthai']) ? 1 : 0;
    if ($ten && $gia && $loai_id && $th_id && $anh) {
        $stmt = $conn->prepare("INSERT INTO san_pham (ten_san_pham, gia_san_pham, id_loai_san_pham, id_thuong_hieu, url_anh_dai_dien, mo_ta, trang_thai_chung) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param('sdiissi', $ten, $gia, $loai_id, $th_id, $anh, $mota, $trangthai);
        if ($stmt->execute()) {
            $msg = '<div class="success">Thêm sản phẩm thành công!</div>';
        } else {
            $msg = '<div class="error">Lỗi: Không thêm được sản phẩm.</div>';
        }
    } else {
        $msg = '<div class="error">Vui lòng nhập đầy đủ thông tin!</div>';
    }
}
?>
<main>
    <div class="container">
        <h2 class="add-product-title">Thêm sản phẩm mới</h2>
        <?php echo $msg; ?>
        <form method="post" class="add-product-form">
            <label>Tên sản phẩm:<input type="text" name="ten" required></label>
            <label>Giá:<input type="number" name="gia" min="0" required></label>
            <label>Loại:
                <select name="loai" required>
                    <option value="">--Chọn loại--</option>
                    <?php while($l = $loai->fetch_assoc()): ?>
                        <option value="<?php echo $l['id_loai_san_pham']; ?>"><?php echo htmlspecialchars($l['ten_loai']); ?></option>
                    <?php endwhile; ?>
                </select>
            </label>
            <label>Thương hiệu:
                <select name="thuonghieu" required>
                    <option value="">--Chọn thương hiệu--</option>
                    <?php while($th = $thuonghieu->fetch_assoc()): ?>
                        <option value="<?php echo $th['id_thuong_hieu']; ?>"><?php echo htmlspecialchars($th['ten_thuong_hieu']); ?></option>
                    <?php endwhile; ?>
                </select>
            </label>
            <label>Ảnh đại diện (URL):<input type="text" name="anh" required></label>
            <label>Mô tả:<textarea name="mota" rows="3"></textarea></label>
            <label class="checkbox-label"><span>Hiển thị</span><input type="checkbox" name="trangthai" checked></label>
            <div class="form-actions">
                <button type="submit" class="add-btn">Thêm sản phẩm</button>
                <a href="manage-products.php" class="action-btn edit-btn">Quay lại</a>
            </div>
        </form>
    </div>
</main>
</body>
</html>


