<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="manage-products.css">
</head>
<body>
<?php
include '../includes/connect.php';
// Lấy danh sách sản phẩm
$sql = "SELECT sp.*, lsp.ten_loai, th.ten_thuong_hieu FROM san_pham sp
        LEFT JOIN loai_san_pham lsp ON sp.id_loai_san_pham = lsp.id_loai_san_pham
        LEFT JOIN thuong_hieu th ON sp.id_thuong_hieu = th.id_thuong_hieu
        ORDER BY sp.id_san_pham DESC";
$result = $conn->query($sql);
?>
<main>
    <div class="container">
        <a href="index.php" class="add-btn" style="margin-bottom: 16px; margin-right: 12px;">Quay lại</a>
        <a href="add-product.php" class="add-btn">+ Thêm sản phẩm mới</a>
        <div class="table-container">
            <table class="product-table">
                <thead>
                    <tr>
                        <th>Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Loại</th>
                        <th>Thương hiệu</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                <?php if ($result && $result->num_rows > 0):
                    while($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td><img src="<?php echo htmlspecialchars($row['url_anh_dai_dien']); ?>" alt="Ảnh sản phẩm"></td>
                        <td><?php echo htmlspecialchars($row['ten_san_pham']); ?></td>
                        <td><?php echo number_format($row['gia_san_pham'],0,',','.'); ?> đ</td>
                        <td><?php echo htmlspecialchars($row['ten_loai']); ?></td>
                        <td><?php echo htmlspecialchars($row['ten_thuong_hieu']); ?></td>
                        <td><?php echo $row['trang_thai_chung'] ? 'Hiện' : 'Ẩn'; ?></td>
                        <td>
                            <a href="edit-product.php?id=<?php echo $row['id_san_pham']; ?>" class="action-btn edit-btn">Sửa</a>
                            <a href="delete-product.php?id=<?php echo $row['id_san_pham']; ?>" class="action-btn delete-btn" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">Xóa</a>
                        </td>
                    </tr>
                <?php endwhile; else: ?>
                    <tr><td colspan="7">Không có sản phẩm nào.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</main>

</body>
</html>
