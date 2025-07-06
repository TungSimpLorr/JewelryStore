<?php
header('Content-Type: application/json; charset=utf-8');
include '../includes/connect.php';

$q = isset($_GET['q']) ? trim($_GET['q']) : '';
$resultArr = [];
if ($q !== '') {
    $stmt = $conn->prepare("SELECT id_san_pham, ten_san_pham, url_anh_dai_dien FROM san_pham WHERE ten_san_pham LIKE ? LIMIT 5");
    $like = "%$q%";
    $stmt->bind_param('s', $like);
    $stmt->execute();
    $res = $stmt->get_result();
    while ($row = $res->fetch_assoc()) {
        $resultArr[] = [
            'id' => $row['id_san_pham'],
            'name' => $row['ten_san_pham'],
            'image' => $row['url_anh_dai_dien']
        ];
    }
}
echo json_encode($resultArr, JSON_UNESCAPED_UNICODE); 