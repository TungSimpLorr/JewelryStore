
function checkLoginStatus() {
    var formData = new FormData();
    formData.append('check_login_status', '1');

    fetch('/Jewelry%20Store/pages/process.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.logged_in) {
            
            updateUserIcon(true, data.username);
        } else {
          
            updateUserIcon(false);
        }
    })
    .catch(error => {
        console.error('Error checking login status:', error);
        updateUserIcon(false);
    });
}

function toggleLoginForm() {
    const loginForm = document.getElementById('login');
    if (loginForm.style.display === 'block') {
        loginForm.style.display = 'none';
    } else {
        loginForm.style.display = 'block';
    }
}

document.addEventListener('click', function (event) {
    const loginForm = document.getElementById('login');
    const userIcon = document.getElementById('cart-user-icon');

    if (!loginForm.contains(event.target) && !userIcon.contains(event.target)) {
        loginForm.style.display = 'none';
    }
});

document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
        document.getElementById('login').style.display = 'none';
    }
});
function updateUserIcon(isLoggedIn, username = '') {
    const userIcon = document.getElementById('cart-user-icon');
    const loginForm = document.getElementById('login');
    
    if (isLoggedIn) {
        
        userIcon.className = 'fa-solid fa-user-check';
        userIcon.title = 'Đã đăng nhập: ' + username;
        
       
        loginForm.innerHTML = `
            <h2>Tài khoản</h2>
            <div style="text-align: center; padding: 20px;">
                <p>Xin chào, <strong>${username}</strong>!</p>
                <button type="button" onclick="logout()" style="background:rgb(0, 0, 0); color: white; padding: 12px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; width: 100%;">
                    Đăng xuất
                </button>
            </div>
        `;
    } else {
       
        userIcon.className = 'fa-solid fa-circle-user';
        userIcon.title = 'Đăng nhập';
        
       
        loginForm.innerHTML = `
            <h2>Login</h2>
            <form method="POST" action="process.php">
                <label for="login-username">Tên tài khoản:</label>
                <input type="text" id="login-username" name="tendangnhap" required>

                <label for="login-password">Password:</label>
                <input type="password" id="login-password" name="matkhau" required>

                <button type="button" onclick="kiemtrataikhoan()">Đăng nhập</button>
                <div class="footer">
                    Bạn chưa có tài khoản ? <a href="#">Tạo tài khoản</a>
                </div>
            </form>
        `;
    }
}



function kiemtradangnhapthanhtoan() {
    var formData = new FormData();
    formData.append('check_login_status', '1');

    fetch('/Jewelry%20Store/pages/process.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.logged_in) {

                hiennhapthongtinkhachhang();
            } else {

                alert('Vui lòng đăng nhập để thanh toán!');
                toggleLoginForm();
            }
        })
        .catch(error => {
            console.error('Error checking login status:', error);
            alert('Có lỗi xảy ra!');
        });
}

function kiemtrataikhoan() {
    var tennguoidung = document.querySelector('input[name="tendangnhap"]').value;
    var matkhau = document.querySelector('input[name="matkhau"]').value;

    var formData = new FormData();
    formData.append('kiemtrataikhoan', '1');
    formData.append('tennguoidung', tennguoidung);
    formData.append('matkhau', matkhau);

    fetch('/Jewelry%20Store/pages/process.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
            alert(data.message);
            
            if (data.user_type === 'admin') {
                window.location.href = '/Jewelry%20Store/admin/dashboard.php';
            } else {
                checkLoginStatus();
                document.getElementById('login').style.display = 'none';
            }
        } else {
            alert(data.message);
        }
        })
        .catch(error => {
            alert('Có lỗi xảy ra khi đăng nhập!');
            console.error('Error:', error);
        });
}

function logout() {
    var formData = new FormData();
    formData.append('logout', '1');

    fetch('/Jewelry%20Store/pages/process.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);

                location.reload();
            } else {
                alert('Có lỗi xảy ra khi đăng xuất!');
            }
        })
        .catch(error => {
            alert('Có lỗi xảy ra khi đăng xuất!');
            console.error('Error:', error);
        });
}