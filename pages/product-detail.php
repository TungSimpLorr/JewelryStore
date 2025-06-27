<?php
 include "../includes/connect.php";
$id = isset($_GET["id"]) ? intval($_GET["id"]) :0;
$sql = "select * from san_pham where id_san_pham = $id";
$result = $conn->query($sql);
$product = $result->fetch_assoc();
?>

<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jewelry Store</title>
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://kit.fontawesome.com/3a3ccaffa9.js" crossorigin="anonymous"></script>
    <script src="../js/jquery-3.7.1.min.js"></script>
    <script src="../js/main.js"></script>

</head>

<body>
    <?php
   
    include "../includes/header.php";
    ?>

    <div style="margin-top: 1%;"></div>
    <div class="box hg ">

        <div class="details-product-box">

            <div class="img-details-product ">
                <div class="img-box">
                    <?php
                    if ($product && !empty($product['url_anh_dai_dien'])) {
                        echo '<img src="' . htmlspecialchars($product['url_anh_dai_dien']) . '" alt="Ảnh sản phẩm" width="300">';
                    } else {
                        echo '<span>Không có ảnh</span>';
                    }
                    ?>
                </div>
                
                <div class="mini-box">
                    <?php
                    $sql_imgs = "SELECT url_anh FROM anh_san_pham WHERE id_san_pham = " . intval($id);
                    $result_imgs = $conn->query($sql_imgs);
                    if ($result_imgs && $result_imgs->num_rows > 0) {
                        while ($row_img = $result_imgs->fetch_assoc()) {
                            echo '<div class="img-mini-box"><img src="' . htmlspecialchars($row_img['url_anh']) . '" alt="Ảnh sản phẩm phụ" width="60"></div>';
                        }
                    } else {
                        echo '<div class="img-mini-box">Không có ảnh phụ</div>';
                    }
                    ?>
                </div>
            </div>


            <div class="introduce-detail-product ">
                <div class="details-product-content">
                    <h2>
                        <?php
                        echo $product ? htmlspecialchars($product['ten_san_pham']) : 'Không tìm thấy sản phẩm';
                        ?>
                    </h2>
                    <p>
                        <?php
                        echo $product ? nl2br(htmlspecialchars($product['mo_ta'])) : '';
                        ?>
                    </p>
                    <h3>Price: 
                        <?php
                        echo $product ? number_format($product['gia_san_pham'], 0, ',', '.') . ' VND' : '';
                        ?>
                    </h3>

                </div>
                <div class="box-rating">
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <p>5.0 rating</p>
                </div>


                <form method="post" action="../pages/cart.php">
                    <input type="hidden" name="id_san_pham" value="<?php echo $product['id_san_pham']; ?>">
                    <input type="number" name="so_luong" value="1" min="1"; ?>
                    <button type="submit" name="add-to-cart" class="button"><h3>Thêm vào giỏ hàng</h3></button>


                </form>












            </div>
        </div>

    </div>
    <div class="mg" style="background-color : black; margin-top: 1%;"></div>

    <div class="box">
        <div class="description">
            <div class="description-content">
                <h3>Description</h3>
                <hr/>
                <p>
                    <?php
                    echo $product ? nl2br(htmlspecialchars($product['mo_ta'])) : '';
                    ?>
                </p>
                <hr/>
                <h3>Materials:</h3>
          
            </div>
            <div class="description-img">
                <?php
                if ($product && !empty($product['url_anh_dai_dien'])) {
                    echo '<img src="' . htmlspecialchars($product['url_anh_dai_dien']) . '" alt="Ảnh sản phẩm" width="200">';
                } else {
                    echo '<span>Không có ảnh</span>';
                }
                ?>
            </div>
        </div>
    </div>


    <?php include "../includes/footer.php"; ?>

</body>


</html>