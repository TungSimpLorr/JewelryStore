<?php
include '../includes/connect.php';

// Xóa bài viết nếu có yêu cầu
if (isset($_GET['delete']) && is_numeric($_GET['delete'])) {
    $id = intval($_GET['delete']);
    $conn->query("DELETE FROM bai_viet WHERE id_bai_viet = $id");
    header('Location: manage-blogs.php');
    exit;
}

// Lấy danh sách bài viết
$result = $conn->query("SELECT * FROM bai_viet ORDER BY id_bai_viet DESC");
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý bài viết</title>
    <link rel="stylesheet" href="manage-products.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .add-btn-blog {
            display: inline-block;
            background: #000;
            color: #fff;
            font-weight: bold;
            padding: 10px 22px;
            border-radius: 6px;
            text-decoration: none;
            margin: 30px 0 10px 0;
            transition: background 0.2s;
        }
        .add-btn-blog:hover { background: #333; }
        .blog-img-thumb {
            width: 60px; height: 60px; object-fit: cover; border-radius: 6px;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="index.php" class="add-btn" style="margin-bottom: 16px; margin-right: 12px;">Quay lại</a>
    <a href="add-blog.php" class="add-btn-blog">+ Thêm bài viết mới</a>
    <div class="table-container">
        <table class="product-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Ảnh</th>
                    <th>Tiêu đề</th>
                    <th>Ngày đăng</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
            <?php while($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $row['id_bai_viet']; ?></td>
                    <td>
                        <?php
                        $img = isset($row['url_anh']) ? trim($row['url_anh']) : '';
                        if (!$img) {
                            $img = '../images/logo.png'; // ảnh mặc định
                        } elseif (strpos($img, 'http') === 0) {
                            // là URL ngoài
                            $img = $img;
                        } else {
                            // là tên file trong thư mục blogs
                            $img = '../images/blogs/' . $img;
                        }
                        ?>
                        <img src="<?php echo htmlspecialchars($img); ?>" class="blog-img-thumb" alt="Ảnh bài viết">
                    </td>
                    <td><?php echo htmlspecialchars($row['tieu_de']); ?></td>
                    <td><?php echo htmlspecialchars($row['ngay_dang']); ?></td>
                    <td><?php echo $row['trang_thai'] ? 'Hiện' : 'Ẩn'; ?></td>
                    <td>
                        <a href="edit-blog.php?id=<?php echo $row['id_bai_viet']; ?>" class="action-btn edit-btn">Sửa</a>
                        <a href="manage-blogs.php?delete=<?php echo $row['id_bai_viet']; ?>" class="action-btn delete-btn" onclick="return confirm('Bạn có chắc muốn xóa bài viết này?');">Xóa</a>
                    </td>
                </tr>
            <?php endwhile; ?>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
