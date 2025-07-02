<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        .dashboard-box {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.10);
            padding: 32px 24px 24px 24px;
            text-align: center;
            margin: 0 0 0 0;
            border: 2px solid #111;
            transition: box-shadow 0.3s, border-color 0.2s;
            max-width: 300px;
            width: 100%;
        }
        .dashboard-box:hover {
            box-shadow: 0 8px 32px rgba(0,0,0,0.18);
            border-color: #000;
        }
        .dashboard-row, .boxcenter {
            display: flex;
            flex-direction: row;
            align-items: stretch;
            justify-content: center;
            gap: 32px;
            margin: 32px 0 32px 0;
        }
        .dashboard-value {
            font-size: 2.2rem;
            color: #111;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .dashboard-label {
            font-size: 1.1rem;
            color: #222;
        }
        @media (max-width: 900px) {
            .dashboard-row, .boxcenter { flex-direction: column; gap: 0; }
            .dashboard-box { margin: 0 0 20px 0; max-width: 100%; }
        }
        .dashboard-chart-container {
            max-width: 600px;
            margin: 0 auto 40px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            padding: 32px 24px;
        }
        .dashboard-btn {
            background: #111;
            color: #fff !important;
            border: 2px solid #111;
            border-radius: 12px;
            padding: 14px 32px;
            font-size: 1.1rem;
            font-weight: bold;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: background 0.2s, color 0.2s, border-color 0.2s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            text-decoration: none;
            display: inline-block;
        }
        .dashboard-btn:hover {
            background: #fff;
            color: #111 !important;
            border-color: #111;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<?php
include '../includes/connect.php';
// Lấy số liệu
$sql_sp = "SELECT COUNT(*) as total FROM san_pham";
$result_sp = $conn->query($sql_sp);
$total_sp = $result_sp ? $result_sp->fetch_assoc()['total'] : 0;

$sql_dh = "SELECT COUNT(*) as total FROM don_hang";
$result_dh = $conn->query($sql_dh);
$total_dh = $result_dh ? $result_dh->fetch_assoc()['total'] : 0;

$result = $conn->query("SELECT SUM(tong_tien) AS total FROM don_hang WHERE trang_thai_don_hang = 'hoan_thanh'");
$total_dt = $result ? $result->fetch_assoc()['total'] : 0;
?>
<main>
    <div class="container">
        <div style="display:flex; justify-content:center; gap:32px; margin:36px 0 18px 0;">
            <a href="manage-products.php" class="dashboard-btn">Quản lý sản phẩm</a>
            <a href="manage-blogs.php" class="dashboard-btn">Quản lý bài viết</a>
            <a href="orders.php" class="dashboard-btn">Quản lý đơn hàng</a>
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
                    'rgba(0, 0, 0, 0.7)',
                    'rgba(0, 0, 0, 0.7)',
                    'rgba(0, 0, 0, 0.7)'
                ],
                borderColor: [
                    'rgba(0, 0, 0, 1)',
                    'rgba(0, 0, 0, 1)',
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

</body>
</html>
