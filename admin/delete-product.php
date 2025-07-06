<?php
include '../includes/connect.php';

$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($id > 0) {
    $stmt = $conn->prepare("DELETE FROM san_pham WHERE id_san_pham = ?");
    $stmt->bind_param('i', $id);
    $stmt->execute();
}
header('Location: manage-products.php');
?> 