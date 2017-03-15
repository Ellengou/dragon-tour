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
    html,body {
    	padding:0;
    	overflow-x:hidden;
    }    
</style>
</head>
<body>
	<form id="myForm" class="form-horizontal" role="form" enctype="multipart/form-data">
		
	<div class="panel panel-default">
		<div class="panel-heading">
	      <table class="table">
	      	<tr>
	      		<td>
	      			应还本金(元):${debtRepay.corpus }
	      		</td>
	      		<td>
	      			应还利息(元):${debtRepay.interest }
	      		</td>
	      		<td>
	      			应还贴息(元):${debtRepay.txinterest }
	      		</td>
	      	</tr>
	      	<tr>
	      		<td>
	      			已还本金(元):${debtRepay.actualMoney }
	      		</td>
	      		<td>
	      			已还利息(元):${debtRepay.actualInterest }
	      		</td>
	      		<td>
	      			已还贴息(元):${debtRepay.actualTxinterest }
	      		</td>
	      	</tr>
	      </table>
	   </div>
		<div class="panel-body">
		<div  class="form-group">
			<label class="col-xs-2 control-label">还款本金:</label>
			<div class="input-group col-xs-8">
				<input type="text" class="form-control" id="amount" name="amount" value="0">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">还款利息:</label>
			<div class="input-group col-xs-8">
				<input type="text" class="form-control" id="interest" name="interest" value="0">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">还款贴息:</label>
			<div class="input-group col-xs-8">
				<input type="text" class="form-control" id="xInterest" name="xInterest" value="0">
			</div>
		</div>
		<div  class="form-group">
			<div class="col-xs-12" id = "div_buttons" style="text-align: center;">
				<button type="submit" class="btn btn-primary" id="tjsh">保存</button>
			</div>
		</div>
		</div>
	</div>
	</form>
	
	<!-- layer JavaScript -->
	<script>

		$(document).ready(function(){
			$("#amount").val(('${debtRepay.corpus }' - '${debtRepay.actualMoney }').toFixed(2));
			$("#interest").val(('${debtRepay.interest }' - '${debtRepay.actualInterest }').toFixed(2));
			$("#xInterest").val(('${debtRepay.txinterest }' - '${debtRepay.actualTxinterest }').toFixed(2));
			  $('#myForm').validate_popover({
		            onsubmit:true,
		            popoverPosition: 'right',
		            rules: {
		            	amount:{
		            		required:true,
		            		number:true,
		            		range : [0,'${maxAmount}']
		            	},
		            	interest:{
		            		required:true,
		            		number:true,
		            		range : [0,'${maxInterest}']
		            	},
		            	xInterest:{
		            		required:true,
		            		number:true,
		            		range : [0,'${maxXInterest}']
		            	}
		            },
		            messages:{
		            	amount:{
		            		required:"请输入金额",
		            		number:"请输入合理金额",
		            		range : "额度范围:0到${maxAmount}元"
		            	},
		            	interest:{
		            		required:"请输入金额",
		            		number:"请输入合理金额",
		            		range : "额度范围:0到${maxInterest}元"
		            	},
		            	xInterest:{
		            		required:"请输入金额",
		            		number:"请输入合理金额",
		            		range : "额度范围:0到${maxXInterest}元"
		            	}
		            },
		            submitHandler: function (form) {
		                save();
		            }
		        });
			  
		});
		
		function save(){
			layer.confirm('确认还款?', {icon: 3, title:'提示'}, function(index){
				layer.msg('数据开始保存....',{offset:50});
				var amount = $("#amount").val();
				var interest = $("#interest").val();
				var xInterest = $("#xInterest").val();
				$.ajax({
				      url: '<%=request.getContextPath()%>/admin/userloan/oplogSaveDebtHk',
				      dataType: 'json',
				      type: 'POST',
				      data: {id:'${debtRepay.id}',amount : amount,interest : interest,xInterest : xInterest},
				      success: function (data) {
				    	 if(data.status == 'ok'){
				    		 layer.alert('还款成功', {
			                        icon: 1,
			                        offset:50
			                  },function(index){
			                	  layer.close(index);
			                	  parent.location.reload();
			                  });
				    	}else{
				    		layer.alert(data.msg, {
								icon : 5,
								offset:50
							});
				    	}
				      },
				      error: function(){
				    	  layer.alert('系统错误', {
								icon : 5,
								offset:50
							});
				      }
				  });
			  layer.close(index);
			});
		}
	</script>
</body>
</html>