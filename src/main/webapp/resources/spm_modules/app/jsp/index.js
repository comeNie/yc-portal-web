
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
