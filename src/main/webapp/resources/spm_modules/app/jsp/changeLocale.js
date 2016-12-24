function changeLang(localeEl){
    // var toLang = localeEl.value;
    var toLang = localeEl;
    if (window.console){
        console.log("the new lange is "+toLang);
    }
    var nowUrl = window.location.href;
    var lInd = nowUrl.indexOf("lang=");
    //已存在
    if (lInd>0){
        var i = nowUrl.indexOf("&",lInd);
        var endStr = i>0?nowUrl.substring(i):"";
        nowUrl = nowUrl.substring(0,lInd)+"lang="+toLang+endStr;
    }//不存在
    else if(nowUrl.indexOf("?")>0){
        nowUrl = nowUrl + "&lang="+toLang;
    }else {
        nowUrl = nowUrl + "?lang="+toLang;
    }

    window.location.replace(nowUrl);//刷新当前页面
}