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
    <script src="js/jquery-3.7.1.min.js"></script>
    <script src="js/main.js"></script>

</head>

<body>
    <?php
   
    include "../includes/header.php";
    ?>

    <div class="mg"></div>
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
                    <div class="img-mini-box">anh sp 1</div>
                    <div class="img-mini-box">anh sp 2</div>
                    <div class="img-mini-box">anh sp 3</div>
                    <div class="img-mini-box">anh sp 4</div>
                    <div class="img-mini-box">anh sp 5</div>
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
                <div class="opiton-buy">
                    <div class="button"><a href="#">Mua ngay</a></div>
                    <div class="button"><i class="fa-solid fa-cart-shopping icon "
                            style="color: rgb(255, 255, 255); font-size: 15px;"></i><a href="#"> Thêm vào giỏ hàng </a>
                    </div>

                </div>
            </div>
        </div>

    </div>
    <div class="mg"></div>

    <div class="box">
        <div class="description">
            <div class="description-content">
                <h3>Description</h3>
                <hr />
                <p>
                    <?php
                    echo $product ? nl2br(htmlspecialchars($product['mo_ta'])) : '';
                    ?>
                </p>
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