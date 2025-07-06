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
// Phân trang
$limit = 10;
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
$offset = ($page - 1) * $limit;
// Đếm tổng số sản phẩm
$total_result = $conn->query("SELECT COUNT(*) as total FROM san_pham");
$total_row = $total_result ? $total_result->fetch_assoc()['total'] : 0;
$total_page = ceil($total_row / $limit);
// Lấy danh sách sản phẩm
$sql = "SELECT sp.*, lsp.ten_loai, th.ten_thuong_hieu FROM san_pham sp
        LEFT JOIN loai_san_pham lsp ON sp.id_loai_san_pham = lsp.id_loai_san_pham
        LEFT JOIN thuong_hieu th ON sp.id_thuong_hieu = th.id_thuong_hieu
        ORDER BY sp.id_san_pham DESC
        LIMIT $limit OFFSET $offset";
$result = $conn->query($sql);
?>
<main>
    <div class="container">
        <h1 class="page-title">QUẢN LÝ SẢN PHẨM</h1>
        <a href="dashboard.php" class="add-btn" style="margin-right: 12px;">Quay lại</a>
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
        <?php if ($total_page > 1): ?>
        <div class="pagination">
            <?php if ($page > 1): ?>
                <a href="?page=<?php echo $page-1; ?>" class="page-btn">&laquo; Trước</a>
            <?php endif; ?>
            <?php for ($i = 1; $i <= $total_page; $i++): ?>
                <a href="?page=<?php echo $i; ?>" class="page-btn<?php if ($i == $page) echo ' active'; ?>"><?php echo $i; ?></a>
            <?php endfor; ?>
            <?php if ($page < $total_page): ?>
                <a href="?page=<?php echo $page+1; ?>" class="page-btn">Sau &raquo;</a>
            <?php endif; ?>
        </div>
        <?php endif; ?>
    </div>
</main>
</body>
</html>
