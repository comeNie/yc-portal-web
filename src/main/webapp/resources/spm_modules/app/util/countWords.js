define(function (require, exports) {
    'use strict';
   var $=require('jquery');
    
   function wordCount(word){
	   if(!word || 0 === word.length) return 0;
       word = word.replace(/^\s+|\s+$/gm,'');
       if(!word || 0 === word.length) return 0;
       var char, i, len = word.length, count = 0;
       var before=false;
       for (i = 0; i < len; ++i){
                 //此处算法为：1.如果是英文字母，则需要看一下字符，直到遇到一个其他语言字符，此时前面字数加1，如果到单词尾也加一
                 //中、日、韩分别区间，三者标点符号为相应区间，都算一个字
                 //英语、法语、俄语、葡萄牙语处理一样，所以这里就不判断了
                 //汉语
                 var char = word.charCodeAt(i);
                 //中文，韩文两个，日文, 全角英文数字符号
	      if ( (char >= 0x4e00 && char <= 0x9fa5) || (char >= 0x3130 && char <= 0x318f) || (char >= 0xac00 && char <= 0xd7a3)
	                          || (char >= 0x0800 && char <= 0x4e00) || (char >= 0xff00 && char <= 0xffef) || (char >= 0x2e80 && char <= 0x2eff)
	                          || (char >= 0x3000 && char <= 0x303f) || (char >= 0x31c0 && char <= 0x31ef)  || (char >= 0x2f00 && char <= 0x2fdf)
	                          || (char >= 0x2ff0 && char <= 0x2fff) || (char >= 0x3100 && char <= 0x312f) || (char >= 0x31a0 && char <= 0x31bf) 
	                          || (char >= 0x3040 && char <= 0x309f) || (char >= 0x30a0 && char <= 0x30ff) || (char >= 0x31f0 && char <= 0x31ff) 
	                          || (char >= 0xac00 && char <= 0xd7af) || (char >= 0x1100 && char <= 0x11ff) || (char >= 0x3130 && char <= 0x318f) 
	                          || (char >= 0x1d300 && char <= 0x1d35f) || (char >= 0x4dc0 && char <= 0x4dff)  || (char >= 0xa000 && char <= 0xa48f) 
	                          || (char >= 0xa490 && char <= 0xa4cf) || (char >= 0x2800 && char <= 0x28ff) || (char >= 0x3200 && char <= 0x32ff) 
	                          || (char >= 0x3300 && char <= 0x33ff) || (char >= 0x2700 && char <= 0x27bf) || (char >= 0x2600 && char <= 0x26ff)
	                          || (char >= 0xfe10 && char <= 0xfe1f) || (char >= 0xfe30 && char <= 0xfe4f)){
	                     if(before){
	                                   ++count;
	                                   before=false;
	                          }
	          ++count;
	       }else{
	                    //说明前面有字母
	         before=true;
	                 }
	                    
	       }          
	  //最后判定一下
	  if(before)
	                          ++count;
	  return count;

   }
    
    exports.count =  function (input) {
      	 var _this= this;
        	
       	 if(!input || 0 === input.length) return 0;
            //start split
            var words=input.split(" ");	
            var total=0;
            
            for(var i=0;i<words.length;i++){
           	 total = total + wordCount(words[i]);   
           	
            }
            console.log(total);
    	     return total;
    	 };
});

