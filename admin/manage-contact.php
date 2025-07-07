<?php
// Kết nối database
require_once '../includes/connect.php';

// Xử lý xóa liên hệ nếu có yêu cầu
if (isset($_GET['delete_id'])) {
    $delete_id = intval($_GET['delete_id']);
    $stmt = $conn->prepare("DELETE FROM lien_he WHERE id = ?");
    $stmt->bind_param("i", $delete_id);
    $stmt->execute();
    $stmt->close();
    header("Location: manage-contacts.php");
    exit();
}

// Lấy danh sách liên hệ
$result = $conn->query("SELECT * FROM lien_he ORDER BY id DESC");
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/admin.css">
    <title>Quản lý liên hệ</title>
 
</head>
<body>
    <div class="container">
    <div class="page-title">Quản lý liên hệ</div>
    <a href="dashboard.php" class="add-btn">Quay lại </a>
    <div class="table-container">
    <table class="contact-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Họ tên</th>
                <th>Email</th>
                <th>SĐT</th>
                <th>Chủ đề</th>
                <th>Nội dung</th>
                <th>Xóa</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($row = $result->fetch_assoc()): ?>
            <tr>
                <td><?= $row['id'] ?></td>
                <td><?= htmlspecialchars($row['name']) ?></td>
                <td><?= htmlspecialchars($row['email']) ?></td>
                <td><?= htmlspecialchars($row['phone']) ?></td>
                <td><?= htmlspecialchars($row['subject']) ?></td>
                <td style="text-align:left;max-width:320px;white-space:pre-line;overflow-wrap:anywhere;"><?= nl2br(htmlspecialchars($row['message'])) ?></td>
                <td><a class="delete-btn action-btn" href="?delete_id=<?= $row['id'] ?>" onclick="return confirm('Bạn có chắc muốn xóa liên hệ này?');">Xóa</a></td>
            </tr>
            <?php endwhile; ?>
        </tbody>
    </table>
    </div>
</body>
</html>
<?php $conn->close(); ?>
