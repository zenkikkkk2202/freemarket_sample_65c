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

  $('#scroll_btn1').click(function(){
    $('html, body').animate({scrollTop:650});
  })
  $('#scroll_btn2').click(function(){
    $('html, body').animate({scrollTop:1400});
  })
  $('#scroll_btn3').click(function(){
    $('html, body').animate({scrollTop:2150});
  })
  $('#scroll_btn4').click(function(){
    $('html, body').animate({scrollTop:2850});
  })
  $('#scroll_btn5').click(function(){
    $('html, body').animate({scrollTop:3750});
  })
  $('#scroll_btn6').click(function(){
    $('html, body').animate({scrollTop:3750});
  })

});