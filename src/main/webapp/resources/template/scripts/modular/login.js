$(function(){

  // 切换登录方式
  $(document).on('click', '#change-login', function(){
    // 手机登录或者普通登录
    if($(this).hasClass('phone')){
      $('.login-form').css({
        'transform':'translateX(0)'
      });
      $('.login-form-wrap').height('388');
      $(this).removeClass('phone').find('span').text('手机快速登录');
      $(this).find('.icon').html('&#xe613;');
    }else{
      $('.login-form').css({
        'transform':'translateX(-400px)'
      });
      $('.login-form-wrap').height('492');
      $(this).addClass('phone').find('span').text('普通登录');
      $(this).find('.icon').html('&#xe64c;');
    }
  })








});
