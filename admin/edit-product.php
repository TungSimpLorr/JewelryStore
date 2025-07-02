<?php

include '../includes/connect.php';

$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($id <= 0) {
    echo "<div class='error'>Không tìm thấy sản phẩm!</div>";
    exit;
}

// Lấy loại và thương hiệu
$loai = $conn->query("SELECT * FROM loai_san_pham");
$thuonghieu = $conn->query("SELECT * FROM thuong_hieu");

// Lấy thông tin sản phẩm
$stmt = $conn->prepare("SELECT * FROM san_pham WHERE id_san_pham = ?");
$stmt->bind_param('i', $id);
$stmt->execute();
$sp = $stmt->get_result()->fetch_assoc();
if (!$sp) {
    echo "<div class='error'>Không tìm thấy sản phẩm!</div>";
    exit;
}

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
        $stmt = $conn->prepare("UPDATE san_pham SET ten_san_pham=?, gia_san_pham=?, id_loai_san_pham=?, id_thuong_hieu=?, url_anh_dai_dien=?, mo_ta=?, trang_thai_chung=? WHERE id_san_pham=?");
        $stmt->bind_param('sdiissii', $ten, $gia, $loai_id, $th_id, $anh, $mota, $trangthai, $id);
        if ($stmt->execute()) {
            $msg = '<div class="success">Cập nhật sản phẩm thành công!</div>';
            // Cập nhật lại dữ liệu mới nhất
            $stmt = $conn->prepare("SELECT * FROM san_pham WHERE id_san_pham = ?");
            $stmt->bind_param('i', $id);
            $stmt->execute();
            $sp = $stmt->get_result()->fetch_assoc();
        } else {
            $msg = '<div class="error">Lỗi: Không cập nhật được sản phẩm.</div>';
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
    <title>Sửa sản phẩm</title>
    <link rel="stylesheet" href="edit-product.css">
</head>
<body>
<main>
    <div class="container">
        <h2 style="margin:30px 0 20px 0;">Sửa sản phẩm</h2>
        <?php echo $msg; ?>
        <form method="post" class="add-product-form">
            <label>Tên sản phẩm:<input type="text" name="ten" value="<?php echo htmlspecialchars($sp['ten_san_pham']); ?>" required></label>
            <label>Giá:<input type="number" name="gia" min="0" value="<?php echo $sp['gia_san_pham']; ?>" required></label>
            <label>Loại:
                <select name="loai" required>
                    <option value="">--Chọn loại--</option>
                    <?php
                    $loai->data_seek(0);
                    while($l = $loai->fetch_assoc()):
                        $selected = $sp['id_loai_san_pham'] == $l['id_loai_san_pham'] ? 'selected' : '';
                    ?>
                        <option value="<?php echo $l['id_loai_san_pham']; ?>" <?php echo $selected; ?>><?php echo htmlspecialchars($l['ten_loai']); ?></option>
                    <?php endwhile; ?>
                </select>
            </label>
            <label>Thương hiệu:
                <select name="thuonghieu" required>
                    <option value="">--Chọn thương hiệu--</option>
                    <?php
                    $thuonghieu->data_seek(0);
                    while($th = $thuonghieu->fetch_assoc()):
                        $selected = $sp['id_thuong_hieu'] == $th['id_thuong_hieu'] ? 'selected' : '';
                    ?>
                        <option value="<?php echo $th['id_thuong_hieu']; ?>" <?php echo $selected; ?>><?php echo htmlspecialchars($th['ten_thuong_hieu']); ?></option>
                    <?php endwhile; ?>
                </select>
            </label>
            <label>Ảnh đại diện (URL):<input type="text" name="anh" value="<?php echo htmlspecialchars($sp['url_anh_dai_dien']); ?>" required></label>
            <label>Mô tả:<textarea name="mota" rows="3"><?php echo htmlspecialchars($sp['mo_ta']); ?></textarea></label>
            <label class="checkbox-label"><span>Hiển thị</span>
                <input type="checkbox" name="trangthai" <?php if($sp['trang_thai_chung']) echo 'checked'; ?>>
            </label>
            <div class="form-actions">
                <button type="submit" class="add-btn">Lưu thay đổi</button>
                <a href="manage-products.php" class="action-btn edit-btn">Quay lại</a>
            </div>
        </form>
    </div>
</main>

</body>
</html>        