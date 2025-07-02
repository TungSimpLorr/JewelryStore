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
// Hàm chuyển tiêu đề thành tên file ảnh
function slugify($text) {
    $text = strtolower($text);
    $text = preg_replace('/[áàảãạăắằẳẵặâấầẩẫậ]/u', 'a', $text);
    $text = preg_replace('/[éèẻẽẹêếềểễệ]/u', 'e', $text);
    $text = preg_replace('/[iíìỉĩị]/u', 'i', $text);
    $text = preg_replace('/[óòỏõọôốồổỗộơớờởỡợ]/u', 'o', $text);
    $text = preg_replace('/[úùủũụưứừửữự]/u', 'u', $text);
    $text = preg_replace('/[ýỳỷỹỵ]/u', 'y', $text);
    $text = preg_replace('/đ/u', 'd', $text);
    $text = preg_replace('/[^a-z0-9\- ]/', '', $text);
    $text = preg_replace('/\s+/', '-', $text);
    $text = preg_replace('/-+/', '-', $text);
    $text = trim($text, '-');
    return $text;
}
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
    <a href="dashboard.php" class="add-btn" style="margin-bottom: 16px; margin-right: 12px;">Quay lại</a>
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

$img_name = slugify($row['tieu_de']) . '.jpg';
$img_path = '/JewelryStore-2/images/blogs/' . $img_name;
// Kiểm tra file tồn tại, nếu không thì dùng ảnh mặc định
$img_full_path = $_SERVER['DOCUMENT_ROOT'] . $img_path;
if (!file_exists($img_full_path)) {
    $img_path = '/JewelryStore-2/images/logo.png';
}
?>
<img src="<?php echo htmlspecialchars($img_path); ?>" class="blog-img-thumb" alt="Ảnh bài viết">
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
