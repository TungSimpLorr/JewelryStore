<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$path = realpath(__DIR__ . '/../includes/connect.php');
include $path;

if (isset($_POST['themvaogiohang'])) {
    $id_san_pham = intval($_POST['id_san_pham']);
    $so_luong = intval($_POST['so_luong']);


    $sql_product = "SELECT * FROM san_pham WHERE id_san_pham = $id_san_pham";
    $result_product = $conn->query($sql_product);
    $product = $result_product->fetch_assoc();

    if ($product) {
        if (!isset($_SESSION['cart']) || !is_array($_SESSION['cart'])) {
            $_SESSION['cart'] = [];
        }
        $found = false;
        // Kiểm tra sản phẩm đã có trong giỏ chưa
        foreach ($_SESSION['cart'] as &$item) {
            if ($item['id'] == $product['id_san_pham']) {
                $item['quantity'] += $so_luong;
                $found = true;
                break;
            }
        }
        unset($item);
        if (!$found) {
            $_SESSION['cart'][] = [
                'id' => $product['id_san_pham'],
                'name-product' => $product['ten_san_pham'],
                'price' => $product['gia_san_pham'],
                'image' => $product['url_anh_dai_dien'],
                'quantity' => $so_luong,
            ];
        }
    }

}
?>

<head>
    <link rel="stylesheet" href="/Jewelry%20Store/css/style.css"/>
    <script src="https://kit.fontawesome.com/3a3ccaffa9.js" crossorigin="anonymous"></script>
   
</head>

<body>
<div class="cart">
    <div class="basket">
        <div class="basket-box">
            <div class="basket-title">
                <h3>Giỏ hàng</h3>
                <a href="#"><i class="fa-solid fa-xmark icon " id="exit-icon"></i></a>
            </div>
            <div class="products-list-add">
                <?php
                $tong_tien = 0;
                if (!empty($_SESSION['cart']) && is_array($_SESSION['cart'])) {
                    foreach ($_SESSION['cart'] as $item) {
                        if (is_array($item)) {
                            $thanh_tien = $item['price'] * $item['quantity'];
                            $tong_tien += $thanh_tien;
                            echo '<div class="products-item">';
                            echo '  <div class="basket-product-img">';
                            echo '      <img src="' . htmlspecialchars($item['image']) . '" alt="Product Image">';
                            echo '  </div>';
                            echo '  <div class="basket-product-description text">';
                            echo '      <h3>' . htmlspecialchars($item['name-product']) . '</h3>';
                            echo '      <p>Giá: ' . number_format($item['price']) . ' VND</p>';
                            echo '      <p>Số lượng: ' . $item['quantity'] . '</p>';
                            echo '      <i class="fa-solid fa-trash-can" style="float:right; padding-right: 5%;" id="delete-product"></i>';
                            echo '  </div>';
                            echo '</div>';
                        }
                    }
                } else {
                    echo '<p>Giỏ hàng trống.</p>';
                }
                ?>
            </div>
        </div>

        <div class="basket-bill">
            <h3>TỔNG HÓA ĐƠN: <?php echo number_format($tong_tien); ?> VND.</h3>
            <div><a href="/Jewelry%20Store/pages/cart-detail.php">Đi đến thanh toán</a></div>
            <a href="../pages/products.php">Tiếp tục mua sắm</a>
        </div>
    </div>
</div>
</body>