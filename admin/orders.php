<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
    <link rel="stylesheet" href="/Jewelry%20Store/css/admin.css" />
</head>
<body>
<?php
include '../includes/connect.php';
// Lấy danh sách đơn hàng
$sql = "SELECT dh.*, nd.ho_ten, nd.email FROM don_hang dh LEFT JOIN nguoi_dung nd ON dh.id_nguoi_dung = nd.id_nguoi_dung ORDER BY dh.id_don_hang DESC";
$result = $conn->query($sql);
// Xử lý cập nhật trạng thái
if (isset($_GET['action']) && isset($_GET['id'])) {
    $id = intval($_GET['id']);
    $action = $_GET['action'];
    if ($action === 'giaohang') {
        $conn->query("UPDATE don_hang SET trang_thai_don_hang = 'da_giao' WHERE id_don_hang = $id");
    } elseif ($action === 'huy') {
        $conn->query("UPDATE don_hang SET trang_thai_don_hang = 'da_huy' WHERE id_don_hang = $id");
    } elseif ($action === 'duyet') {
        $conn->query("UPDATE don_hang SET trang_thai_don_hang = 'da_duyet' WHERE id_don_hang = $id");
    }
    header('Location: orders.php');
    exit;
}
?>
<main>
    <div class="container">
        <h2 class="title" style="margin:30px 0 20px 0;">Quản lý đơn hàng</h2>
        <a href="dashboard.php" class="add-btn" style="margin-right: 12px;">Quay lại</a>
        <div class="table-container">
            <table class="orders-table">
                <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Khách hàng</th>
                        <th>Email</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Ngày đặt</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                <?php if ($result && $result->num_rows > 0):
                    while($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td>#<?php echo $row['id_don_hang']; ?></td>
                        <td><?php echo htmlspecialchars($row['ho_ten']); ?></td>
                        <td><?php echo htmlspecialchars($row['email']); ?></td>
                        <td><?php echo number_format($row['tong_tien'],0,',','.'); ?> đ</td>
                        <td><?php
                            if ($row['trang_thai_don_hang'] === 'da_giao') echo '<span class="status done">Đã giao</span>';
                            elseif ($row['trang_thai_don_hang'] === 'da_huy') echo '<span class="status cancel">Đã hủy</span>';
                            elseif ($row['trang_thai_don_hang'] === 'da_duyet') echo '<span class="status approved">Đã duyệt</span>';
                            else echo '<span class="status pending">Chờ xử lý</span>';
                        ?></td>
                        <td><?php echo $row['ngay_dat_hang']; ?></td>
                        <td>
                            <?php if ($row['trang_thai_don_hang'] === 'Pending'): ?>
    <a href="orders.php?action=duyet&id=<?php echo $row['id_don_hang']; ?>" class="action-btn approve-btn" onclick="return confirm('Duyệt đơn hàng này?');">Duyệt đơn</a>
    <a href="orders.php?action=giaohang&id=<?php echo $row['id_don_hang']; ?>" class="action-btn done-btn" onclick="return confirm('Xác nhận đơn này đã giao?');">Đã giao</a>
    <a href="orders.php?action=huy&id=<?php echo $row['id_don_hang']; ?>" class="action-btn cancel-btn" onclick="return confirm('Bạn chắc chắn muốn hủy đơn này?');">Đã hủy</a>
<?php elseif ($row['trang_thai_don_hang'] === 'da_duyet'): ?>
    <a href="orders.php?action=giaohang&id=<?php echo $row['id_don_hang']; ?>" class="action-btn done-btn" onclick="return confirm('Xác nhận đơn này đã giao?');">Đã giao</a>
    <a href="orders.php?action=huy&id=<?php echo $row['id_don_hang']; ?>" class="action-btn cancel-btn" onclick="return confirm('Bạn chắc chắn muốn hủy đơn này?');">Đã hủy</a>
<?php elseif ($row['trang_thai_don_hang'] !== 'da_giao' && $row['trang_thai_don_hang'] !== 'da_huy'): ?>
    <a href="orders.php?action=giaohang&id=<?php echo $row['id_don_hang']; ?>" class="action-btn done-btn" onclick="return confirm('Xác nhận đơn này đã giao?');">Đã giao</a>
    <a href="orders.php?action=huy&id=<?php echo $row['id_don_hang']; ?>" class="action-btn cancel-btn" onclick="return confirm('Bạn chắc chắn muốn hủy đơn này?');">Đã hủy</a>
<?php else: ?>
    -
<?php endif; ?>
                        </td>
                    </tr>
                <?php endwhile; else: ?>
                    <tr><td colspan="7">Không có đơn hàng nào.</td></tr>
                <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</main>
</body>
</html>







