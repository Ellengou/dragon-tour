<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- bootstrap-datetimepicker -->
<link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
<!-- validator -->
<link href="<%=request.getContextPath()%>/bootstrap/plugin/validator/popover.css" rel="stylesheet">
</head>
<body>
	<div id="page-wrapper" style="padding: 0 15px;">
		<div class="row">
			<div class="col-lg-12">
				<br>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="myForm">
									<div class="row">
										<div class="col-xs-12">
											<div class="input-group">
												<span class="input-group-addon">企业类型</span> 
												<!-- 
												<label class="checkbox-inline">
											      <input type="radio" name="compType" id="compType3" value="2" onclick="onclickCompType('2');"> 个人
											   </label>
											    -->
												<label class="checkbox-inline">
											      <input type="radio" name="compType" id="compType1" value="0" onclick="onclickCompType('0');"> 个体户
											   </label>
											   <label class="checkbox-inline">
											      <input type="radio" name="compType" id="compType2" value="1" checked="checked" onclick="onclickCompType('1');"> 公司
											   </label>
											</div>
										</div>
									</div>
									<div id="gerenShow" style="display: none">
										<br>
										<div class="row">
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">姓名</span> 
													<input type="text" class="form-control" id="grLealPerson" name="grLealPerson">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">身份证</span> 
													<input type="text" class="form-control" id="grLealIdCard" name="grLealIdCard">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">手机</span> 
													<input type="text" class="form-control" id="grLealPhone" name="grLealPhone">
												</div>
											</div>
										</div>
									</div>
									<div id="gerenHide">
										<br>
										<div class="row">
											<div class="col-xs-6">
												<div class="input-group">
													<span class="input-group-addon">统一社会信用代码</span> 
													<input type="text" class="form-control" id="creditCode" name="creditCode" onchange="checkCreditCode();">
												</div>
											</div>
											<div class="col-xs-6">
												<div class="input-group">
													<span class="input-group-addon">公司名称</span> 
													<input type="text" class="form-control" id="compName" name="compName">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">法人代表</span> 
													<input type="text" class="form-control" id="lealPerson" name="lealPerson">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">法人身份证</span> 
													<input type="text" class="form-control" id="lealIdCard" name="lealIdCard">
												</div>
											</div>
											<div class="col-xs-3">
												<div id="lealIdCardValidId" class="input-group date form_datetime col-md-12">
								                	<span class="input-group-addon">身份证有效期</span>
								                    <input id="lealIdCardValidDate" name="lealIdCardValidDate" class="form-control" size="16" type="text" value="" readonly>
													<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
													<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
								                </div>
											</div>
											<div class="col-xs-1">
												<div class="input-group">
													<label class="checkbox-inline">
														<input name="lealIdCardValidTypeCheck" id="lealIdCardValidTypeCheck" type="checkbox" onclick="lealIdCardValidTypeCheckClick();">长期
													</label>
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">法人手机</span> 
													<input type="text" class="form-control" id="lealPhone" name="lealPhone">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">代理人</span> 
													<input type="text" class="form-control" id="agentPerson" name="agentPerson">
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">代理人手机</span> 
													<input type="text" class="form-control" id="agentPhone" name="agentPhone">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">省市区</span> 
													<input type="text" class="form-control" id="areaCodeName" name="areaCodeName" readonly="readonly" onclick="getArea('areaCode','areaCodeName');">
													<input type="hidden" id="areaCode" name="areaCode">
												</div>
											</div>
											<div class="col-xs-8">
												<div class="input-group">
													<span class="input-group-addon">详细地址</span> 
													<input type="text" class="form-control" id="address" name="address">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-3">
												<div id="businessTermId" class="input-group date form_datetime col-md-12">
								                	<span class="input-group-addon">营业期限</span>
								                    <input id="businessTermDate" name="businessTermDate" class="form-control" size="16" type="text" value="" readonly>
													<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
													<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
								                </div>
											</div>
											<div class="col-xs-1">
												<div class="input-group">
													<label class="checkbox-inline">
														<input name="businessTermTypeCheck" id="businessTermTypeCheck" type="checkbox" onclick="businessTermTypeCheckClick();">长期
													</label>
												</div>
											</div>
											<div class="col-xs-4">
												<div class="input-group">
													<span class="input-group-addon">登录名</span> 
													<input type="text" class="form-control" id="loginName" name="loginName">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-12">
												<div class="input-group" id="compTradeData">
													
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-12">
												<div class="input-group">
													<span class="input-group-addon">经营范围</span> 
													<input type="text" class="form-control" id="businessScope">
												</div>
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-6">
											<div class="input-group">
												<span class="input-group-addon">法人身份正面照</span> 
												<input type="file" class="form-control dataFile" id="lealFront" name="lealFront">
											</div>
										</div>
										<div class="col-xs-6">
											<div class="input-group">
												<span class="input-group-addon">法人身份反面照</span> 
												<input type="file" class="form-control dataFile" id="lealBack" name="lealBack">
											</div>
										</div>
									</div>
									<br>
									<div id="gerenImgHide">
										<br>
										<div class="row">
											<div class="col-xs-6">
												<div class="input-group">
													<span class="input-group-addon">组织机构照片</span> 
													<input type="file" class="form-control dataFile" id="organization" name="organization">
												</div>
											</div>
											<div class="col-xs-6">
												<div class="input-group">
													<span class="input-group-addon">营业执照照片</span> 
													<input type="file" class="form-control dataFile" id="businessLicense" name="businessLicense">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-6">
												<div class="input-group">
													<span class="input-group-addon">代理人身份正面照</span> 
													<input type="file" class="form-control dataFile" id="agentFront" name="agentFront">
												</div>
											</div>
											<div class="col-xs-6">
												<div class="input-group">
													<span class="input-group-addon">代理人身份反面照</span> 
													<input type="file" class="form-control dataFile" id="agentBack" name="agentBack">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-xs-6">
												<div class="input-group">
													<span class="input-group-addon">企业委托书</span> 
													<input type="file" class="form-control dataFile" id="proxy" name="proxy">
												</div>
											</div>
										</div>
									</div>
									<hr>
									<div class="row" align="center">
										<div class="col-xs-12">
											<input type="submit" class="btn btn-primary" value="确定" />
											<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
	<!-- bootstrap-datetimepicker -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
    <!-- validate -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/ga.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.bootstrap.popover.js"></script>
    <!-- ajaxfileupload -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	<script>
	var tableId;
	var suppId;
	var jsonData = {};
	$('.dataFile').each(function(){
		var $this = $(this);
		var id = $this.attr("id");
		$this.fileinput({
	        language: 'zh',
	        showUpload:false,
	        showPreview:true,
	        uploadUrl: '<%=request.getContextPath()%>/pics/supplier',
	        allowedFileExtensions : ['jpg', 'png','gif'],
	        uploadExtraData:function(){
	        	return {'type':id,'tableId':tableId,'suppId':suppId}
	        }
	    })
		
	});
		$(document).ready(function() {
			var businessData = $.parseJSON('${businessList}');
	        var str = '<span class="input-group-addon">公司行业</span>&nbsp;&nbsp;&nbsp;';
	        for (var i = 0; i < businessData.length; i++) {
				str = str + '<label class="checkbox-inline"><input type="checkbox" name="compTrade" id="compTrade' + i + '" value="'+ businessData[i].id + '">' + businessData[i].name + ' </label>';
			}
			$("#compTradeData").html(str);
			
			$('#lealIdCardValidId').datetimepicker({
	    		minView: "month", //选择日期后，不会再跳转去选择时分秒 
	    		format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
	    		language: 'zh-CN', //汉化 
	    		autoclose:true //选择日期后自动关闭 
	        });
			
			$('#businessTermId').datetimepicker({
	    		minView: "month", //选择日期后，不会再跳转去选择时分秒 
	    		format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
	    		language: 'zh-CN', //汉化 
	    		autoclose:true //选择日期后自动关闭 
	        });
			
			$.validator.addMethod("phone",function(value,element,params){
				if(value != null && value != ''){
					if(!(/^1[3|4|5|7|8]\d{9}$/.test(value))){
						return false;
				    }else{
				    	return true;
				    }
				}else{
					return true;
				}
			},"请输入正确的手机号码");
			
			$.validator.addMethod("idCard",function(value,element,params){
				if(!isIdCardNo(value)){
					return false;
			    }else{
			    	return true;
			    }
			},"请输入正确的身份证号码");
			
			//身份证号码的验证规则
			function isIdCardNo(num){
				//if (isNaN(num)) {alert("输入的不是数字！"); return false;}
				var len = num.length, re;
				if (len == 15)
					re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{2})(\w)$/);
				else if (len == 18)
					re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/);
				else {
					//alert("输入的数字位数不对。");
					return false;
				}
				var a = num.match(re);
				if (a != null)
				{
					if (len==15)
					{
						var D = new Date("19"+a[3]+"/"+a[4]+"/"+a[5]);
						var B = D.getYear()==a[3]&&(D.getMonth()+1)==a[4]&&D.getDate()==a[5];
					}
					else
					{
						var D = new Date(a[3]+"/"+a[4]+"/"+a[5]);
						var B = D.getFullYear()==a[3]&&(D.getMonth()+1)==a[4]&&D.getDate()==a[5];
					}
					if (!B) {
						//alert("输入的身份证号 "+ a[0] +" 里出生日期不对。");
						return false;
					}
				}
				if(!re.test(num)){
					//alert("身份证最后一位只能是数字和字母。");
					return false;
				}
				return true;
			}
			
			$.validator.addMethod("pic",function(value,element,params){
				if(value != null && value != ''){
					if(!(/\.png$|\.jpg$|\.jpeg$|\.gif$/i.test(value))){
						return false;
				    }else{
				    	return true;
				    }
				}else{
					return true;
				}
			},"请选择正确的图片格式");
			
			$.validator.addMethod("loginName",function(value,element,params){
				if(value != null && value != ''){
					if(!(/^[_0-9a-zA-Z]{6,16}$/.test(value))){
						return false;
				    }else{
				    	return true;
				    }
				}else{
					return true;
				}
			},"请输入6-16位数字字母登录名");
			
			$.validator.addMethod("lealIdCardValidTypeCheck",function(value,element,params){
				if($("#lealIdCardValidTypeCheck").is(':checked')){
					return true;
			    }else{
			    	if(value == null || value == ''){
						return false;
					}else{
						return true;
					}
			    }
			},"请选择日期");
			
			$.validator.addMethod("businessTermTypeCheck",function(value,element,params){
				if($("#businessTermTypeCheck").is(':checked')){
					return true;
			    }else{
			    	if(value == null || value == ''){
						return false;
					}else{
						return true;
					}
			    }
			},"请选择日期");
			
			$.validator.addMethod("checkPhoneOnly",function(value,element,params){
				var isTrue = true;
				if(value != null && value != ''){
					$.ajax({
					      url: '<%=request.getContextPath()%>/admin/userFront/selectByPhone',
					      dataType: 'json',
					      type: 'POST',
					      async: false, 
					      data: {
					    	  phone:value
					      },
					      success: function (data) {
					    	if(data.status == 'ok'){
					    		isTrue = true;
					    	}else{
					    		isTrue = false;
					    	}
					      },
					      error: function(){
					    	  layer.alert('系统错误', {
									icon : 5
								});
					      }
					  });
				}
				return isTrue;
			},"手机号已存在");
			
			$.validator.addMethod("geren",function(value,element,params){
				if($("input[name='compType']:checked").val() != '2'){
					if(value == null || value == ''){
						return false;
					}else{
						return true;
					}
				}else{
					return true;
				}
			},"当前字段必填");
			
			$.validator.addMethod("daili",function(value,element,params){
				var isTrue = true
				if($("input[name='compType']:checked").val() != '2'){
					if(($('#agentPerson').val() != null && $('#agentPerson').val() != '') || ($('#agentPhone').val() != null && $('#agentPhone').val() != '')){
						if(value == null || value == ''){
							isTrue = false;
						}
					}
				}
				return isTrue;
			},"当前字段必填");
			
			$('#myForm').validate_popover({
	            onsubmit:true,
	            rules: {
	            	creditCode: {
	            		geren: true,
	            		minlength: 18,
	            		maxlength:18
	                },
	                compName: {
	                    required: true
	                },
	                lealPerson: {
	                    required: true
	                },
	                lealPhone: {
	                	required: true,
	                    phone: true
	                },
	                agentPhone: {
	                    phone: true
	                },
	                lealIdCard: {
	                    required: true,
	                    idCard: true
	                },
	                lealIdCardValidDate: {
	                	lealIdCardValidTypeCheck: true
	                },
	                areaCodeName: {
	                    required: true
	                },
	                address: {
	                    required: true
	                },
	                businessTermDate: {
	                	businessTermTypeCheck: true
	                },
	                compTrade: {
	                    required: true
	                },
	                lealFrontImage: {
	                    required: true,
	                    pic: true
	                },
	                lealBackImage: {
	                    required: true,
	                    pic: true
	                },
	                organizationImage: {
	                    pic: true
	                },
	                businessLicenseImage: {
	                	geren: true,
	                    pic: true
	                },
	                agentFrontImage:{
	                	daili: true,
	                	pic: true
	                },
	                agentBackImage:{
	                	daili: true,
	                	pic: true
	                },
	                proxyPicImage:{
	                	daili: true,
	                	pic: true
	                },
	                grLealPerson:{
	                	required: true
	                },
	                grLealIdCard:{
	                	required: true,
	                	idCard: true
	                },
	                grLealPhone:{
	                	required: true,
	                	phone: true
	                },
	                loginName:{
	                	required: true,
	                	loginName: loginName
	                }
	            },
	            messages: {
	                
	            },
	            submitHandler: function (form) {
	            	submit();
	            }
	        });
	    });
		
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}
		
		function submit() {
			//将form表单参数组成json
			var jsonData = {};
			$("#myForm").find("input").each(function() {
				jsonData[$(this).attr('id')] = $(this).val();
			});
			$("#myForm").find("select").each(function(){
				jsonData[$(this).attr('id')] = $(this).val();
			});
			
			var chk_value =[];
			$('input[name="compTrade"]:checked').each(function(){
				chk_value.push($(this).val());
			});
			if(chk_value.length > 0){
				jsonData.compTrade = JSON.stringify(chk_value);
			}else{
				jsonData.compTrade = '';
			}
			
			jsonData.compType = $("input[name='compType']:checked").val();
			if(jsonData.compType == '2'){
				jsonData.lealPerson = jsonData.grLealPerson;
				jsonData.lealPhone = jsonData.grLealPhone;
				jsonData.lealIdCard = jsonData.grLealIdCard;
			}
			
			var iptfile  = $("[type='file']");
			var ids = [];
			  for(var i=0;i<iptfile.length;i++){
				  if(iptfile[i].value){
					 ids.push(iptfile[i].id);
				  }
			  }
			  
			  if($("#lealIdCardValidTypeCheck").is(':checked')){
				    jsonData.lealIdCardValidType = '1';
			    }else{
			    	jsonData.lealIdCardValidType = '0';
			    }
			  
			  if($("#businessTermTypeCheck").is(':checked')){
				  	jsonData.businessTermType = '1';
			    }else{
			    	jsonData.businessTermType = '0';
			    }
			  layer.confirm('确定保存?', {
		    	  btn: ['确定','取消'] //按钮
		    	}, function(){
				    layer.load(2);
				    $.ajax({
					      url: '<%=request.getContextPath()%>/admin/userFront/addSupplier',
					      dataType: 'json',
					      type: 'POST',
					      data: jsonData,
					      success: function (data) {
					    	layer.closeAll('loading');
					    	if(data.status == 'ok'){
					    		var msg = $.parseJSON(data.msg);
					    		tableId = msg.userId;
					    		suppId = msg.suppId;
					    		//询问框
					    		$(".dataFile").fileinput('upload');
					    	layer.confirm('保存成功', {
					    	  btn: ['确定'] //按钮
					    	}, function(){
					    		parent.search(parseInt(parent.$('.active').attr('jp-data')));
					    		closePage();
					    	});
					    	}else{
					    		layer.alert(data.msg, {icon : 5});
					    	}
					      },
					      error: function(){
					    	layer.closeAll('loading');
					    	  layer.alert('系统错误', {icon : 5});
					      }
					  });
		    	}, function(){
		    		
		    	});
		}
		
		function checkCreditCode(){
			var creditCode = $('#creditCode').val();
			if(creditCode != null && creditCode != ''){
				$.ajax({
	  			      url: '<%=request.getContextPath()%>/admin/userFront/checkCreditCode',
	  			      dataType: 'json',
	  			      type: 'POST',
	  			      data: {
	  			    	creditCode:creditCode,
	  			    	type:2
	  			      },
	  			      success: function (data) {
	  			    	if(data.status == 'fail'){
	  			    		$('#creditCode').val('');
	  			    		$('#submitId').attr("disabled","disabled");
		  			    	//询问框
		  			      	layer.confirm('该供应商信息已存在，是否直接关联该供应商', {
		  			      	  btn: ['马上关联','取消'] //按钮
		  			      	}, function(){
		  			      		$.ajax({
		  			    		      url: '<%=request.getContextPath()%>/admin/userFront/relationSupplierOrDealer',
		  			    		      dataType: 'json',
		  			    		      type: 'POST',
		  			    		      data: {
		  			    		    	  frontUserId:data.msg,
		  			    		    	  type:0
		  			    		      },
		  			    		      success: function (data) {
		  			    		    	if(data.status == 'ok'){
		  			    		    		parent.search(parseInt(parent.$('.active').attr('jp-data')));
		  		  	  			    		closePage();
		  			    		    	}else{
		  			    		    		layer.alert(data.msg, {icon : 5});
		  			    		    	}
		  			    		      },
		  			    		      error: function(){
		  			    		    	  layer.alert('系统错误', {icon : 5});
		  			    		      }
		  			    		  });
		  			      	}, function(){
		  			      		
		  			      	});
	  			    	}else{
	  			    		$('#submitId').removeAttr("disabled");
	  			    	}
	  			      },
	  			      error: function(){
	  			    	  layer.alert('系统错误', {
	  							icon : 5
	  						});
	  			      }
	  			  });
			}
		}
		
		function getArea(id,name){
			layer.open({
	    	    type: 2,
	    	    area: ['300px', '350px'],
	    	    offset: [100,(($(window).width()-500)/2)],
	    	    title: false,
	    	    content: ['<%=request.getContextPath()%>/admin/area/areaPage?id=' + id + '&name=' + name,'no']
	    	});
		}
		
		function setArea(id,name,areaCode,areaCodeName){
			$('#' + name).val(areaCodeName);
			$('#' + id).val(areaCode);
			$.validator.hide_validate_popover($("#areaCodeName"));
		}
		
		function lealIdCardValidTypeCheckClick(){
			if($("#lealIdCardValidTypeCheck").is(':checked')){
				$("#lealIdCardValidDate").val('');
				$("#lealIdCardValidDate").attr("disabled",true);
				$.validator.hide_validate_popover($("#lealIdCardValidDate"));
			}else{
				$("#lealIdCardValidDate").attr("disabled",false);
			}
		}
		
		function businessTermTypeCheckClick(){
			if($("#businessTermTypeCheck").is(':checked')){
				$("#businessTermDate").val('');
				$("#businessTermDate").attr("disabled",true);
				$.validator.hide_validate_popover($("#businessTermDate"));
			}else{
				$("#businessTermDate").attr("disabled",false);
			}
		}
		
		//个人信息显示隐藏
		function onclickCompType(type){
			if(type == '2'){
				$("#gerenImgHide").hide();
				$("#gerenHide").hide();
				$("#gerenShow").show();
			}else{
				$("#gerenImgHide").show();
				$("#gerenHide").show();
				$("#gerenShow").hide();
			}
			$.validator.reposition();
		}
	</script>
</body>
</html>