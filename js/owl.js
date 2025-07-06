$(document).ready(function(){

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
    
    $(".product-type-list-1").owlCarousel({
      items: 4,
      loop: true, 
      margin: 10, 
      dots: true, 
      autoplay: true,
      autoplayTimeout: 10000,
      autoplayHoverPause: true 
    });
});