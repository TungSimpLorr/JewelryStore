$(document).ready(function () {

    setTimeout(function() {
        checkLoginStatus();
    }, 100);

    $('.search-box').hide();
    $('#cart-search-icon').click(function (e) {
        e.preventDefault();
        $('.search-box').slideToggle(500);

    });

    $('#search-input').on('input', function () {
        let keyword = $(this).val().trim();
        if (keyword.length === 0) {
            $('#search-suggestions').hide();
            return;
        }
        $.ajax({
            url: '/Jewelry Store/pages/search.php',
            method: 'GET',
            data: { q: keyword },
            dataType: 'json',
            success: function (data) {
                let html = '';
                if (data.length > 0) {
                    data.forEach(function (item) {
                        html += `<div class='suggestion-item' style='padding:8px;cursor:pointer;border-bottom:1px solid #eee;' onclick=\"window.location.href='/Jewelry Store/pages/product-detail.php?id=${item.id}'\">`;
                        html += `<img src='${item.image}' style='width:40px;height:40px;object-fit:cover;margin-right:8px;vertical-align:middle;'>`;
                        html += `<span>${item.name}</span>`;
                        html += '</div>';
                    });
                } else {
                    html = "<div style='padding:8px;'>Không tìm thấy sản phẩm phù hợp</div>";
                }
                $('#search-suggestions').html(html).show();
            },
            error: function () {
                $('#search-suggestions').hide();
            }
        });
    });

    $(document).on('click', function (e) {
        if (!$(e.target).closest('.search-box').length) {
            $('#search-suggestions').hide();
        }
    });


    $('.productbar').hide();
    $('#product-option').click(function (e) {
        e.preventDefault();
        $('.productbar').slideToggle(1000);
    });

    const trangchinh = document.getElementsByClassName('container')[0];
    const trangcontact = document.getElementsByClassName('contact-page')[0];
    const trangproduct = document.getElementsByClassName('container-product')[0];
    const trangcart = document.getElementsByClassName('container')[0];
    $('.basket').hide();
    $('#cart-shopping-icon').click(function (e) {
        e.preventDefault();
        $('.basket').slideDown();
        if (trangchinh) trangchinh.style.display = "none";
        if (trangcontact) trangcontact.style.display = "none";
        if (trangproduct) trangproduct.style.display = "none";

    });
    $('#exit-icon').click(function (e) {
        e.preventDefault();
        $('.basket').slideUp();
        if (trangchinh) trangchinh.style.display = "block";
        if (trangcontact) trangcontact.style.display = "block";
        if (trangproduct) trangproduct.style.display = "block";

    });

    $('.mini-box .img-mini-box img').click(function () {
        var src = $(this).attr('src');
        $('.img-box img').attr('src', src);
    });

});



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

function themsanphamvaogio() {

    var id_san_pham = document.querySelector('input[name="id_san_pham"]').value;
    var so_luong = document.querySelector('input[name="so_luong"]').value;
    var formData = new FormData();

    formData.append('themvaogiohang', ' 1');
    formData.append('id_san_pham', id_san_pham);
    formData.append('so_luong', so_luong);

    fetch('cart.php', {
        method: 'POST',
        body: formData
    })

        .then(response => response.text())
        .then(data => {

            alert('Sản phẩm đã được thêm vào giỏ hàng!');
             location.reload();
            console.log(data);
        })

}

function hiennhapthongtinkhachhang() {
    document.getElementById('checkinfor').style.display = 'flex';
}

function dongthongtinkhachhang() {
    document.getElementById('checkinfor').style.display = 'none';
}

