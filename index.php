<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jewelry Store</title>
    <link rel="stylesheet" href="/Jewelry%20Store/css/style.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" />
    <script src="https://kit.fontawesome.com/3a3ccaffa9.js" crossorigin="anonymous"></script>
    <script src="/Jewelry%20Store/js/jquery-3.7.1.min.js"></script>   
    <script src="/Jewelry%20Store/js/main.js"></script>
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

                    <!-- <div class="box-content-banner content-banner">
                <div class="content-banner">
                    <h2>Mua sắm tại Jewelry Store</h2>
                    <h3>Giảm giá 10% cho các hóa đơn trên 5 triệu VND.</h3>
                </div>
                <div class="button"><a href="#"></a></div>
            </div> -->

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
                        <h3>NHẨN </h3>
                    </div>
                    <div class="item"><img src="images/products/anh-danh-muc-san-pham-2.PNG">
                        <h3>VÒNG TAY </h3>
                    </div>
                    <div class="item"><img src="images/products/anh-danh-muc-san-pham-3.PNG">
                        <h3>ĐỒNG HỒ </h3>
                    </div>
                    <div class="item"><img src="images/products/anh-danh-muc-san-pham-4.PNG">
                        <h3>DÂY CHUYỀN/VÒNG CỔ</h3>
                    </div>
                    <div class="item"><img src="images/products/anh-danh-muc-san-pham-5.PNG">
                        <h3>KHUYÊN TAI </h3>
                    </div>
                </div>
            </div>
       
             <div class="mg title" id="introduce-page">
                <h2>GIỚI THIỆU</h2>
            </div>
            <div class="introduce-box" >
                <div class="introduce-content">
                    <h2>Nâng Tầm Vẻ Đẹp Với Trang Sức JewelryStory Tinh Hoa Việt Nam Vươn Tầm Thế Giới</h2>
                    <p>Trong hơn 60 năm, JewelryStory đã kiến tạo những thiết kế trang sức tinh tế, hòa quyện giữa di
                        sản Việt Nam, kỹ thuật chế tác bậc thầy và sự am hiểu sâu sắc về vẻ đẹp vượt thời gian.
                        Khởi nguồn từ trái tim Việt Nam, JewelryStory đã khẳng định vị thế trên thị trường trang sức cao
                        cấp nhờ không ngừng đổi mới công nghệ chế tác, tuyển chọn những vật liệu quý hiếm nhất và đặc
                        biệt chú trọng vào từng chi tiết thiết kế độc đáo.
                        Mỗi tác phẩm trang sức của JewelryStory không chỉ là một món phụ kiện, mà còn là một câu chuyện,
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