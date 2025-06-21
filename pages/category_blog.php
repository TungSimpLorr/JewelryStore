<?php
include '../includes/connect.php';
include '../includes/header.php';

// Hàm tạo tên file ảnh từ tiêu đề
function convertToSlug($str) {
    $str = strtolower(trim($str));
    $viet = ['á','à','ả','ã','ạ','ă','ắ','ằ','ẳ','ẵ','ặ','â','ấ','ầ','ẩ','ẫ','ậ',
             'đ','é','è','ẻ','ẽ','ẹ','ê','ế','ề','ể','ễ','ệ',
             'í','ì','ỉ','ĩ','ị',
             'ó','ò','ỏ','õ','ọ','ô','ố','ồ','ổ','ỗ','ộ','ơ','ớ','ờ','ở','ỡ','ợ',
             'ú','ù','ủ','ũ','ụ','ư','ứ','ừ','ử','ữ','ự',
             'ý','ỳ','ỷ','ỹ','ỵ'];
    $ascii = ['a','a','a','a','a','a','a','a','a','a','a','a','a','a','a','a','a',
              'd','e','e','e','e','e','e','e','e','e','e','e',
              'i','i','i','i','i',
              'o','o','o','o','o','o','o','o','o','o','o','o','o','o','o','o','o',
              'u','u','u','u','u','u','u','u','u','u','u',
              'y','y','y','y','y'];
    $str = str_replace($viet, $ascii, $str);
    $str = preg_replace('/[^a-z0-9]+/', '-', $str);
    return trim($str, '-') . '.jpg';
}

// Lấy danh mục
$danh_muc_id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($danh_muc_id <= 0) {
    echo "<p style='color:red;'>ID danh mục không hợp lệ.</p>";
    include '../includes/footer.php'; exit;
}

// Lấy tên danh mục
$stmt = $conn->prepare("SELECT ten_danh_muc FROM danh_muc_bai_viet WHERE id = ?");
$stmt->bind_param("i", $danh_muc_id);
$stmt->execute();
$result = $stmt->get_result();
if (!$result->num_rows) {
    echo "<p style='color:red;'>Không tìm thấy danh mục.</p>";
    include '../includes/footer.php'; exit;
}
$danh_muc = $result->fetch_assoc();

// Lấy bài viết
$sql = "SELECT bv.id, bv.tieu_de, ct.created_at, qtv.ten_quan_tri_vien
        FROM bai_viet bv
        JOIN chi_tiet_bai_viet ct ON bv.id = ct.id
        JOIN quan_tri_vien qtv ON bv.id_quan_tri_vien = qtv.id_quan_tri_vien
        WHERE bv.id_danh_muc = ?
        ORDER BY ct.created_at DESC";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $danh_muc_id);
$stmt->execute();
$posts = $stmt->get_result();
?>

<link rel="stylesheet" href="/JewelryStore/css/style.css">
<link rel="stylesheet" href="/JewelryStore/css/category_blog.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="content">
    <h2 class="category-title">Danh mục: <?= htmlspecialchars($danh_muc['ten_danh_muc']) ?></h2>

    <?php if ($posts->num_rows): ?>
        <ul class="category-posts">
            <?php while ($row = $posts->fetch_assoc()):
                $slug_image = convertToSlug($row['tieu_de']);
                $image_path = "/JewelryStore/images/blogs/" . $slug_image;
                $file_check_path = $_SERVER['DOCUMENT_ROOT'] . $image_path;
                if (!file_exists($file_check_path)) {
                    $image_path = "/JewelryStore/images/blogs/no-image.jpg";
                }
            ?>
                <li class="category-item">
                    <img class="category-thumb" src="<?= $image_path ?>" alt="<?= htmlspecialchars($row['tieu_de']) ?>">
                    <div class="category-info">
                        <a href="blogs-detail.php?id=<?= $row['id'] ?>" class="post-title">
                            <?= htmlspecialchars($row['tieu_de']) ?>
                        </a>
                        <div class="post-meta">
                            Người đăng: <?= htmlspecialchars($row['ten_quan_tri_vien']) ?> |
                            Ngày đăng: <?= date('d/m/Y', strtotime($row['created_at'])) ?>
                        </div>
                    </div>
                </li>
            <?php endwhile; ?>
        </ul>
    <?php else: ?>
        <p>Không có bài viết nào trong danh mục này.</p>
    <?php endif; ?>

    <div class="back-button">
        <a href="blogs.php">&larr; Quay lại danh sách bài viết</a>
    </div>
</div>

<?php include '../includes/footer.php'; ?>
