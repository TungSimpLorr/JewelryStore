<head>
    <link rel="stylesheet" href="/Jewelry%20Store/css/style.css">
    <style>
        
        .form-container {
            position: absolute;
            top: 250%;
            right: 0;
            background: white;
            border: 1px solid #ddd;
            padding: 20px;
            width: 300px;
            z-index: 1001;
            display: none;
        }

      .form-container h2 {
            margin: 0 0 20px 0;
            color: #333;
            text-align: center;
        }

        .form-container form {
            display: flex;
            flex-direction: column;
        }

        .form-container label {
            margin-bottom: 5px;
            color: #000000;
            font-weight: bold;
        }

        .form-container input {
            padding: 10px;
            border: 1px solid #ddd;
            margin-bottom: 15px;
            font-size: 14px;
            background-color: white;
            width: 100%;
        }

        .form-container button {
            background: #000000;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .form-container button:hover {
            background: #555;
        }

        .form-container .footer {
            text-align: center;
            font-size: 14px;
            color: #000000;
        }

        .form-container .footer a {
            color: #000000;
            text-decoration: none;
            font-weight: bold;
        }

        .form-container .footer a:hover {
            text-decoration: underline;
        }

        
        .user-icon-container {
            position: relative;
            display: inline-block;
        }
    </style>
</head>

<body>

    <header>
        <div class="topbar">
            <p>Mua sắm trực tuyến tại Jewelry Store - Liên hệ : 0123456789</p>
        </div>
        <div class="menu-bar">
            <div class="box-icon"></div>
            <nav>
                <ul>
                    <li><a href="../../Jewelry Store/index.php">Home</a></li>
                    <li><a href="../../Jewelry Store/pages/products.php">Product</a></li>
                    <li><a href="../../Jewelry Store/index.php#introduce-page">Introduce</a></li>
                    <li><a href="../../Jewelry Store/pages/blogs.php">Blogs</a></li>
                    <li><a href="../../Jewelry Store/pages/contact.php">Contact</a></li>
                </ul>
            </nav>

            <div class="box-icon">
               <i class="fa-solid fa-magnifying-glass" id="cart-search-icon"></i>
               <i class="fa-solid fa-cart-shopping " id="cart-shopping-icon"></i>
               <div class="user-icon-container">
                   <i class="fa-solid fa-circle-user" id="cart-user-icon" onclick="toggleLoginForm()"></i>
                  
                   <div class="form-container" id="login" >
                       <h2>Login</h2>
                       <form method="POST" action="process.php">
                           <label for="login-username">Tên tài khoản:</label>
                           <input type="text" id="login-username" name="tendangnhap" required>

                           <label for="login-password">Password:</label>
                           <input type="password" id="login-password" name="matkhau" required>

                           <button type="button" onclick="kiemtrataikhoan()">Đăng nhập</button>
                           <div class="footer">
                               Mày chưa có tài khoản ? <a href="/Jewelry%20Store/pages/register.php">Tạo tài khoản</a>
                           </div>
                       </form>
                   </div>
               </div>
            </div>

        </div>
        <div style="position:relative;">
            <div class="search-box">
                <input type="text" id="search-input" placeholder="Bạn đang tìm gì...">
                <button id="search">Search</button>
                <div id="search-suggestions"
                    style="position:absolute; left:0; top:100%; background:#fff; border:1px solid #ccc; width:100%; z-index:1000; display:none;">
                </div>
            </div>
    </header>

   
</body>