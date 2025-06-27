<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include "../includes/connect.php";
include "../includes/header.php";

// PHÂN TRANG
$limit = 5;
$page = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
$offset = ($page - 1) * $limit;

// LỌC THEO LOẠI SẢN PHẨM (nếu có)
$categoryId = isset($_GET['category']) ? intval($_GET['category']) : 0;
$whereClause = $categoryId > 0 ? "WHERE sp.id_loai_san_pham = ?" : "";

$categoryName = '';
if ($categoryId) {
    $query = $conn->prepare("SELECT ten_loai FROM loai_san_pham WHERE id_loai_san_pham = ?");
    $query->bind_param("i", $categoryId);
    $query->execute();
    $resultTenLoai = $query->get_result()->fetch_assoc();
    $categoryName = $resultTenLoai['ten_loai'] ?? '';
}


// TÍNH TỔNG SỐ SẢN PHẨM
$countSql = "SELECT COUNT(*) AS total FROM san_pham sp " . ($categoryId ? "WHERE sp.id_loai_san_pham = ?" : "");
$countStmt = $conn->prepare($countSql);
if ($categoryId) {
    $countStmt->bind_param("i", $categoryId);
}
$countStmt->execute();
$totalResult = $countStmt->get_result()->fetch_assoc();
$totalProducts = $totalResult['total'];
$totalPages = ceil($totalProducts / $limit);

// LẤY DANH SÁCH SẢN PHẨM
$sql = "
SELECT sp.id_san_pham, sp.ten_san_pham, sp.url_anh_dai_dien, sp.gia_san_pham, th.ten_thuong_hieu 
FROM san_pham sp
JOIN thuong_hieu th ON sp.id_thuong_hieu = th.id_thuong_hieu
" . ($categoryId ? "WHERE sp.id_loai_san_pham = ?" : "") . "
ORDER BY sp.id_san_pham DESC LIMIT ? OFFSET ?";

$stmt = $conn->prepare($sql);
if ($categoryId) {
    $stmt->bind_param("iii", $categoryId, $limit, $offset);
} else {
    $stmt->bind_param("ii", $limit, $offset);
}
$stmt->execute();
$result = $stmt->get_result();
?>

<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/product.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script scr="../js/main.js"></script>
<div class="content">
    <h2 class="product-section-title">
    <?php echo $categoryName ? htmlspecialchars($categoryName) : "Tất cả sản phẩm"; ?>
</h2>


    <div class="product-grid">
        <?php
        if ($result && $result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {

                echo '<div class="product-card">';
                echo '<img class="product-image" src="' . htmlspecialchars($row['url_anh_dai_dien']) . '" alt="' . htmlspecialchars($row['ten_san_pham']) . '">';
                echo '<h3 class="product-title">' . htmlspecialchars($row['ten_san_pham']) . '</h3>';
                echo '<p class="product-brand">Thương hiệu: ' . htmlspecialchars($row['ten_thuong_hieu']) . '</p>'; 
                echo '<p class="product-price">' . number_format($row['gia_san_pham'], 0, ',', '.') . ' đ</p>';
                echo '<a class="product-link" href="product-detail.php?id=' . $row['id_san_pham'] . '">Xem chi tiết &raquo;</a>';
                echo '</div>';
            }
        } else {
            echo "<p style='color:red;'>Không có sản phẩm nào.</p>";
        }
        ?>
    </div>

    <div class="pagination">
        <?php
        for ($i = 1; $i <= $totalPages; $i++) {
    $url = "?page=$i" . ($categoryId ? "&category=$categoryId" : '');
    if ($i == $page) {
        echo '<span class="current-page">' . $i . '</span>';
    } else {
        echo '<a class="page-link" href="' . $url . '">' . $i . '</a>';
    }
}

        ?>
    </div>
</div>

<?php include "../includes/footer.php"; ?>
