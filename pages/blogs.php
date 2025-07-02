<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include "../includes/connect.php";
include "../includes/header.php";

// LẤY TẤT CẢ DANH MỤC CHO BỘ LỌC
$all_categories_result = $conn->query("SELECT id_danh_muc, ten_danh_muc FROM danh_muc_bai_viet ORDER BY ten_danh_muc ASC");
$all_categories = [];
if ($all_categories_result && $all_categories_result->num_rows > 0) {
    while ($cat_row = $all_categories_result->fetch_assoc()) {
        $all_categories[] = $cat_row;
    }
}

// LẤY ID DANH MỤC ĐANG ĐƯỢC LỌC TỪ URL
$category_id = isset($_GET['category_id']) ? intval($_GET['category_id']) : 0;

// HÀM CHUYỂN TIÊU ĐỀ THÀNH TÊN FILE ẢNH
function convertToSlug($str) {
    $str = strtolower(trim($str));
    $viet = ['á','à','ả','ã','ạ','ă','ắ','ằ','ẳ','ẵ','ặ','â','ấ','ầ','ẩ','ẫ','ậ','đ','é','è','ẻ','ẽ','ẹ','ê','ế','ề','ể','ễ','ệ','í','ì','ỉ','ĩ','ị','ó','ò','ỏ','õ','ọ','ô','ố','ồ','ổ','ỗ','ộ','ơ','ớ','ờ','ở','ỡ','ợ','ú','ù','ủ','ũ','ụ','ư','ứ','ừ','ử','ữ','ự','ý','ỳ','ỷ','ỹ','ỵ'];
    $ascii = ['a','a','a','a','a','a','a','a','a','a','a','a','a','a','a','a','a','d','e','e','e','e','e','e','e','e','e','e','e','i','i','i','i','i','o','o','o','o','o','o','o','o','o','o','o','o','o','o','o','o','o','u','u','u','u','u','u','u','u','u','u','u','y','y','y','y','y'];
    $str = str_replace($viet, $ascii, $str);
    $str = preg_replace('/[^a-z0-9]+/', '-', $str);
    return trim($str, '-') . '.jpg';
}

// PHÂN TRANG
$limit = 3;
$page = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
$offset = ($page - 1) * $limit;

// CẬP NHẬT TRUY VẤN ĐẾM BÀI VIẾT (CHO PHÂN TRANG)
$count_sql = "SELECT COUNT(*) AS total FROM bai_viet";
if ($category_id > 0) {
    $count_sql .= " WHERE id_danh_muc = ?";
}
$stmt_count = $conn->prepare($count_sql);
if ($category_id > 0) {
    $stmt_count->bind_param("i", $category_id);
}
$stmt_count->execute();
$total_result = $stmt_count->get_result();
$total_row = $total_result->fetch_assoc();
$total_posts = $total_row['total'];
$total_pages = ceil($total_posts / $limit);


// CẬP NHẬT TRUY VẤN LẤY BÀI VIẾT (ĐỂ LỌC)
$sql = "SELECT bv.id_bai_viet, bv.tieu_de, bv.noi_dung, bv.ngay_dang, qtv.ho_ten AS ten_quan_tri_vien
        FROM bai_viet bv
        LEFT JOIN quan_tri_vien qtv ON bv.id_nguoi_tao = qtv.id_quan_tri";
if ($category_id > 0) {
    $sql .= " WHERE bv.id_danh_muc = ?";
}
$sql .= " ORDER BY bv.ngay_dang DESC LIMIT ? OFFSET ?";

$stmt = $conn->prepare($sql);

// Cập nhật bind_param dựa trên việc có lọc theo danh mục hay không
if ($category_id > 0) {
    $stmt->bind_param("iii", $category_id, $limit, $offset);
} else {
    $stmt->bind_param("ii", $limit, $offset);
}
$stmt->execute();
$result = $stmt->get_result();
?>

<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/blogs.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="content">

    <div class="filter-container">
        <form action="blogs.php" method="GET" class="category-filter-form">
            <label for="category-select">Lọc bài viết theo danh mục:</label>
            <select name="category_id" id="category-select">
                <option value="0">-- Tất cả danh mục --</option>
                <?php foreach ($all_categories as $category): ?>
                    <option value="<?= $category['id_danh_muc'] ?>" <?= ($category_id == $category['id_danh_muc']) ? 'selected' : '' ?>>
                        <?= htmlspecialchars($category['ten_danh_muc']) ?>
                    </option>
                <?php endforeach; ?>
            </select>
            <button type="submit">Lọc</button>
        </form>
    </div>

    <div class="blog-grid">
        <?php
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $slug_image = convertToSlug($row['tieu_de']);
                $image_path = "/Jewelry Store/images/blogs/" . $slug_image;
                $file_check_path = $_SERVER['DOCUMENT_ROOT'] . $image_path;
                if (!file_exists($file_check_path)) {
                    $image_path = "/Jewelry Store/images/blogs/no-image.jpg";
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
            echo "<p style='color:red;'>Không có bài viết nào phù hợp.</p>";
        }
        ?>
    </div>
</div>
<div class="pagination">
        <?php
        $pagination_params = "";
        if ($category_id > 0) {
            $pagination_params = "&category_id=" . $category_id;
        }

        for ($i = 1; $i <= $total_pages; $i++) {
            if ($i == $page) {
                echo '<span class="current-page">' . $i . '</span>';
            } else {
                echo '<a class="page-link" href="?page=' . $i . $pagination_params . '">' . $i . '</a>';
            }
        }
        ?>
    </div>

<?php include "../includes/footer.php"; ?>