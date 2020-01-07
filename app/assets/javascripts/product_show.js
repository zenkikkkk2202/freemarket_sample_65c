$(function() {
  $(function() {
    $('img.box__container__main__photo__all__small__list__image').click(function(){
      var ImgSrc = $(this).attr("src");
      $("img#mainphoto").attr({src:ImgSrc});
      $("img#mainphoto").hide();
      $("img#mainphoto").fadeIn();
      return false;
    });
    $('img.box__container__main__photo__all__small__list__image').mouseover(function(){
      var ImgSrc = $(this).attr("src");
      $("img#mainphoto").attr({src:ImgSrc});
      $("img#mainphoto").hide();
      $("img#mainphoto").fadeIn();
        return false;
    });
  });
})