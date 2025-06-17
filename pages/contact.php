<?php
$successMessage = ""; // Biến lưu thông báo

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $conn = new mysqli("localhost", "root", "", "contact_jewelrystore");
    if ($conn->connect_error) {
        die("Kết nối thất bại: " . $conn->connect_error);
    }

    $name    = $conn->real_escape_string($_POST['name']);
    $email   = $conn->real_escape_string($_POST['email']);
    $phone   = $conn->real_escape_string($_POST['phone']);
    $subject = $conn->real_escape_string($_POST['subject']);
    $message = $conn->real_escape_string($_POST['message']);
    if (empty($name) || empty($email) || empty($message)) {
        $successMessage = "Vui lòng điền đầy đủ các trường bắt buộc.";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $successMessage = "Địa chỉ email không hợp lệ.";
    } else {
      $sql = "INSERT INTO contact_messages (name, email, phone, subject, message)
            VALUES ('$name', '$email', '$phone', '$subject', '$message')";
    // Thực thi truy vấn
      if ($conn->query($sql) === TRUE) {
        $successMessage = "Tin nhắn của bạn đã được gửi thành công!";
    } else {
        $successMessage = "Có lỗi xảy ra: " . $conn->error;
    }
    }
    $conn->close();
}
?> 
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Liên Hệ - JewelryStore</title>

  <link rel="stylesheet" href="../css/contact.css">
  <link rel="stylesheet" href="../css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body class="contact-page">
   <?php include "../includes/header.php"; ?>
   <?php if (!empty($successMessage)): ?>
          <div class="success-message">
            <?= htmlspecialchars($successMessage) ?>
          </div>
        <?php endif; ?>

  <main class="contact-page-container">
    <div class="contact-hero-section"> 
      <p class="contact-intro">
        Chúng tôi luôn sẵn lòng lắng nghe và giải đáp mọi thắc mắc của bạn. Đừng ngần ngại kết nối với JewelryStore!
      </p>
    </div>

    <div class="contact-content-wrapper">
      <!-- Thông tin liên hệ -->
      <section class="contact-info-section">
        <h2>Thông tin liên hệ</h2>
        <div class="store-address">
          <h3> <i class="fa-solid fa-shop"></i> Cửa hàng 1</h3>
          <p>215M Trung Mỹ Tây, Quận 12, Hồ Chí Minh</p>
          <p><strong>Điện thoại:</strong> 0123450001 </p>
        </div>

        <div class="store-address">
          <h3> <i class="fa-solid fa-shop"></i> Cửa hàng 2</h3>
          <p>Nguyễn Văn Nghi & Phan Văn Trị, Quận Gò Vấp, Hồ Chí Minh</p>
          <p><strong>Điện thoại:</strong> 0987650002</p>
        </div>

        <div class="general-contact">
          <p><strong><i class="fa-solid fa-square-phone"></i> Hotline chung:</strong> 0123456789</p>
          <p><strong><i class="fa-solid fa-envelope-open"></i> Email:</strong> <a href="mailto:lienhe@jewelrystore.vn">lienhe@jewelrystore.vn</a></p>
          <p><strong><i class="fa-solid fa-clock"></i> Giờ làm việc:</strong><br>
            Thứ 2 - Thứ 7: 9:00 - 21:00<br>
            Chủ Nhật & Ngày lễ: 10:00 - 19:00
          </p>
          <p>
            <strong> <i class="fa-solid fa-circle-question"></i> Bạn có câu hỏi?</strong> Xem qua trang <a href="faq.html" class="faq-link">Câu hỏi thường gặp</a> của chúng tôi.
          </p>
        </div>
      </section>

      <!-- Form liên hệ -->
      <section class="contact-form-section">
        <h2>Gửi tin nhắn cho chúng tôi</h2>
        <form action="contact.php" method="POST" class="contact-form">
          <div class="form-group">
            <label for="name">Họ và tên:</label>
            <input type="text" id="name" name="name" placeholder="Nguyen Van A" required/>
          </div>
          <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" placeholder="NguyenVanA@gmail.com" required/>
          </div>
          <div class="form-group">
            <label for="phone">Số điện thoại:</label>
            <input type="tel" id="phone" name="phone" placeholder="0123456789" required/>
          </div>
          <div class="form-group">
            <label for="subject">Chủ đề:</label>
            <select id="subject" name="subject">
              <option value="general">Thắc mắc chung</option>
              <option value="product">Hỏi về sản phẩm</option>
              <option value="order">Vấn đề đơn hàng</option>
              <option value="custom">Đặt hàng thiết kế</option>
              <option value="feedback">Góp ý</option>
            </select>
          </div>
          <div class="form-group">
            <label for="message">Nội dung tin nhắn:</label>
            <textarea id="message" name="message" rows="5" required></textarea>
          </div>
          <button type="submit" class="submit-button">Gửi tin nhắn</button>
        </form>
      </section>
    </div>

    <!-- Bản đồ -->
    <section class="map-section">
      <h2><i class="fa-solid fa-location-dot"></i> Tìm chúng tôi trên bản đồ</h2>
      <div class="map-iframe-container">
        <iframe
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.522274966157!2d106.62329081533917!3d10.848009260806382!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317529b080674b7d%3A0x5f78b75955668ad8!2sTrung%20M%E1%BB%B9%20T%C3%A2y%2C%20Qu%E1%BA%ADn%2012!5e0!3m2!1svi!2s!4v1678888888888"
          width="500" height="350" style="border:0;" allowfullscreen="" loading="lazy">
        </iframe>
      </div>
    </section>

    <!-- Mạng xã hội -->
    <section class="social-media-contact">
      <h3>Kết nối qua mạng xã hội</h3>
      <div class="social-icons-list">
        <a href="https://www.facebook.com/yourpage" target="_blank" title="Facebook" class="social-icon">
          <i class="fa-brands fa-facebook"></i>
        </a>
        <a href="https://www.instagram.com/yourpage" target="_blank" title="Instagram" class="social-icon">
          <i class="fa-brands fa-instagram"></i>
        </a>
        <a href="https://www.youtube.com/yourchannel" target="_blank" title="YouTube" class="social-icon">
          <i class="fa-brands fa-youtube"></i>
        </a>
        <a href="https://www.google.com/maps/place/yourbusiness" target="_blank" title="Google" class="social-icon">
          <i class="fa-brands fa-google"></i>
        </a>
        <a href="https://www.tiktok.com/@yourpage" target="_blank" title="TikTok" class="social-icon">
          <i class="fa-brands fa-tiktok"></i>
        </a>
      </div>
    </section>
  </main>
  <?php include "../includes/footer.php"; ?>
  <script>
  setTimeout(() => {
    const msg = document.querySelector(".success-message");
    if (msg) {
      msg.style.transition = "opacity 0.5s ease-out";
      msg.style.opacity = 0;
      setTimeout(() => msg.remove(), 500); // Xoá khỏi DOM
    }
  }, 5000); // Sau 5 giây
</script>
</body>
</html>
