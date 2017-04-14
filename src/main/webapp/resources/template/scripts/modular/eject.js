//提示弹出框 
jQuery(document).ready(function($) {
	$('#recharge-popo').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#rechargepop').slideDown(100);
	})
	$('#completed').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#rechargepop').slideUp(200);
	})
	$('#close-completed').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#rechargepop').slideUp(200);
	})
})

//译员弹出框 
jQuery(document).ready(function($) {
	$('#tran-popo').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#tran').slideDown(100);
	})
	$('#tran-determine').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#tran').slideUp(200);
	})
	$('#tran-close').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#tran').slideUp(200);
	})
})

//订单大厅弹出框 
jQuery(document).ready(function($) {
	$('#receive-btn').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#receive').slideDown(100);
	})
	$('#receive-determine').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#receive').slideUp(200);
	})
	$('#receive-close').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#receive').slideUp(200);
	})
})

//安全设置有 
jQuery(document).ready(function($) {
	$('#password-btn').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#modify-password').slideDown(100);
	})
	$('#modify-determine').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#modify-password').slideUp(200);
	})
	$('#modify-close').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#modify-password').slideUp(200);
	})
})
//评价 
jQuery(document).ready(function($) {
	$('#evaluate-btn').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#evaluate-password').slideDown(100);
	})
	$('#evaluate-determine').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#evaluate-password').slideUp(200);
	})
})
//提交
jQuery(document).ready(function($) {
	$('#submit-btn').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#sub-order').slideDown(100);
	})
	$('#sub-determine').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#sub-order').slideUp(200);
	})
	$('#sub-cancel').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#sub-order').slideUp(200);
	})
})
//新增联系方式弹出框 
jQuery(document).ready(function($) {
	$('#add-person').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#add-msg').slideDown(100);
	})
	$('#add-determine').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#add-msg').slideUp(200);
	})
	$('#add-cancel').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#add-msg').slideUp(200);
	})
})
//编辑联系方式弹出框 
jQuery(document).ready(function($) {
	$('[edit]').click(function(){
	$('[eject-mask]').fadeIn(100);
	$('[edit-msg]').slideDown(100);
	})
	$('[edit-determine]').click(function(){
	$('[eject-mask]').fadeOut(200);
	$('[edit-msg]').slideUp(200);
	})
	$('[edit-cancel]').click(function(){
	$('[eject-mask]').fadeOut(200);
	$('[edit-msg]').slideUp(200);
	})
})

//删除弹出框 
jQuery(document).ready(function($) {
	$('[delete-btn]').click(function(){
	$('[eject-mask]').fadeIn(100);
	$('[delete-dlog]').slideDown(100);
	})
	$('[completed]').click(function(){
	$('[eject-mask]').fadeOut(200);
	$('[delete-dlog]').slideUp(200);
	})
	$('[cancel]').click(function(){
	$('[eject-mask]').fadeOut(200);
	$('[delete-dlog]').slideUp(200);
	})
})

//保存成功弹出框
jQuery(document).ready(function($) {
	$('[setting-save-btn]').click(function(){
	$('#setting-mask').fadeIn(100);
	$('#setting-dialog').slideDown(100);
	})
	$('#setting-save-confirm').click(function(){
	$('#setting-mask').fadeOut(200);
	$('#setting-dialog').slideUp(200);
	})
	$('#setting-save-cancel').click(function(){
	$('#setting-mask').fadeOut(200);
	$('#setting-dialog').slideUp(200);
	})
})
jQuery(document).ready(function($) {
	$('[setting-save-btn1]').click(function(){
	$('#setting-mask1').fadeIn(100);
	$('#setting-dialog1').slideDown(100);
	})
	$('#setting-save-confirm1').click(function(){
	$('#setting-mask1').fadeOut(200);
	$('#setting-dialog1').slideUp(200);
	})
	$('#setting-save-cancel1').click(function(){
	$('#setting-mask1').fadeOut(200);
	$('#setting-dialog1').slideUp(200);
	})
})
//删除教育经历弹框
jQuery(document).ready(function($) {
	$('[confirm-step2-educate]').click(function(){
	$('#confirm-step2-educate-mask').fadeIn(100);
	$('#confirm-step2-educate').slideDown(100);
	})
	$('#confirm-step2-educate-confirm').click(function(){
	$('#confirm-step2-educate-mask').fadeOut(200);
	$('#confirm-step2-educate').slideUp(200);
	})
	$('#confirm-step2-educate-cancel').click(function(){
	$('#confirm-step2-educate-mask').fadeOut(200);
	$('#confirm-step2-educate').slideUp(200);
	})
})

//删除语言弹框
jQuery(document).ready(function($) {
	$('[confirm-step2-language]').click(function(){
	$('#confirm-step2-language-mask').fadeIn(100);
	$('#confirm-step2-language').slideDown(100);
	})
	$('#confirm-step2-language-confirm').click(function(){
	$('#confirm-step2-language-mask').fadeOut(200);
	$('#confirm-step2-language').slideUp(200);
	})
	$('#confirm-step2-language-cancel').click(function(){
	$('#confirm-step2-language-mask').fadeOut(200);
	$('#confirm-step2-language').slideUp(200);
	})
})

//译员不能为空
jQuery(document).ready(function($) {
	$('[confirm-step2-empty]').click(function(){
	$('#confirm-step2-empty-mask').fadeIn(100);
	$('#confirm-step2-empty').slideDown(100);
	})
	$('#confirm-step2-empty-confirm').click(function(){
	$('#confirm-step2-empty-mask').fadeOut(200);
	$('#confirm-step2-empty').slideUp(200);
	})
})

//分配译员弹窗
jQuery(document).ready(function($) {
	$('[assign-popo]').click(function(){
	$('#eject-mask').fadeIn(100);
	$('[assign-tran-dialog]').slideDown(100);
	})
	$('#tran-determine').click(function(){
	$('#eject-mask').fadeOut(200);
	$('[assign-tran-dialog]').slideUp(200);
	})
	$('#tran-close').click(function(){
	$('#eject-mask').fadeOut(200);
	$('[assign-tran-dialog]').slideUp(200);
	})
})

//添加语言弹窗
jQuery(document).ready(function($) {
	$('[add-language]').click(function(){
	$('#eject-mask').fadeIn(100);
	$('[add-language-dialog]').slideDown(100);
	})
	$('#tran-determine').click(function(){
	$('#eject-mask').fadeOut(200);
	$('[add-language-dialog]').slideUp(200);
	})
	$('#tran-close').click(function(){
	$('#eject-mask').fadeOut(200);
	$('[add-language-dialog]').slideUp(200);
	})
})