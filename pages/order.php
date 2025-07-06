<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['order_success'])) {
    header('Location: cart.php');
    exit();
}

$order_info = $_SESSION['order_success'];
?>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Xác nhận đơn hàng - Jewelry Store</title>
    <link rel="stylesheet" href="/Jewelry%20Store/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://kit.fontawesome.com/3a3ccaffa9.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/Jewelry%20Store/js/main.js"></script>
    <style>

        .container {
            max-width: 800px;
            padding-top : 100px;
            background-color: white;
        }

        .success-icon {
            text-align: center;
            margin-bottom: 30px;
        }

        .success-icon i {
            font-size: 80px;
            color: #000000;
        }

        .order-details {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
        }

        .order-details h3 {
            margin-top: 0;
            color: #333;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: bold;
            color: #555;
        }

        .detail-value {
            color: #333;
        }

        .total-row {
            font-size: 18px;
            font-weight: bold;
            color: #000000;
            border-top: 2px solid #000000;
            padding-top: 10px;
        }

        .action-buttons {
            text-align: center;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: #000000;
            color: white;
        }

        .btn-success {
            background: #000000;
            color: white;
        }

        .btn:hover {
            opacity: 0.8;
        }
    </style>
</head>

<body>
    <?php include "../includes/header.php"; ?> 
          <div class="mg" style="background-color:white; border: none ;"></div>
    <div class="container">
       

        <div class="success-icon">
            <i class="fas fa-check-circle"></i>
        </div>

        <h1 style="text-align: center; color: #000000; margin-bottom: 30px;">
            Đặt hàng thành công!
        </h1>

        <p style="text-align: center; font-size: 18px; color: #666; margin-bottom: 30px;">
            Cảm ơn bạn đã mua sắm tại Jewelry Store. Đơn hàng của bạn đã được xử lý thành công.
        </p>

        <div class="order-details">
            <h3>Thông tin đơn hàng</h3>

            <div class="detail-row">
                <span class="detail-label">Mã đơn hàng:</span>
                <span class="detail-value">#<?= $order_info['order_id'] ?></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Ngày đặt hàng:</span>
                <span class="detail-value"><?= date('d/m/Y H:i', strtotime($order_info['order_date'])) ?></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Họ và tên:</span>
                <span class="detail-value"><?= htmlspecialchars($order_info['customer_name']) ?></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Số điện thoại:</span>
                <span class="detail-value"><?= htmlspecialchars($order_info['customer_phone']) ?></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Địa chỉ giao hàng:</span>
                <span class="detail-value"><?= htmlspecialchars($order_info['customer_address']) ?></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Phương thức thanh toán:</span>
                <span class="detail-value">
                    <?= $order_info['payment_method'] === 'cod' ? 'Thanh toán khi nhận hàng (COD)' : 'Chuyển khoản ngân hàng' ?>
                </span>
            </div>
        </div>


        <div class="order-details">
            <h3>Chi tiết sản phẩm đã mua</h3>

            <?php if (isset($order_info['items']) && is_array($order_info['items'])): ?>
                <?php
                $subtotal = 0;
                foreach ($order_info['items'] as $item):
                    $subtotal += $item['price'] * $item['quantity'];
                    ?>
                    <div class="item-row">
                        <div
                            style="display: flex; align-items: center; margin: 15px 0; padding: 10px; border: 1px solid #eee; border-radius: 5px;">
                            <img src="<?= htmlspecialchars($item['image']) ?>"
                                alt="<?= htmlspecialchars($item['name-product']) ?>"
                                style="width: 60px; height: 60px; object-fit: cover; border-radius: 5px; margin-right: 15px;">

                            <div style="flex: 1;">
                                <div style="font-weight: bold; color: #333; margin-bottom: 5px;">
                                    <?= htmlspecialchars($item['name-product']) ?>
                                </div>
                                <div style="color: #666; font-size: 14px;">
                                    Số lượng: <?= $item['quantity'] ?> |
                                    Giá: <?= number_format($item['price'], 0, ',', '.') ?> VND
                                </div>
                            </div>

                            <div style="font-weight: bold; color: #28a745; font-size: 16px;">
                                <?= number_format($item['price'] * $item['quantity'], 0, ',', '.') ?> VND
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>


                <div style="border-top: 2px solid #eee; padding-top: 15px; margin-top: 15px;">
                    <div class="detail-row">
                        <span class="detail-label">Tạm tính:</span>
                        <span class="detail-value"><?= number_format($subtotal, 0, ',', '.') ?> VND</span>
                    </div>

                    <div class="detail-row">
                        <span class="detail-label">Phí giao hàng:</span>
                        <span class="detail-value">30,000 VND</span>
                    </div>

                    <div class="detail-row total-row">
                        <span class="detail-label">Tổng tiền:</span>
                        <span class="detail-value"><?= number_format($order_info['total_amount'], 0, ',', '.') ?> VND</span>
                    </div>
                </div>
            <?php else: ?>
                <p style="color: #666; text-align: center; padding: 20px;">Không có thông tin sản phẩm</p>
            <?php endif; ?>
        </div>

        <div style="background: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; border-radius: 5px; margin: 20px 0;">
            <h4 style="margin-top: 0; color: #856404;">
                <i class="fas fa-info-circle"></i> Thông tin bổ sung
            </h4>
            <ul style="margin: 0; padding-left: 20px; color: #856404;">
                <li>Đơn hàng của bạn đang được xử lý và sẽ được giao trong 2-3 ngày làm việc.</li>
                <li>Chúng tôi sẽ liên hệ với bạn qua số điện thoại đã cung cấp để xác nhận đơn hàng.</li>
                <li>Bạn có thể theo dõi trạng thái đơn hàng bằng mã đơn hàng:
                    <strong>#<?= $order_info['order_id'] ?></strong></li>
            </ul>
        </div>

        <div class="action-buttons">
            <a href="/Jewelry%20Store/index.php" class="btn btn-primary">
                <i class="fas fa-home"></i> Về trang chủ
            </a>
            <a href="/Jewelry%20Store/pages/products.php" class="btn btn-success">
                <i class="fas fa-shopping-cart"></i> Tiếp tục mua sắm
            </a>
        </div>
    </div>

    <?php

    unset($_SESSION['order_success']);
    ?>
      <div class="mg" style="background-color:white; border: none ;"></div>
    <?php include '../includes/footer.php'; ?>
</body>

</html>