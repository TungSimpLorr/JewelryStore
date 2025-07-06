<?php
include '../includes/connect.php';

$id = isset($_GET['id']) ? intval($_GET['id']) : 0;
if ($id > 0) {
    $stmt = $conn->prepare("DELETE FROM bai_viet WHERE id_bai_viet = ?");
    $stmt->bind_param('i', $id);
    $stmt->execute();
}
header('Location: manage-blogs.php');
<<<<<<< HEAD

=======
exit;
>>>>>>> 15604aa5f0caad861da4fa98461a33ae102b4a2e
?> 