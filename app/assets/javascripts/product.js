$(function(){
  $('.imain__main__link__image__ulist').slick({
    autoplay:true,
    autoplaySpeed:5000,
    arrows: true,
    dots: true,
    speed: 1000,
    appendArrows: $("#btn1"),
    appendDots: $(".imain__main__link__image__bottom"),
    prevArrow: '<i class="fa fa-angle-left arrow arrow-left"id="left__icon"></i>',
    nextArrow: '<i class="fa fa-angle-right arrow arrow-right"id="right__icon"></i>'
  });  
});