<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<%@ include file="/WEB-INF/views/template/validator.jsp"%>
<style>
.placeholder {
	font-size: 11px;
	color: #aeaeae;
}
</style>
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
									<div  class="form-group">
										<label class="col-xs-3 control-label">核心企业</label>
										<div class="input-group col-xs-6">
											<select  class="form-control" id = "compCoreId" name = "compCoreId" onchange="setBorrowProducts();"></select>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-3 control-label">借款产品</label>
										<div class="input-group col-xs-6">
											<select  class="form-control" id = "borrowProductId" name = "borrowProductId"></select>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-3 control-label">贷款期限</label>
										<div class="input-group col-xs-6">
											<select  class="form-control" id = "deadLine" name = "deadLine"></select>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-3 control-label">最小贷款金额</label>
										<div class="input-group col-xs-6">
											<input type="text" class="form-control" name="minMoney" id="minMoney">
											<span class="input-group-addon">元</span>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-3 control-label">最大贷款金额</label>
										<div class="input-group col-xs-6">
											<input type="text" class="form-control" name="maxMoney" id="maxMoney">
											<span class="input-group-addon">元</span>
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-3 control-label">贷款年利率</label>
										<div class="input-group col-xs-6">
											<input type="text" class="form-control" name="investRate" id="investRate">
											<span class="input-group-addon">%</span>
										</div>
									</div>
									<div  class="form-group" id = "div_repayType">
										<label class="col-xs-3 control-label">还款方式</label>
										<div class="input-group col-xs-6">
											<select  class="form-control" id = "loanType" name = "loanType"></select>
										</div>
									</div>
									<div  class="form-group" id = "div_repay_date">
										<label class="col-xs-3 control-label">还款日</label>
										<div class="input-group col-xs-6">
											<input type="text" class="form-control" name="repayDate" id="repayDate">
											<span class="input-group-addon">号</span>
										</div>
									</div>
									<div  class="form-group" id = "div_service_rate">
										<label class="col-xs-3 control-label">是否贴息</label>
										<div class="checkbox">
									        <label id = lb_service_rate>
									          <input type="checkbox" name="serviceRate" id = serviceRate>
									        </label>
									      </div>
									</div>
									<div  class="form-group">
										<div class="col-xs-12" style="text-align: center;">
										<shiro:hasPermission name="debt:product:add:save">
											<button type="submit" class="btn btn-primary">保存</button>
										</shiro:hasPermission>
											<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
										</div>
									</div>
								</form>
								<hr>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
<script>
	$("#loanType").showList('option',{infoList:'${repayType}',column_value:'id',emptySelect:false});
	$("#deadLine").showList('option',{infoList:'${deadLineList}',emptySelect:false});
	var compCoreList = $.parseJSON('${compCoreList}');
	$("#compCoreId").showList('option',{infoList:compCoreList,emptySelect:false});
	function save(){
		layer.msg('数据开始保存....',{offset:50});
		var jsonData = $("form").serialize();
		$.ajax({
		      url: '<%=request.getContextPath()%>/admin/debt/product/save',
		      dataType: 'json',
		      type: 'POST',
		      data: jsonData,
		      success: function (data) {
		    	 if(data.status == 'ok'){
		    		 layer.alert('保存成功', {
	                        icon: 1,
	                        offset:50
	                  },function(index){
	                	  var parIndex = parent.layer.getFrameIndex(window.name);
	                	  layer.close(index);
	                	  parent.location.reload();
	                	  parent.layer.close(parIndex);
	                  });

		    	}else{
		    		layer.alert(data.msg, {
						icon : 5
					});
		    	}
		      },
		      error: function(){
		    	  layer.alert('数据保存出错', {
						icon : 5
					});
		      }
		  });
	}
	
	function repayDate(val){
		var repayType = '${repayType}';
		if('' != repayType){
			type = $.parseJSON(repayType);
			for(var i = 0;i<type.length;i++){
				var obj = type[i];
				if(val == obj.id){
					if('0' == obj.showUnit){
						$("#div_repay_date").show();
						$("#repayDate").rules("add",{required: true,digits:true,range:[1,28]});
					}else{
						$("#repayDate").val(null);
						$("#div_repay_date").hide();
						$("#repayDate").rules("remove");
						$(".error-popover").hide();
					}
					break;
				}
			}
		}
	}
	
	function setBorrowProducts(){
		$("#borrowProductId").empty();
		var compCoreId = $("#compCoreId").val();
		for(var i=0;i<compCoreList.length;i++){
			var obj = compCoreList[i];
			if(obj.value == compCoreId){
				var borrowProducts = obj.borrowProducts;
				$("#borrowProductId").showList('option',{infoList:borrowProducts,column_value:'id',emptySelect:false});
			}
		}
	}
	
	$(document).ready(function(){
		setBorrowProducts();
		var serviceRate = '${serviceRate}';
		if('' != serviceRate){
			$("#lb_service_rate").append('当前的贴息利率是:'+serviceRate+'%');
		}
		
		
			$('#myForm').validate_popover({
	            onsubmit:true,
	            popoverPosition: 'right',
	            rules: {
	            	deadLine:"required",
	            	minMoney:{
	            		required:true,
	            		number:true,
	            		min:1
	            	},
	            	maxMoney:{
	            		required:true,
	            		number:true,
	            		min:1
	            	},
	            	investRate:{
	            		required:true,
	            		number:true,
	            		range:[0,30]
	            	},
	            	loanType:"required",
	            	repayDate:{
	            		required:true,
	            		digits:true,
	            		range:[1,28]
	            	}
	            },
	            submitHandler: function (form) {
	                save();
	            }
	        });
			
			var loanType = $("#loanType").val();
			repayDate(loanType);
			$("#loanType").change(function(){
				var val = $(this).val();
				repayDate(val);
			});
		});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
</script>
</body>
</html>