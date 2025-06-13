
$(document).ready(function(){

    $('.search-box').hide();
    $('#cart-search-icon').click(function(){
         $('.search-box').slideToggle(300);

    });

    $('.productbar').hide();
    $('#product-option').click(function(){
        $('.productbar').slideToggle(300);
    });


});

function hiensidebar()
{
   
    const sidebar = document.getElementsByClassName('sidebar')[0];
        if(sidebar.style.display===" "|| sidebar.style.display==="none")
        {
            sidebar.style.display="flex";
        }
        else
        {
            sidebar.style.display="none";
        }

    };

    function changebanner() {
    const banner = document.getElementsByClassName('box-banner')[0];
    const sidebar = document.getElementsByClassName('sidebar')[0];
    sidebarnow = sidebar.style.display;

    if (sidebarnow) {
        if (sidebarnow.style.display === 'none') {
            banner.style.width = '100%';
        } else {
            banner.style.width = '70%';
        }
    }
}
