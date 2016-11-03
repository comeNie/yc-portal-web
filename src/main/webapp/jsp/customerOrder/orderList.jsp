<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>我的订单</title>
	<%@ include file="/inc/inc.jsp" %>
</head>
<body>
	<!--头部-->
	<%@ include file="/inc/userTopMenu.jsp" %>
  <!--二级主体-->
  <!--外侧背景-->
  <div class="cloud-container">
  <!--内侧内容区域-->
  <div class="cloud-wrapper">
  	<!--左侧菜单-->
	  <%@ include file="/inc/leftmenu.jsp" %>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">	
  		<!--右侧第二块-->
  		<div class="right-list mt-0">
  			<div class="oder-table">
  				<ul>
  					<li><a href="#"  class="current">全部订单</a></li>
  					<li><a href="#">待支付(4)</a></li>
  					<li><a href="#">翻译中(4)</a></li>
  					<li><a href="#">待确认(4)</a></li>
  					<li><a href="#">待评价(4)</a></li>	
  				</ul>
  			</div>
  			<div id="table-da1">
  			<div class="oder-form-lable mt-20">
  				<ul>
  					<li class="mb-20">
  						<p>订单状态</p>
  						<p><select class="select select-small radius"></select></p>
  						<p>订单时间</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>－</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>翻译内容</p>
  						<p><select class="select select-small radius"></select></p>
  						<p class="iocn-oder"><input type="text" class="int-text int-medium radius pr-30"><i class=" icon-search"></i></p>
  					</li>
  					<li>
  						<p><input type="checkbox" class="checkbox-n" checked="checked">个人</p>
  						<p><input type="checkbox" class="checkbox-n">企业</p>
  					</li>
  				</ul>
  			</div>
  			
  			<div class="right-list-table">
  				<table class="table table-hover table-bg">
                    <thead>
                       <tr>
                            <th width="16.666%">订单主题</th>
                            <th width="16.666%">下单人</th>
                            <th width="16.666%">翻译语言</th>
                            <th width="16.666%">金额（元）</th>
                            <th width="16.666%">状态</th>
                            <th width="16.666%">操作</th>
                      </tr>
               		</thead>
            </table>
  			</div>
  			<div class="right-list-table">
  				<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="确 认">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="延时确认">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="评 价">
                            </td>
						 </tr>
				    </tbody>
            		</table>
  			</div>
		  	<div class="biu-paging paging-large">
			 	<ul>
				     <li class="prev-up"><a href="#"><</a></li>
				     <li class="active"><a href="#">1</a></li>
				     <li><a href="#">2</a></li>
				     <li><a href="#">3</a></li>
				     <li><a href="#">4</a></li>
				     <li><a href="#">5</a></li>
				     <li><a href="#">6</a></li>
				     <li><a href="#">……</a></li>
				     <li><a href="#">100</a></li>
				     <li class="next-down"><a href="#">></a></li>
				     <li>
						<span>到</span>
						<span><input type="text" class="int-verysmall radius"></span>
						<span>页</span>
					</li>
					<li class="taiz"><a href="#">跳转</a></li>
			  	 </ul>
			</div>
  			</div>
  			<div id="table-da2" style="display:none;">
  			<div class="oder-form-lable mt-20">
  				<ul>
  					<li class="mb-20">
  						<p>订单状态</p>
  						<p><select class="select select-small radius"></select></p>
  						<p>订单时间</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>－</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>翻译内容</p>
  						<p><select class="select select-small radius"></select></p>
  						<p class="iocn-oder"><input type="text" class="int-text int-medium radius pr-30"><i class=" icon-search"></i></p>
  					</li>
  					<li>
  						<p><input type="checkbox" class="checkbox-n" checked="checked">个人</p>
  						<p><input type="checkbox" class="checkbox-n">企业</p>
  					</li>
  				</ul>
  			</div>
  			
  			<div class="right-list-table">
  				<table class="table table-hover table-bg">
                    <thead>
                       <tr>
                            <th width="16.666%">订单主题</th>
                            <th width="16.666%">下单人</th>
                            <th width="16.666%">翻译语言</th>
                            <th width="16.666%">金额（元）</th>
                            <th width="16.666%">状态</th>
                            <th width="16.666%">操作</th>
                      </tr>
               		</thead>
            </table>
  			</div>
  			<div class="right-list-table">
  				<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="确 认">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="延时确认">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>

                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="评 价">
                            </td>
						 </tr>
				    </tbody>
            		</table>
  			</div>
  			<div class="biu-paging paging-large">
			 	<ul>
				     <li class="prev-up"><a href="#"><</a></li>
				     <li class="active"><a href="#">1</a></li>
				     <li><a href="#">2</a></li>
				     <li><a href="#">3</a></li>
				     <li><a href="#">4</a></li>
				     <li><a href="#">5</a></li>
				     <li><a href="#">6</a></li>
				     <li><a href="#">……</a></li>
				     <li><a href="#">100</a></li>
				     <li class="next-down"><a href="#">></a></li>
				     <li>
						<span>到</span>
						<span><input type="text" class="int-verysmall radius"></span>
						<span>页</span>
					</li>
					<li class="taiz"><a href="#">跳转</a></li>
			  	 </ul>
			</div>
  			</div>
  			<div id="table-da3" style="display:none;">
  			<div class="oder-form-lable mt-20">
  				<ul>
  					<li class="mb-20">
  						<p>订单状态</p>
  						<p><select class="select select-small radius"></select></p>
  						<p>订单时间</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>－</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>翻译内容</p>
  						<p><select class="select select-small radius"></select></p>
  						<p class="iocn-oder"><input type="text" class="int-text int-medium radius pr-30"><i class=" icon-search"></i></p>
  					</li>
  					<li>
  						<p><input type="checkbox" class="checkbox-n" checked="checked">个人</p>
  						<p><input type="checkbox" class="checkbox-n">企业</p>
  					</li>
  				</ul>
  			</div>
  			
  			<div class="right-list-table">
  				<table class="table table-hover table-bg">
                    <thead>
                       <tr>
                            <th width="16.666%">订单主题</th>
                            <th width="16.666%">下单人</th>
                            <th width="16.666%">翻译语言</th>
                            <th width="16.666%">金额（元）</th>
                            <th width="16.666%">状态</th>
                            <th width="16.666%">操作</th>
                      </tr>
               		</thead>
            </table>
  			</div>
  			<div class="right-list-table">
  				<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="确 认">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="延时确认">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>

                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="评 价">
                            </td>
						 </tr>
				    </tbody>
            		</table>
  			</div>
  			<div class="biu-paging paging-large">
			 	<ul>
				     <li class="prev-up"><a href="#"><</a></li>
				     <li class="active"><a href="#">1</a></li>
				     <li><a href="#">2</a></li>
				     <li><a href="#">3</a></li>
				     <li><a href="#">4</a></li>
				     <li><a href="#">5</a></li>
				     <li><a href="#">6</a></li>
				     <li><a href="#">……</a></li>
				     <li><a href="#">100</a></li>
				     <li class="next-down"><a href="#">></a></li>
				     <li>
						<span>到</span>
						<span><input type="text" class="int-verysmall radius"></span>
						<span>页</span>
					</li>
					<li class="taiz"><a href="#">跳转</a></li>
			  	 </ul>
			</div>
  			</div>
  			<div id="table-da4" style="display:none;">
  			<div class="oder-form-lable mt-20">
  				<ul>
  					<li class="mb-20">
  						<p>订单状态</p>
  						<p><select class="select select-small radius"></select></p>
  						<p>订单时间</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>－</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>翻译内容</p>
  						<p><select class="select select-small radius"></select></p>
  						<p class="iocn-oder"><input type="text" class="int-text int-medium radius pr-30"><i class=" icon-search"></i></p>
  					</li>
  					<li>
  						<p><input type="checkbox" class="checkbox-n" checked="checked">个人</p>
  						<p><input type="checkbox" class="checkbox-n">企业</p>
  					</li>
  				</ul>
  			</div>
  			
  			<div class="right-list-table">
  				<table class="table table-hover table-bg">
                    <thead>
                       <tr>
                            <th width="16.666%">订单主题</th>
                            <th width="16.666%">下单人</th>
                            <th width="16.666%">翻译语言</th>
                            <th width="16.666%">金额（元）</th>
                            <th width="16.666%">状态</th>
                            <th width="16.666%">操作</th>
                      </tr>
               		</thead>
            </table>
  			</div>
  			<div class="right-list-table">
  				<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="确 认">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="延时确认">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>

                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="评 价">
                            </td>
						 </tr>
				    </tbody>
            		</table>
  			</div>
  			<div class="biu-paging paging-large">
			 	<ul>
				     <li class="prev-up"><a href="#"><</a></li>
				     <li class="active"><a href="#">1</a></li>
				     <li><a href="#">2</a></li>
				     <li><a href="#">3</a></li>
				     <li><a href="#">4</a></li>
				     <li><a href="#">5</a></li>
				     <li><a href="#">6</a></li>
				     <li><a href="#">……</a></li>
				     <li><a href="#">100</a></li>
				     <li class="next-down"><a href="#">></a></li>
				     <li>
						<span>到</span>
						<span><input type="text" class="int-verysmall radius"></span>
						<span>页</span>
					</li>
					<li class="taiz"><a href="#">跳转</a></li>
			  	 </ul>
			</div>
  			</div>
  			<div id="table-da5" style="display:none;">
  			<div class="oder-form-lable mt-20">
  				<ul>
  					<li class="mb-20">
  						<p>订单状态</p>
  						<p><select class="select select-small radius"></select></p>
  						<p>订单时间</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>－</p>
  						<p><input type="text" class="int-text int-small radius"></p>
  						<p>翻译内容</p>
  						<p><select class="select select-small radius"></select></p>
  						<p class="iocn-oder"><input type="text" class="int-text int-medium radius pr-30"><i class=" icon-search"></i></p>
  					</li>
  					<li>
  						<p><input type="checkbox" class="checkbox-n" checked="checked">个人</p>
  						<p><input type="checkbox" class="checkbox-n">企业</p>
  					</li>
  				</ul>
  			</div>
  			
  			<div class="right-list-table">
  				<table class="table table-hover table-bg">
                    <thead>
                       <tr>
                            <th width="16.666%">订单主题</th>
                            <th width="16.666%">下单人</th>
                            <th width="16.666%">翻译语言</th>
                            <th width="16.666%">金额（元）</th>
                            <th width="16.666%">状态</th>
                            <th width="16.666%">操作</th>
                      </tr>
               		</thead>
            </table>
  			</div>
  			<div class="right-list-table">
  				<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="确 认">
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="延时确认">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>

                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
                            </td>
						 </tr>
				    </tbody>
            		</table>
            		<table class="table  table-bg tb-border mb-20">
                    <thead>
                       <tr>
                            <th colspan="6" class="text-l">
                            		<div class="table-thdiv">
                            			<p>2015-04-07 09:53:51</p>
                            			<p>订单号：<span>198409857093246</span></p>
                            			<p class="right">剩余2天23小时59分钟</p>
                            		</div>
                            </th>
                      </tr>
               		</thead>
                    <tbody>
						<tr class="width-16">
                            <td>我要翻译一段话，不超过15……</td>
                            <td>admin</td>
                            <td>中文→西班牙语</td>
                            <td>1000.00</td>
                            <td>待支付</td>
                            <td>
                            	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10" value="评 价">
                            </td>
						 </tr>
				    </tbody>
            		</table>
  			</div>
  			<div class="biu-paging paging-large">
			 	<ul>
				     <li class="prev-up"><a href="#"><</a></li>
				     <li class="active"><a href="#">1</a></li>
				     <li><a href="#">2</a></li>
				     <li><a href="#">3</a></li>
				     <li><a href="#">4</a></li>
				     <li><a href="#">5</a></li>
				     <li><a href="#">6</a></li>
				     <li><a href="#">……</a></li>
				     <li><a href="#">100</a></li>
				     <li class="next-down"><a href="#">></a></li>
				     <li>
						<span>到</span>
						<span><input type="text" class="int-verysmall radius"></span>
						<span>页</span>
					</li>
					<li class="taiz"><a href="#">跳转</a></li>
			  	 </ul>
			</div>
  			</div>
  		
  		</div>	
  	</div>
  	
  	
  </div>
  		
  </div>
<script type="text/javascript" src="scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="scripts/modular/frame.js"></script>
</body>
</html>
