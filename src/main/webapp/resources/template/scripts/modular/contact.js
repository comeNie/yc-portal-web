$(function () {
    
    //鼠标移入事件
    $('[contact-way]').mouseover(function(){
        $(this).find('.right-btn').removeClass('undis');
        $(this).siblings().find('.right-btn').addClass('undis');
    });
    //鼠标移出事件
    $('[contact-way]').mouseout(function(){
        $(this).find('.right-btn').addClass('undis');
    });
});