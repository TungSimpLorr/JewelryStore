<?php
session_start();

// Tạo mảng giỏ hàng nếu chưa tồn tại
if (!isset($_SESSION['cart'])) {
    $_SESSION['cart'] = [];
}

// Xử lý xóa sản phẩm khỏi giỏ hàng
if (isset($_GET['remove'])) {
    $remove_id = $_GET['remove'];
    unset($_SESSION['cart'][$remove_id]);
}

// Cập nhật số lượng
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['update_qty'])) {
    foreach ($_POST['quantity'] as $product_id => $qty) {
        if ($qty <= 0) {
            unset($_SESSION['cart'][$product_id]);
        } else {
            $_SESSION['cart'][$product_id]['quantity'] = $qty;
        }
    }
}
?>
<DOCTYPE html>
<html lang="vi">    
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - JewelryStore</title>
    <link rel="stylesheet" href="../css/cart.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="cart-page">
<?php include "../includes/header.php"; ?>
<div class="cart-container">
    <h1>Giỏ hàng của bạn</h1>

    <?php if (empty($_SESSION['cart'])): ?>
        <p>Giỏ hàng đang trống.</p>
    <?php else: ?>
        <form method="post">
            <table>
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng</th>
                        <th>Xóa</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $total = 0;
                    foreach ($_SESSION['cart'] as $id => $item):
                        $subtotal = $item['price'] * $item['quantity'];
                        $total += $subtotal;
                    ?>
                    <tr>
                        <td><?= htmlspecialchars($item['name']) ?></td>
                        <td><?= number_format($item['price']) ?>₫</td>
                        <td>
                            <input type="number" name="quantity[<?= $id ?>]" value="<?= $item['quantity'] ?>" min="1">
                        </td>
                        <td><?= number_format($subtotal) ?>₫</td>
                        <td><a href="cart.php?remove=<?= $id ?>" onclick="return confirm('Xóa sản phẩm này?')">X</a></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <p><strong>Tổng cộng: <?= number_format($total) ?>₫</strong></p>
            <button type="submit" name="update_qty">Cập nhật giỏ hàng</button>
            <a href="checkout.php" class="checkout-btn">Tiến hành thanh toán</a>
        </form>
    <?php endif; ?>
</div>
<?php include "../includes/footer.php"; ?>
</body>
</html>
