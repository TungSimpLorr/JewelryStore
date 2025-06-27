
// jquery 
$(document).ready(function(){
    
    $('.search-box').hide();
    $('#cart-search-icon').click(function(e){
        e.preventDefault();
        $('.search-box').slideToggle(500);

    });
    
    $('.productbar').hide();
    $('#product-option').click(function(e){
        e.preventDefault(); 
        $('.productbar').slideToggle(1000);
    });
    
    const trangchinh = document.getElementsByClassName('container')[0];
    $('.basket').hide();
    $('#cart-shopping-icon').click(function(e){
          e.preventDefault();
        $('.basket').slideDown();
         trangchinh.style.display="none";
    });
    $('#exit-icon').click(function (e){
          e.preventDefault();
        $('.basket').slideUp();
        trangchinh.style.display="block";
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

