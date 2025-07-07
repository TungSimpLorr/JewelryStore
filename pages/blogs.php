<?php

include "../includes/connect.php";

$limit = 3;
$page = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
$offset = ($page - 1) * $limit;

// Lấy danh sách danh mục
$dm_result = $conn->query("SELECT id_danh_muc, ten_danh_muc FROM danh_muc_bai_viet");
$selected_dm = isset($_GET['danh_muc']) ? intval($_GET['danh_muc']) : 0;
$where = $selected_dm > 0 ? "WHERE bv.id_danh_muc = $selected_dm" : "";

// Đếm tổng bài viết theo danh mục
$total_sql = "SELECT COUNT(*) AS total FROM bai_viet bv $where";
$total_result = $conn->query($total_sql);
$total_row = $total_result->fetch_assoc();
$total_posts = $total_row['total'];
$total_pages = ceil($total_posts / $limit);

// Truy vấn bài viết theo danh mục
$sql = "SELECT bv.id_bai_viet, bv.tieu_de, bv.tom_tat, bv.hinh_anh, bv.ngay_dang, qtv.ho_ten
        FROM bai_viet bv
        LEFT JOIN quan_tri_vien qtv ON bv.id_nguoi_tao = qtv.id_quan_tri
        $where
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
    
    <!-- LỌC DANH MỤC -->
    <div class="filter-container">
        <form method="get" action="" class="category-filter-form">
            <label for="danh_muc"><b>Lọc bài viết theo danh mục:</b></label>
            <select name="danh_muc" id="danh_muc">
                <option value="0">-- Tất cả danh mục --</option>
                <?php if($dm_result) while($dm = $dm_result->fetch_assoc()): ?>
                    <option value="<?= $dm['id_danh_muc'] ?>" <?= $selected_dm == $dm['id_danh_muc'] ? 'selected' : '' ?>>
                        <?= htmlspecialchars($dm['ten_danh_muc']) ?>
                    </option>
                <?php endwhile; ?>
            </select>
            <button type="submit">Lọc</button>
        </form>
    </div>

    <!-- DANH SÁCH BÀI VIẾT -->
    <div class="blog-grid">
        <?php
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                // Sử dụng đường link ảnh từ cơ sở dữ liệu
                $image_path = !empty($row['hinh_anh']) ? $row['hinh_anh'] : "/Jewelry%20Store/images/blogs/no-image.jpg";
                echo '<div class="blog-card">';
                echo '<img class="blog-image" src="' . $image_path . '" alt="' . htmlspecialchars($row['tieu_de']) . '">';
                echo '<h3 class="blog-title">' . htmlspecialchars($row['tieu_de']) . '</h3>';
                echo '<p class="blog-date">Ngày đăng: ' . date("d/m/Y", strtotime($row['ngay_dang'])) . '</p>';
                echo '<p class="blog-author">Người viết: ' . htmlspecialchars($row['ho_ten'] ?? 'Không rõ') . '</p>';
                echo '<p class="blog-excerpt">' . htmlspecialchars($row['tom_tat']) . '</p>';
                echo '<a class="read-more" href="blogs-detail.php?id=' . $row['id_bai_viet'] . '">Đọc thêm &raquo;</a>';
                echo '</div>';
            }
        } else {
            echo "<p style='color:red;'>Không có bài viết nào.</p>";
        }
        ?>
        <div class="pagination">
        <?php
        for ($i = 1; $i <= $total_pages; $i++) {
            $query = http_build_query(array_merge($_GET, ['page' => $i]));
            if ($i == $page) {
                echo '<span class="current-page">' . $i . '</span>';
            } else {
                echo '<a class="page-link" href="?' . $query . '">' . $i . '</a>';
            }
        }
        ?>
        </div>
    </div>
</div>

<?php include "../../Jewelry Store/includes/footer.php"; ?>