<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jewelry Store</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://kit.fontawesome.com/3a3ccaffa9.js" crossorigin="anonymous"></script>
    <script src="js/jquery-3.7.1.min.js"></script>
    <script src="js/main.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
</head>
<body>
     <div class="container">
      
        <?php include "includes/header.php"; ?>
     <main>
        
            <div class="boxcenter">
           <div class="sidebar">
            <nav>
              <ul>
                <li><a href="#"><i class="fa-solid fa-house icon " style="color: black";></i>Home</a></li>
                <li><a href="#" id="product-option"><i class="fa-solid fa-gem icon " style="color: black";></i>Product</a>
                <ul class="productbar">
                    <li><a href="#">Nhẩn      </a></li>
                    <li><a href="#">Dây chuyền</a></li>
                    <li><a href="#">Đồng hồ   </a></li>
                    <li><a href="#">Vòng tay  </a></li>
                    <li><a href="#">Khuyên tai</a></li>
                </ul>
        
                </li>
                <li><a href="#"><i class="fa-solid fa-cart-shopping icon " style="color: black";></i>Giỏ hàng</a></li>
                <li><a href="#"> <i class="fa-solid fa-circle-user icon" style="color: black";></i>Log in</a></li>
                <li><a href="#"><i class="fa-solid fa-phone icon "  style="color: black";></i>Contact</a></li>
            </ul>  
            </nav>

           </div> 
            <div class="box-banner">
             <div class="search-box">
               <input type="text" placeholder="Bạn đang tìm gì...">
                <button id="search">Search</button>
                </div>
             <div class="img-banner owl-carousel">
                    <img  src="images/banner/anh-banner-1.png" alt="banner">
                    <img  src="images/banner/anh-banner-2.png" alt="banner">
                    <img  src="images/banner/anh-banner-3.png" alt="banner">
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


            <div class="mg title"><h2>DANH MỤC SẢN PHẨM</h2></div> 
            <div class="box">
        <div class="product-type-list owl-carousel">
            <div class="item"><img src="images/products/anh-danh-muc-san-pham-1.PNG"><h3>NHẨN   </h3></div>
            <div class="item"><img src="images/products/anh-danh-muc-san-pham-2.PNG"><h3>VÒNG TAY       </h3></div>
            <div class="item"><img src="images/products/anh-danh-muc-san-pham-3.PNG"><h3>ĐỒNG HỒ </h3></div>
            <div class="item"><img src="images/products/anh-danh-muc-san-pham-4.PNG"><h3>DÂY CHUYỀN/VÒNG CỔ</h3></div>
            <div class="item"><img src="images/products/anh-danh-muc-san-pham-5.PNG"><h3>KHUYÊN TAI </h3></div>
             </div>
        </div>
    </main>

     </div>
    <?php include "includes/footer.php"; ?>

</body>
</html>