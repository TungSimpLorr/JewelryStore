<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="/JewelryStore/css/style.css">
    <style>
        .dashboard-box {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(212,175,55,0.10);
            padding: 36px 24px 24px 24px;
            text-align: center;
            flex: 1;
            margin: 0 16px;
            border: 2px solid #d4af37;
            transition: box-shadow 0.3s;
        }
        .dashboard-box:hover {
            box-shadow: 0 8px 32px rgba(212,175,55,0.18);
        }
        .dashboard-row {
            display: flex;
            gap: 32px;
            justify-content: center;
            margin: 48px 0 32px 0;
        }
        .dashboard-value {
            font-size: 2.8rem;
            color: #d4af37;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .dashboard-label {
            font-size: 1.15rem;
            color: #222;
        }
        @media (max-width: 900px) {
            .dashboard-row { flex-direction: column; gap: 20px; }
            .dashboard-box { margin: 0 0 20px 0; }
        }
        .dashboard-chart-container {
            max-width: 600px;
            margin: 0 auto 40px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(212,175,55,0.08);
            padding: 32px 24px;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<?php
include '../includes/header.php';
include '../includes/connect.php';
// Lấy số liệu
$sql_sp = "SELECT COUNT(*) as total FROM san_pham";
$result_sp = $conn->query($sql_sp);
$total_sp = $result_sp ? $result_sp->fetch_assoc()['total'] : 0;
$sql_dh = "SELECT COUNT(*) as total FROM don_hang";
$result_dh = $conn->query($sql_dh);
$total_dh = $result_dh ? $result_dh->fetch_assoc()['total'] : 0;
$sql_dt = "SELECT SUM(tong_tien) as total FROM don_hang WHERE trang_thai = 'da_giao'";
$result_dt = $conn->query($sql_dt);
$total_dt = $result_dt ? $result_dt->fetch_assoc()['total'] : 0;
?>
<main>
    <div class="container">
        <div style="display:flex; justify-content:center; gap:32px; margin:36px 0 18px 0;">
            <a href="manage-products.php" style="min-width:170px; text-align:center; background:#fff; color:#111; border:2px solid #111; font-weight:bold; font-size:18px; border-radius:8px; padding:14px 0; transition:all 0.2s; text-decoration:none;">Quản lý sản phẩm</a>
            <a href="manage-blogs.php" style="min-width:170px; text-align:center; background:#fff; color:#111; border:2px solid #111; font-weight:bold; font-size:18px; border-radius:8px; padding:14px 0; transition:all 0.2s; text-decoration:none;">Quản lý bài viết</a>
            <a href="orders.php" style="min-width:170px; text-align:center; background:#fff; color:#111; border:2px solid #111; font-weight:bold; font-size:18px; border-radius:8px; padding:14px 0; transition:all 0.2s; text-decoration:none;">Quản lý đơn hàng</a>
        </div>
        <div class="boxcenter" style="justify-content:center;gap:40px;margin-top:40px;">
            <div class="dashboard-box">
                <div class="dashboard-value"><?php echo $total_sp; ?></div>
                <div class="dashboard-label">Tổng số sản phẩm</div>
            </div>
            <div class="dashboard-box">
                <div class="dashboard-value"><?php echo $total_dh; ?></div>
                <div class="dashboard-label">Tổng số đơn hàng</div>
            </div>
            <div class="dashboard-box">
                <div class="dashboard-value"><?php echo number_format($total_dt,0,',','.'); ?> đ</div>
                <div class="dashboard-label">Tổng doanh thu (đã giao)</div>
            </div>
        </div>
        <div class="dashboard-chart-container">
            <canvas id="dashboardChart"></canvas>
        </div>
    </div>
</main>
<script>
    const ctx = document.getElementById('dashboardChart').getContext('2d');
    const dashboardChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Sản phẩm', 'Đơn hàng', 'Doanh thu'],
            datasets: [{
                label: 'Thống kê',
                data: [<?php echo $total_sp; ?>, <?php echo $total_dh; ?>, <?php echo $total_dt ? $total_dt : 0; ?>],
                backgroundColor: [
                    'rgba(212, 175, 55, 0.7)',
                    'rgba(6, 123, 84, 0.7)',
                    'rgba(0, 0, 0, 0.7)'
                ],
                borderColor: [
                    'rgba(212, 175, 55, 1)',
                    'rgba(6, 123, 84, 1)',
                    'rgba(0, 0, 0, 1)'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false },
                title: {
                    display: true,
                    text: 'Biểu đồ tổng quan',
                    color: '#222',
                    font: { size: 18, weight: 'bold' }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { color: '#222', font: { size: 14 } }
                },
                x: {
                    ticks: { color: '#222', font: { size: 14 } }
                }
            }
        }
    });
</script>
<?php include '../includes/footer.php'; ?>
</body>
</html>
