$(document).ready(function(){
  		$("#all").bind("click",function(){
  			$("input[name='check']").prop("checked",this.checked);
  		});

  		$("#delAll").bind("click",function(){
  			$("input[name='check']:checked").each(function(index,domEle){
  				$(this).parent().parent().remove();
  			})
  		});

      $("input:checkbox").bind("click",function(){
        if ($("input[name='check']").not("input:checked").size()  <= 0) {
          console.log("abc");
          $("#all").prop("checked",true);
        }else{
          $("#all").prop('checked',false);
        }
      })

  		$("#readMore").bind("click",function(){
  			$("#newMsg").attr('src',"images/message-read.png");
  			if($("#detail").css("display") == "none"){
  				$("#detail").removeClass("msg-detail");
  			}else{
  				$("#detail").addClass("msg-detail");
  			}
  		})
  	});
  	