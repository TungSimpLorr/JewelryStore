<?php
include "includes/connect.php";
$sql = "select * from san_pham order by id_san_pham desc limit 4";
$result = $conn->query($sql);

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jewelry Store</title>
    <link rel="stylesheet" href="/Jewelry%20Store/css/style.css" />
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" />
    <script src="https://kit.fontawesome.com/3a3ccaffa9.js" crossorigin="anonymous"></script>
    <script src="/Jewelry%20Store/js/jquery-3.7.1.min.js"></script>
    <script src="/Jewelry%20Store/js/main.js"></script>
    <script src="/Jewelry%20Store/js/process.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="/Jewelry%20Store/js/owl.js"></script>

</head>

<body>

    <?php include "./pages/cart.php"; ?>
    <div class="container">

        <?php include "includes/header.php"; ?>

        <main>

            <div class="boxcenter">

                <div class="box-banner">

                    <div class="img-banner owl-carousel">
                        <img src="./images/banner/anh-banner-1.png" alt="banner">
                        <img src="./images/banner/anh-banner-2.png" alt="banner">
                        <img src="./images/banner/anh-banner-3.png" alt="banner">
                    </div>


                </div>
            </div>
            <div class="box-content-introduce text-introduce">
                Chào mừng đến với JewelryStore, thương hiệu của Việt Nam luôn là một phần không thể thiếu trong những
                chuyến phiêu lưu ngoài trời của bạn kể từ những năm đầu của thế kỷ 21. Với niềm đam mê và chuyên môn của
                mình, chúng tôi thiết kế nên những món trang sức phụ kiện mang tính thẩm mỹ và nghệ thuật cao, giúp bạn
                tự tin thể hiện cá tính và phong cách riêng của mình.
                <br />
                <p>Khám phá những sản phẩm bán chạy nhất hiện tại của chúng tôi </p>
            </div>


            <div class="mg title">
                <h2>DANH MỤC SẢN PHẨM</h2>
            </div>


            <div class="box">
                <div class="product-type-list owl-carousel">
                    <div class="item"><img src="images/products/anh-danh-muc-san-pham-1.PNG">
                        <h3 style="width:100px ; height : 40px; margin-bottom : 100px; background "> <a href="/Jewelry%20Store/pages/products.php?type=Nhẫn&material=" style=" text-decoration: none; color: black; "> NHẨN </a></h3>
                    </div>
                    <div class="item"><img src="images/products/anh-danh-muc-san-pham-2.PNG">
                        <h3> <a href="/Jewelry%20Store/pages/products.php?type=Vòng+tay&material=" style=" text-decoration: none; color: black; "> VÒNG TAY </a></h3>
                    </div>
                    <div class="item"><img src="images/products/anh-danh-muc-san-pham-3.PNG">
                        <h3> <a href="/Jewelry%20Store/pages/products.php?type=Đồng+hồ&material=" style=" text-decoration: none; color: black; "> ĐỒNG HỒ </a></h3>
                    </div>
                    <div class="item"><img src="images/products/anh-danh-muc-san-pham-4.PNG">
                        <h3> <a href="/Jewelry%20Store/pages/products.php?type=Vòng+cổ&material=" style=" text-decoration: none; color: black; ">DÂY CHUYỀN/VÒNG CỔ
                            </a></h3>
                    </div>
                    <div class="item"><img src="images/products/anh-danh-muc-san-pham-5.PNG">
                        <h3> <a href="/Jewelry%20Store/pages/products.php?type=Hoa+tai&material=" style=" text-decoration: none; color: black; "> HOA TAI </a></h3>
                    </div>
                </div>
            </div>


            <div class="mg title">
                <h2>SẢN PHẨM MỚI NHẤT</h2>
            </div>
            <div class="box">
                <div class="product-type-list-1 owl-carousel">
                    <?php
                    while ($row = $result->fetch_assoc()) {
                        $products_id = $row["id_san_pham"];
                        $products_name = $row["ten_san_pham"];
                        $products_img = htmlspecialchars($row["url_anh_dai_dien"]);
                        echo '<div class="item"><img src="' . $products_img . '">
                    <h3 style=" text-align: center;">' . $products_name . '</h3>
                    <h3 style=" margin-top:10px;"><a href="./pages/product-detail.php?id=' . $products_id . '"  style="text-decoration: none; color:black;">MUA NGAY</a></h3>
                </div>';
                    }
                    ?>
                </div>
            </div>
            <div class="mg title" id="introduce-page">
                <h2>GIỚI THIỆU</h2>
            </div>
            <div class="introduce-box">
                <div class="introduce-content">
                    <h2>Nâng Tầm Vẻ Đẹp Với Trang Sức JewelryStory Tinh Hoa Việt Nam Vươn Tầm Thế Giới
                    </h2>
                    <p>Trong hơn 60 năm, JewelryStory đã kiến tạo những thiết kế trang sức tinh tế, hòa
                        quyện giữa di
                        sản Việt Nam, kỹ thuật chế tác bậc thầy và sự am hiểu sâu sắc về vẻ đẹp vượt
                        thời gian.
                        Khởi nguồn từ trái tim Việt Nam, JewelryStory đã khẳng định vị thế trên thị
                        trường trang sức cao
                        cấp nhờ không ngừng đổi mới công nghệ chế tác, tuyển chọn những vật liệu quý
                        hiếm nhất và đặc
                        biệt chú trọng vào từng chi tiết thiết kế độc đáo.
                        Mỗi tác phẩm trang sức của JewelryStory không chỉ là một món phụ kiện, mà còn là
                        một câu chuyện,
                        một biểu tượng của sự tinh tế và đẳng cấp Việt Nam.</p>
                    <hr style="width: 50%; margin: 20px auto; border: 1px solid #535252;" />
                    <h3>Khám phá vẻ đẹp vượt thời gian cùng JewelryStory.</h3>
                </div>

                <div class="introduce-img">
                    <img src="../Jewelry Store/images/banner/anh-nen-22.jpg">
                </div>

            </div>

        </main>

        <?php include "includes/footer.php"; ?>
    </div>


</body>

</html>