<?php

include "../includes/connect.php";


// HÀM CHUYỂN TIÊU ĐỀ THÀNH TÊN FILE ẢNH
function convertToSlug($str)
{
    $str = strtolower(trim($str));
    $viet = [
        'á',
        'à',
        'ả',
        'ã',
        'ạ',
        'ă',
        'ắ',
        'ằ',
        'ẳ',
        'ẵ',
        'ặ',
        'â',
        'ấ',
        'ầ',
        'ẩ',
        'ẫ',
        'ậ',
        'đ',
        'é',
        'è',
        'ẻ',
        'ẽ',
        'ẹ',
        'ê',
        'ế',
        'ề',
        'ể',
        'ễ',
        'ệ',
        'í',
        'ì',
        'ỉ',
        'ĩ',
        'ị',
        'ó',
        'ò',
        'ỏ',
        'õ',
        'ọ',
        'ô',
        'ố',
        'ồ',
        'ổ',
        'ỗ',
        'ộ',
        'ơ',
        'ớ',
        'ờ',
        'ở',
        'ỡ',
        'ợ',
        'ú',
        'ù',
        'ủ',
        'ũ',
        'ụ',
        'ư',
        'ứ',
        'ừ',
        'ử',
        'ữ',
        'ự',
        'ý',
        'ỳ',
        'ỷ',
        'ỹ',
        'ỵ'
    ];
    $ascii = [
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'a',
        'd',
        'e',
        'e',
        'e',
        'e',
        'e',
        'e',
        'e',
        'e',
        'e',
        'e',
        'e',
        'i',
        'i',
        'i',
        'i',
        'i',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'o',
        'u',
        'u',
        'u',
        'u',
        'u',
        'u',
        'u',
        'u',
        'u',
        'u',
        'u',
        'y',
        'y',
        'y',
        'y',
        'y'
    ];
    $str = str_replace($viet, $ascii, $str);
    $str = preg_replace('/[^a-z0-9]+/', '-', $str);
    return trim($str, '-') . '.jpg';
}


$limit = 3;
$page = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
$offset = ($page - 1) * $limit;


$total_result = $conn->query("SELECT COUNT(*) AS total FROM bai_viet");
$total_row = $total_result->fetch_assoc();
$total_posts = $total_row['total'];
$total_pages = ceil($total_posts / $limit);

$sql = "SELECT bv.id_bai_viet, bv.tieu_de, bv.tom_tat, bv.ngay_dang, qtv.ho_ten
        FROM bai_viet bv
        LEFT JOIN quan_tri_vien qtv ON bv.id_nguoi_tao = qtv.id_quan_tri
        ORDER BY bv.ngay_dang DESC
        LIMIT ? OFFSET ?";



$stmt = $conn->prepare($sql);

if ($stmt === false) {
    die("Lỗi prepare: " . $conn->error);
}

$stmt->bind_param("ii", $limit, $offset);
$stmt->execute();
$result = $stmt->get_result();
?>


<link rel="stylesheet" href="/Jewelry%20Store/css/style.css">
<link rel="stylesheet" href="/Jewelry%20Store/css/blogs.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/Jewelry%20Store/js/main.js"></script>
<script src="/Jewelry%20Store/js/process.js"></script>
<?php include "../includes/header.php"; ?>
<div class="content">
    
    <!-- DANH SÁCH BÀI VIẾT -->
    <div class="blog-grid">
        <?php
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $slug_image = convertToSlug($row['tieu_de']);
                $image_path = "/JewelryStore/images/blogs/" . $slug_image;
                $file_check_path = $_SERVER['DOCUMENT_ROOT'] . $image_path;
                if (!file_exists($file_check_path)) {
                    $image_path = "/JewelryStore/images/blogs/no-image.jpg";
                }

                echo '<div class="blog-card">';
                echo '<img class="blog-image" src="' . $image_path . '" alt="' . htmlspecialchars($row['tieu_de']) . '">';
                echo '<h3 class="blog-title">' . htmlspecialchars($row['tieu_de']) . '</h3>';
                echo '<p class="blog-date">Ngày đăng: ' . date("d/m/Y", strtotime($row['ngay_dang'])) . '</p>';
                echo '<p class="blog-author">Người viết: ' . htmlspecialchars($row['ten_quan_tri_vien'] ?? 'Không rõ') . '</p>';
                echo '<p class="blog-excerpt">' . mb_strimwidth(strip_tags($row['noi_dung']), 0, 150, "...") . '</p>';
                echo '<a class="read-more" href="blogs-detail.php?id=' . $row['id_bai_viet'] . '">Đọc thêm &raquo;</a>';
                echo '</div>';
            }
        } else {
            echo "<p style='color:red;'>Không có bài viết nào.</p>";
        }
        ?>
    </div>

    <!-- PHÂN TRANG -->
    <div class="pagination">
        <?php
        for ($i = 1; $i <= $total_pages; $i++) {
            if ($i == $page) {
                echo '<span class="current-page">' . $i . '</span>';
            } else {
                echo '<a class="page-link" href="?page=' . $i . '">' . $i . '</a>';
            }
        }
        ?>
    </div>
</div>

<?php include "../../Jewelry Store/includes/footer.php"; ?>