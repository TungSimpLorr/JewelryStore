<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include "../includes/connect.php";
include "../includes/header.php";

// PHÂN TRANG
$limit = 9;
$page = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
$offset = ($page - 1) * $limit;

// LỌC THEO LOẠI SẢN PHẨM (nếu có)
$categoryId = isset($_GET['category']) ? intval($_GET['category']) : 0;
$categoryName = '';
if ($categoryId) {
    $query = $conn->prepare("SELECT ten_loai FROM loai_san_pham WHERE id_loai_san_pham = ?");
    $query->bind_param("i", $categoryId);
    $query->execute();
    $resultTenLoai = $query->get_result()->fetch_assoc();
    $categoryName = $resultTenLoai['ten_loai'] ?? '';
}

// XỬ LÝ LỌC
$where = [];
$params = [];
$typestr = "";

// Lọc theo loại sản phẩm
if (!empty($_GET['type'])) {
    $where[] = "sp.ten_san_pham LIKE ?";
    $params[] = '%' . $_GET['type'] . '%';
    $typestr .= "s";
}
// Lọc theo chất liệu
if (!empty($_GET['material'])) {
    $where[] = "sp.chat_lieu LIKE ?";
    $params[] = '%' . $_GET['material'] . '%';
    $typestr .= "s";
}
// Lọc theo giá
if (!empty($_GET['price'])) {
    if ($_GET['price'] == '1-5') {
        $where[] = "sp.gia_san_pham >= 1000000 AND sp.gia_san_pham < 5000000";
    } elseif ($_GET['price'] == '5-10') {
        $where[] = "sp.gia_san_pham >= 5000000 AND sp.gia_san_pham < 10000000";
    } elseif ($_GET['price'] == '10+') {
        $where[] = "sp.gia_san_pham >= 10000000";
    }
}
// Lọc theo categoryId nếu có
if ($categoryId > 0) {
    $where[] = "sp.id_loai_san_pham = ?";
    $params[] = $categoryId;
    $typestr .= "i";
}
$whereClause = $where ? "WHERE " . implode(" AND ", $where) : "";

// Đếm tổng số sản phẩm
$countSql = "SELECT COUNT(*) AS total FROM san_pham sp $whereClause";
$countStmt = $conn->prepare($countSql);
if ($params) $countStmt->bind_param($typestr, ...$params);
$countStmt->execute();
$totalResult = $countStmt->get_result()->fetch_assoc();
$totalProducts = $totalResult['total'];
$totalPages = ceil($totalProducts / $limit);

// Lấy danh sách sản phẩm
$sql = "
SELECT sp.id_san_pham, sp.ten_san_pham, sp.url_anh_dai_dien, sp.gia_san_pham, th.ten_thuong_hieu 
FROM san_pham sp
JOIN thuong_hieu th ON sp.id_thuong_hieu = th.id_thuong_hieu
$whereClause
ORDER BY sp.id_san_pham DESC LIMIT ? OFFSET ?";
$params2 = $params;
$typestr2 = $typestr . "ii";
$params2[] = $limit;
$params2[] = $offset;
$stmt = $conn->prepare($sql);
$stmt->bind_param($typestr2, ...$params2);
$stmt->execute();
$result = $stmt->get_result();
?>

<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/product.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="content">
    <h2 class="product-section-title">
    <?php echo $categoryName ? htmlspecialchars($categoryName) : "Tất cả sản phẩm"; ?>
</h2>

    <div style="display:flex; gap:32px; align-items:flex-start;">
        <!-- Sidebar bộ lọc -->
        <form method="GET" style="min-width:240px; max-width:260px; background:#fffbe6; border:1px solid #e6c200; border-radius:10px; padding:24px 18px 18px 18px; color:#222; font-size:16px; box-shadow:0 2px 8px rgba(0,0,0,0.03); margin-bottom:24px;">
            <div style="margin-bottom:22px;">
                <div style="font-weight:bold; color:#222; margin-bottom:10px;">Khoảng giá</div>
                <label style="display:block; margin-bottom:8px; color:#bfa100;"><input type="radio" name="price" value="1-5" style="width:16px;height:16px;vertical-align:middle;" <?php if(isset($_GET['price']) && $_GET['price']=='1-5') echo 'checked'; ?>> 1-5 triệu</label>
                <label style="display:block; margin-bottom:8px; color:#bfa100;"><input type="radio" name="price" value="5-10" style="width:16px;height:16px;vertical-align:middle;" <?php if(isset($_GET['price']) && $_GET['price']=='5-10') echo 'checked'; ?>> 5-10 triệu</label>
                <label style="display:block; color:#bfa100;"><input type="radio" name="price" value="10+" style="width:16px;height:16px;vertical-align:middle;" <?php if(isset($_GET['price']) && $_GET['price']=='10+') echo 'checked'; ?>> Trên 10 triệu</label>
            </div>
            <div style="margin-bottom:22px;">
                <div style="font-weight:bold; color:#222; margin-bottom:10px;">Loại sản phẩm</div>
                <select name="type" style="width:100%; padding:6px 8px; border-radius:4px; border:1px solid #e6c200;">
                    <option value="">Tất cả</option>
                    <?php
                    $types = ['Vòng cổ', 'Nhẫn', 'Vòng tay', 'Đồng hồ', 'Hoa tai'];
                    foreach ($types as $type) {
                        $selected = (isset($_GET['type']) && $_GET['type'] == $type) ? 'selected' : '';
                        echo "<option value=\"$type\" $selected>$type</option>";
                    }
                    ?>
                </select>
            </div>
            <div style="margin-bottom:22px;">
                <div style="font-weight:bold; color:#222; margin-bottom:10px;">Chất liệu</div>
                <select name="material" style="width:100%; padding:6px 8px; border-radius:4px; border:1px solid #e6c200;">
                    <option value="">Tất cả</option>
                    <?php
                    $materials = ['Vàng', 'Bạc', 'Kim cương', 'Ngọc trai'];
                    foreach ($materials as $mat) {
                        $selected = (isset($_GET['material']) && $_GET['material'] == $mat) ? 'selected' : '';
                        echo "<option value=\"$mat\" $selected>$mat</option>";
                    }
                    ?>
                </select>
            </div>
            <button type="submit" style="background:#222; color:#fffbe6; border:none; border-radius:4px; padding:8px 0; width:100%; font-weight:bold; cursor:pointer; font-size:16px;">Lọc</button>
        </form>
        <!-- Danh sách sản phẩm -->
        <div style="flex:1;">
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
                // Giữ lại các tham số lọc khi chuyển trang
                $queryStr = $_GET;
                foreach(['page'] as $unset) unset($queryStr[$unset]);
                $baseUrl = '?' . http_build_query($queryStr);
                for ($i = 1; $i <= $totalPages; $i++) {
                    $url = $baseUrl . ($baseUrl ? '&' : '?') . "page=$i";
                    if ($i == $page) {
                        echo '<span class="current-page">' . $i . '</span>';
                    } else {
                        echo '<a class="page-link" href="' . $url . '">' . $i . '</a>';
                    }
                }
                ?>
            </div>
        </div>
    </div>
</div>

<?php include "../includes/footer.php"; ?>
