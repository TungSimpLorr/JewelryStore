
$(document).ready(function () {

    $('.search-box').hide();
    $('#cart-search-icon').click(function (e) {
        e.preventDefault();
        $('.search-box').slideToggle(500);

    });

    $('.productbar').hide();
    $('#product-option').click(function (e) {
        e.preventDefault();
        $('.productbar').slideToggle(1000);
    });

    const trangchinh = document.getElementsByClassName('container')[0];
    const trangcontact = document.getElementsByClassName('contact-page')[0];
    $('.basket').hide();
    $('#cart-shopping-icon').click(function (e) {
        e.preventDefault();
        $('.basket').slideDown();
        if (trangchinh) trangchinh.style.display = "none";
        if (trangcontact) trangcontact.style.display = "none";
    });
    $('#exit-icon').click(function (e) {
        e.preventDefault();
        $('.basket').slideUp();
        if (trangchinh) trangchinh.style.display = "block";
        if (trangcontact) trangcontact.style.display = "block";
    });

});


function themsanphamvaogio()
{
  
    var id_san_pham = document.querySelector('input[name="id_san_pham"]').value;
    var so_luong = document.querySelector('input[name="so_luong"]').value;
    var formData = new FormData();

    formData.append('themvaogiohang',' 1');
    formData.append('id_san_pham', id_san_pham);
    formData.append('so_luong', so_luong);

    fetch('cart.php', {
        method: 'POST',
        body: formData
    })

    .then(response => response.text())
    .then(data => {
      
        alert('Sản phẩm đã được thêm vào giỏ hàng!');
        window.location.href = '../pages/cart.php';
        const capnhatsodonhang = document.getElementById('update-number-cart')[0];
        capnhatsodonhang += soluong;
        console.log(data); 
    })

}
