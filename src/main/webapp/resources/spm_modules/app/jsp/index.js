
function srcMove(){
    var yiwen = $("#int-before").val();
    if(yiwen){
        $("#srcOld").hide();
        $("#srcNew").show();
    }
}

function srcOut(){
    $("#srcOld").show();
    $("#srcNew").hide();
}

function textCounter(field, countfield, maxlimit) {
    // 函数，3个参数，表单名字，表单域元素名，限制字符；
    if (field.value.length > maxlimit){
        //如果元素区字符数大于最大字符数，按照最大字符数截断；
        field.value = field.value.substring(0, maxlimit);
    }
    //在记数区文本框内显示剩余的字符数；
    document.getElementById(countfield).innerHTML=field.value.length;

}

function tgtMove(id){
    $("#"+id).addClass("b_cur");
    $("#src_"+id).addClass("b_cur");

    //
    $("#src_"+id).focus();
    var t = $("#src_"+id).offset().top - $("#srcNew").offset().top;
    $("#srcNew").scrollTop(t);
}
function tgtOut(id){
    // $("#srcNew").scrollTop($("#src_"+id).offset().top);
    $("#"+id).removeClass("b_cur");
    $("#src_"+id).removeClass("b_cur");

}
