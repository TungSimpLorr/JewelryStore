<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$order = isset($_SESSION['cart']) && is_array($_SESSION['cart']) ? $_SESSION['cart'] : [];
$subtotal = 0;
foreach ($order as $item) {
    $subtotal += $item['price'] * $item['quantity'];
}
$delivery = 30000;
$total = $subtotal + $delivery;
?>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/Jewelry%20Store/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://kit.fontawesome.com/3a3ccaffa9.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/Jewelry%20Store/js/main.js"></script>
    <script src="/Jewelry%20Store/js/process.js"></script>
    <title>Chi tiết giỏ hàng</title>
    <style>
        body {

            box-sizing: border-box;
        }

        .container {
            max-width: 800px;
            

        }

        h2 {
            font-size: 1.8em;
            margin-bottom: 20px;
        }

        .flex {
            display: flex;
            gap: 32px;
            margin-left: 20px;
        }

        .order-list {
            flex: 2;
        }

        .order-summary {
            flex: 1;
            background: #fafafa;
            border-radius: 8px;
            padding: 24px;
        }

        .order-item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding: 16px 0;
        }

        .order-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 6px;
            margin-right: 16px;
        }

        .order-item-info {
            flex: 1;
        }

        .order-item-name {
            font-weight: bold;
            font-size: 1.1em;
        }

        .order-item-size {
            color: #888;
            font-size: 0.95em;
        }

        .order-item-price {
            color: #222;
            margin-top: 4px;
        }

        .order-item-qty {
            color: #444;
        }

        .remove-btn {
            color: #c00;
            cursor: pointer;
            margin-left: 12px;
        }

        .summary-title {
            font-weight: bold;
            font-size: 1.2em;
            margin-bottom: 16px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .summary-total {
            font-weight: bold;
            font-size: 1.1em;
            color: #111;
        }

        .checkout-btn {
            width: 100%;
            background: #111;
            color: #fff;
            border: none;
            padding: 14px;
            border-radius: 6px;
            font-size: 1.1em;
            cursor: pointer;
            margin-top: 18px;
        }

        .checkout-btn:hover {
            background: #333;
        }

       
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .container-finalise {
            width: 400px;
            background-color: white;
            border-radius: 8px;
            position: relative;
        }

        .custommer-infomation {
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        .custommer-infomation label {
            font-size: 16px;
            color: #000000;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .custommer-infomation input,
        .custommer-infomation select {
            width: 100%;
            height: 40px;
            padding: 0 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .payment-complete {
            justify-content: center;
            align-items: center;
            display: flex;
        }

        .form-btn {
            width: 200px;
            height: 40px;
            background-color: #000000;
            color: white;
            font-size: 16px;
            border: none;
            margin-top: 20px;
            cursor: pointer;
            border-radius: 4px;
        }

        .form-btn:hover {
            background-color: #333;
        }

       
        .empty-cart {
            text-align: center;
            padding: 50px;
            color: #666;
        }

        .empty-cart i {
            font-size: 4em;
            margin-bottom: 20px;
            color: #ddd;
        }
    </style>
</head>

<body>
    <div class="container">
        <?php include "../includes/header.php"; ?>
        
        <div style="margin-left: 20px; padding-top: 10px;">
            <h2>Giỏ hàng của bạn</h2>
        </div>
        <hr />
        
      
        <?php if (isset($_SESSION['payment_errors']) && !empty($_SESSION['payment_errors'])): ?>
            <div style="background: #f8d7da; color: #721c24; padding: 15px; margin: 20px; border-radius: 5px; border: 1px solid #f5c6cb;">
                <h4 style="margin: 0 0 10px 0;">Có lỗi xảy ra:</h4>
                <ul style="margin: 0; padding-left: 20px;">
                    <?php foreach ($_SESSION['payment_errors'] as $error): ?>
                        <li><?= htmlspecialchars($error) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php unset($_SESSION['payment_errors']); ?>
        <?php endif; ?>
        
    
        <?php if (empty($order)): ?>
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <h3>Giỏ hàng trống</h3>
                <p>Bạn chưa có sản phẩm nào trong giỏ hàng.</p>
                <a href="../index.php" style="color: #111; text-decoration: none; font-weight: bold;">Tiếp tục mua sắm</a>
            </div>
        <?php else: ?>
            <div class="flex">
                <div class="order-list">
                    <h3>Đơn hàng của bạn</h3>
                    <?php foreach ($order as $index => $item): ?>
                        <div class="order-item" data-index="<?= $index ?>">
                            <img src="<?= htmlspecialchars($item['image']) ?>"
                                alt="<?= htmlspecialchars($item['name-product']) ?>">
                            <div class="order-item-info">
                                <div class="order-item-name"><?= htmlspecialchars($item['name-product']) ?></div>
                                <div class="order-item-price">Giá: <?= number_format($item['price'], 0, ',', '.') ?> VND</div>
                                <div class="order-item-qty">Số lượng: <?= $item['quantity'] ?></div>
                            </div>
                            <span class="remove-btn" title="Xóa sản phẩm" onclick="removeItem(<?= $index ?>)">
                                <i class="fa-solid fa-trash-can"></i>
                            </span>
                        </div>
                    <?php endforeach; ?>
                </div>
                <div class="order-summary">
                    <div class="summary-title">Tóm tắt đơn hàng của bạn</div>
                    <div class="summary-row">
                        <span>Tạm tính</span>
                        <span><?= number_format($subtotal, 0, ',', '.') ?> VND</span>
                    </div>
                    <div class="summary-row">
                        <span>Ước tính phí giao hàng</span>
                        <span><?= number_format($delivery, 0, ',', '.') ?> VND</span>
                    </div>
                    <div class="summary-row summary-total">
                        <span>Tổng cộng</span>
                        <span><?= number_format($total, 0, ',', '.') ?> VND</span>
                    </div>
                    <button class="checkout-btn" onclick="kiemtradangnhapthanhtoan()">TIẾN HÀNH THANH TOÁN</button>
                </div>
            </div>

         
            <div class="modal-overlay" id="checkinfor">
                <div class="container-finalise">
                    <div style="display: flex; align-items: center; background-color: #000000; height: 50px; color:white; border-radius: 8px 8px 0 0;">
                        <h2 style="margin-left: 20px;">Thông tin khách hàng</h2>
                    </div>
                    <form method="post" action="process_payment.php">
                        <div class="custommer-infomation">
                            <label for="name">Họ và tên:</label>
                            <input type="text" id="name" name="name" placeholder="Tên khách hàng" required>
                            
                            <label for="phone">Số điện thoại:</label>
                            <input type="tel" id="phone" name="phone" placeholder="Số điện thoại" required>
                            
                            <label for="address">Địa chỉ:</label>
                            <input type="text" id="address" name="address" placeholder="Địa chỉ" required>
                            
                            <label for="payment">Phương thức thanh toán:</label>
                            <select id="payment" name="payment" required>
                                <option value="">Chọn phương thức thanh toán</option>
                                <option value="cod">Thanh toán khi nhận hàng (COD)</option>
                                <option value="bank_transfer">Chuyển khoản ngân hàng</option>
                            </select>
                            
                            <button type="submit" class="form-btn">Hoàn tất thanh toán</button>
                            <button type="button" class="form-btn" onclick="dongthongtinkhachhang()" style="background-color: #666; margin-left: 10px;">Hủy</button>
                        </div>
                    </form>
                </div>
            </div>
        <?php endif; ?>

        <?php include '../includes/footer.php'; ?>
    </div>
   
       
  
       
  
</body>