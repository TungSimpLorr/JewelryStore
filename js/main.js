$(document).ready(function(){
    $('.search-box').hide();
    $('#cart-search-icon').click(function(){
        $('.search-box').slideToggle(300);
    });
    
    $('.productbar').hide();
    $('#product-option').click(function(e){
        e.preventDefault(); 
        $('.productbar').slideToggle(300);
    });
    
     $(".product-type-list").owlCarousel({
      items: 4, 
      loop: true, 
      margin: 10, 
      dots: true, 
      autoplay: true,
      autoplayTimeout: 2000,
      autoplayHoverPause: true
    });

     $(".img-banner").owlCarousel({
      items: 1, 
      loop: true, 
      dots: true, 
      autoplay: true,
      autoplayTimeout: 1000,
      autoplayHoverPause: true
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

 


