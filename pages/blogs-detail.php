<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
include '../includes/connect.php';


$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($id <= 0) {
    echo "<p style='color:red;'>ID bài viết không hợp lệ.</p>";
    include '../includes/footer.php'; exit;
}

$sql = "SELECT bv.tieu_de, ct.noi_dung, ct.hinh_anh, ct.created_at, qtv.ho_ten 
        FROM bai_viet bv 
        JOIN chi_tiet_bai_viet ct ON bv.id_bai_viet = ct.id_bai_viet 
        JOIN quan_tri_vien qtv ON bv.id_nguoi_tao = qtv.id_quan_tri 
        WHERE bv.id_bai_viet = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
if (!$result->num_rows) {
    echo "<p style='color:red;'>Không tìm thấy bài viết.</p>";
    include '../includes/footer.php'; exit;
}
$bv = $result->fetch_assoc();
?>

<link rel="stylesheet" href="/JewelryStore/css/style.css">
<link rel="stylesheet" href="/JewelryStore/css/blog_detail.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/Jewelry%20Store/js/main.js"></script>
<script src="/Jewelry%20Store/js/process.js"></script>
<?php include '../includes/header.php'; ?>
<div class="blog-detail">
    <h1 class="blog-title"><?= htmlspecialchars($bv['tieu_de']) ?></h1>
    
    <div class="blog-meta">
        <i class="fas fa-user"></i> Người đăng: <?= htmlspecialchars($bv['ten_quan_tri_vien'] ?? 'Không rõ') ?> |
        <i class="fas fa-calendar-alt"></i> Ngày đăng: <?= date("d/m/Y", strtotime($bv['created_at'])) ?>
    </div>

    <div class="blog-content">
        <?php
        $noidung = trim($bv['noi_dung']);
        $doan = preg_split('/\r\n|\r|\n/', $noidung);

        if (!empty($bv['hinh_anh'])) {
            echo '<div class="blog-middle-image-wrapper">';
            echo '<img class="blog-middle-image" src="/JewelryStore/images/blogs-detail/' . htmlspecialchars($bv['hinh_anh']) . '" alt="Ảnh giữa bài">';
            echo '<img class="blog-middle-image" src="/JewelryStore/images/blog-detail/' . htmlspecialchars($bv['hinh_anh']) . '" alt="Ảnh giữa bài">';
            echo '</div>';
        }

        echo '<div class="blog-paragraphs">';
        foreach ($doan as $dong) {
            if (trim($dong) === '') continue;
            echo '<p>' . htmlspecialchars($dong) . '</p>';
        }
        echo '</div>';
        ?>
    </div>

    <div class="back-button">
        <a href="blogs.php">&larr; Quay lại danh sách bài viết</a>
    </div>
</div>

<?php include '../includes/footer.php'; ?>
