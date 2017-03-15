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
	<input type="text" value="${scfLoan.id }" id="id" name="id" hidden="true">
	<input type="text" value="${scfLoan.type }" id="type" name="type" hidden="true">
	<input type="text" value="${userLoanId }" id="userLoanId" name="userLoanId" hidden="true">
	<div class="panel panel-default panel-wrap">
		<div class="panel-heading">
	      <h3 class="panel-title">发标</h3>
	   </div>
	<div class="panel panel-default">
		<div class="panel-body">
		
		<div  class="form-group">
			<label class="col-xs-2 control-label">借款人对象</label>
			<div class="input-group col-xs-9" id = "jkrdx">
				<input type="text" name="businessType" id="businessType" hidden="true" value="${scfLoan.businessType }">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">借款产品</label>
			<div class="input-group col-xs-9">
				<input type="text" value="${scfLoan.borrowProduct }" id="borrowProduct" name="borrowProduct" hidden="true">
				<input type="text" class="form-control" value="${borrowProductName }" id="borrowProductName" name="borrowProductName" readonly="readonly">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">核心企业</label>
			<div class="input-group col-xs-9">
				<input type="text" value="${scfLoan.compCoreId }" id="compCoreId" name="compCoreId" hidden="true">
				<input type="text" class="form-control" value="${compCoreName }" id="compCoreName" name="compCoreName" readonly="readonly">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">供应商名称</label>
			<div class="input-group col-xs-9">
				<input type="text" name="frontUserId" id="frontUserId" hidden="true" value="${scfLoan.frontUserId }">
				<input type="text" class="form-control" id="userFrontName" name="userFrontName" autocomplete="off" data-provide="typeahead" value="${scfLoan.userFrontName }" readonly="readonly">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">质押公司</label>
			<div class="input-group col-xs-9">
				<input type="text" value="${scfLoan.pledgeCompanyId }" id="pledgeCompanyId" name="pledgeCompanyId" hidden="true">
				<input type="text" class="form-control" value="${scfLoan.pledgeCompanyName }" id="pledgeCompanyName" name="pledgeCompanyName" readonly="readonly">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">贷款申请需求</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="loanMoneyDes" id="loanMoneyDes" value="${scfLoan.loanMoneyDes }">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">贷款申请额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="productScale" placeholder="最大申请额度${scfLoan.loanMoney }元" id = "productScale" value="${scfLoan.loanMoney }">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">贷款申请年利率</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="borrowRate" value="${scfLoan.borrowRate }" readonly="readonly">
				<span class="input-group-addon">%</span>
			</div>
		</div>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-body">
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品编号</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="serialNum" value="${scfLoan.serialNum}" readonly="readonly">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品发布标题</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="applyName" value="${scfLoan.applyName }">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品所属系列</label>
			<div class="input-group col-xs-9">
				<input type="text" value="${scfLoan.prodType }" id="prodType" name="prodType" hidden="true">
				<input type="text" class="form-control" value="${prodTypeName }" id="prodTypeName" name="prodTypeName" readonly="readonly">
			</div>
		</div>
		<div  class="form-group" id = "div_p">
			<label class="col-xs-2 control-label">合同/协议</label>
			<div class="input-group col-xs-9" id = "div_pro">
				<input type="hidden" name="procotols" id="procotols">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">标的性质</label>
			<div class="input-group col-xs-offset-2 col-xs-9"  id="bdxz">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品适用对象</label>
			<input type="text" id = "investType" name = "investType" hidden="true" value="${scfLoan.investType }">
			<div class="input-group col-xs-9" id= "cpsydx">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品年收益率</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" id="investRate" name="investRate" style= "ime-mode:Disabled" value="${scfLoan.investRate }">
				<span class="input-group-addon">%</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品规模</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" placeholder="最大申请额度${scfLoan.loanMoney }元" name="loanMoney" value="${scfLoan.loanMoney }" id = "loanMoney">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品期限</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="productLine" value="${scfLoan.productLine }" readonly="readonly">
				<span class="input-group-addon">天</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">最小投资额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="minInvestMoney" value="${scfLoan.minInvestMoney }">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">最大投资额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="maxInvestMoney" value="${scfLoan.maxInvestMoney }">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">递增额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="increaselMoney" value="${scfLoan.increaselMoney }">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">还款方式</label>
			<div class="input-group col-xs-9" >
				<input type="text" name="loanType" id = "loanType" value="${scfLoan.loanType }" hidden="true">
				<input type="text" class="form-control" value="${loanTypeName }" readonly="readonly">
			</div>
		</div>
		<div  class="form-group" id = "div_payDay"></div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">起息日计算方式</label>
			<div class="input-group col-xs-9">
				<select class="form-control"  name="rateCalculateType" id= "rateCalculateType">
				</select>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">筹标期限</label>
			<div class="input-group col-xs-9">
				<select class="form-control"  name="deadLine" id= "deadLine">
				</select>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">借款奖励</label>
			<div class="input-group col-xs-9"  id = "jkjl">
			</div>
		</div>
		</div>
	</div>
	<div class="panel panel-default">
		<div class="panel-body">
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品详情</label>
			<div class="input-group col-xs-9">
				<div id="summernote"></div>
			</div>
		</div>
		<div  class="form-group" id="files" data-toggle="tooltip" title = "上传前,请确保文件名正确">
			<label class="col-xs-2 control-label">资料上传</label>
			<div class="input-group col-xs-9" >
				<input id="dataFile" type="file" class="file" multiple>
			</div>
		</div>
		<div  class="form-group" id="div_fbsj">
			<label class="col-xs-2 control-label">发布时间</label>
			<div class="input-group date form_time col-xs-3"  id= "fbsj">
				<input class="form-control" size="16" type="text"  name="upInvestTime" id = "upInvestTime" value="${upInvestTime }"  readonly>
				<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
			</div>
		</div>
		<div  class="form-group" id="div_kssj">
			<label class="col-xs-2 control-label">开售时间</label>
			<div class="input-group date form_time col-xs-3"  id= "kssj">
				<input class="form-control" size="16" type="text"  name="startInvestTime" id= "startInvestTime" value="${startInvestTime }" readonly>
				<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
			</div>
		</div>
		<!-- <div  class="form-group">
			<label class="col-xs-2 control-label">是否置顶</label>
			<div class="input-group col-xs-9">
				<label class="checkbox-inline">是<input  type="radio" name="isTop" value="0"></label>
				<label class="checkbox-inline">否<input  type="radio" name="isTop" value="1" checked="checked"></label>
			</div>
		</div> -->
		<div  class="form-group">
			<label class="col-xs-2 control-label">常见问题</label>
			<div class="input-group col-xs-9">
				<div id = "commonProblem"></div>
			</div>
		</div>
		</div>
	</div>
		<div  class="form-group">
			<div class="col-xs-offset-2 col-xs-9" id = "div_buttons" style="text-align: center;">
			<shiro:hasPermission name="userloan:to:loan:save">
				<button type="submit" class="btn btn-primary" id="tjsh">提交审核</button>
			</shiro:hasPermission>
				<button type="button" class="btn btn-danger" id="cancel" onclick="closePage()">取消</button>
			</div>
		</div>
	</div>
	</form>
	
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap-typeahead.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/views/template/summernote.jsp"%>
	<%@ include file="/WEB-INF/views/loan/template/loanJsTemplate_fromDebt.jsp"%>
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	<script>
	$('#dataFile').fileinput({
	    language: 'zh',
	    showUpload:false,
	    uploadUrl: '<%=request.getContextPath()%>/pics/addLoan?id=${scfLoan.id}',
	    allowedFileExtensions : ['jpg', 'png','gif']
	})
	//设置借款人对象
	$("#jkrdx").showList('radio',{infoList:'${scf_loan_jkrdx}',column_name:'dicDataName',column_value:'dicDataValue',selectValue:'${scfLoan.businessType}',lableClass:'checkbox-inline',disabledAll:true});
		
	$(document).ready(function(){
	  var template = "";
	  //产品适用对象
	  var cpsydx = ${scf_loan_cpsydx};
	  var cpsydx_val = "${scfLoan.investType}";
	  template = "";
	  for(var i=0;i<cpsydx.length;i++){
		  var obj = cpsydx[i];
		  template += "<label class=\"radio-inline\">"+obj.dicDataName+"<input type=\"checkbox\" name=\"check_inver\"	onclick=\"setInvestType(this,"+obj.dicDataValue+")\" value=\""+obj.dicDataValue+"\"";
		  if(cpsydx_val.indexOf(obj.dicDataValue)>-1){
			  template += "checked=\"checked\"";
		  }
		  template += "></label>";
	  }
	  $("#cpsydx").append(template);
	  

	  //是否置顶
	  var isTop = "${scfLoan.isTop}";
	  $("input[name='isTop']").each(function(){
		  if(isTop == $(this).val()){
			  $(this).attr('checked',true);
		  }
	  });

	  var loanType=$("#loanType").val();
		//根据还款方式是否展示还款日
		var rList = $.parseJSON('${repayTypeMainList}');
		var showUnit;
		for(var i=0;i<rList.length;i++){
			var obj = rList[i];
			if(obj.id == loanType){
				if(obj.showUnit == '0'){
					var template = '<label class="col-xs-2 control-label">还款日</label><div class="input-group col-xs-9"><input type="text" class="form-control" name="repayDate" id="repayDate" value="${scfLoan.repayDate}" readonly="readonly"><span class="input-group-addon">日</span></div>';
					$("#div_payDay").append(template);
				}else{
					$("#div_payDay").empty();
				}
			}
		}
		
		//设置计息方式
		$("#rateCalculateType").empty();
		if(null != loanType && ''!= loanType){
			$.ajax({
				url:'<%=request.getContextPath()%>/admin/project/loan/getJxfs?repayType='+loanType,
				type:'GET',
				dataType: 'json',
				success:function(data){
					if(data.status == 'ok'){
						$("#rateCalculateType").showList('option',{infoList:data.json,selectValue:'${scfLoan.rateCalculateType}',emptySelect:false})
					}
				}
			})
		}
	  
	  $('#myForm').validate_popover({
            onsubmit:true,
            popoverPosition: 'right',
            rules: {
            	frontUserId:"required",
            	userFrontName:"required",
            	pledgeCompanyName:"required",
            	pledgeCompanyId:"required",
            	loanMoneyDes:"required",
            	scfElemId:"required",
            	check_inver:{
            		checkOne:true
            	},
            	loanMoney:{
            		required:true,
            		number:true,
            		min:1,
            		max:parseFloat('${scfLoan.loanMoney}')
            	},
            	investRate:{
            		required:true,
            		number:true,
            		range:[0,30]
            	},
            	applyName:"required",
            	borrowRate:{
            		required:true,
            		number:true,
            		range:[0,30]
            	},
            	prodType:{
            		required:true
            	},
            	productScale:{
            		required:true,
            		number:true,
            		min:1,
            		max:parseFloat('${scfLoan.loanMoney}')
            	},
            	productLine:{
            		required:true,
            		digits:true,
            		min:1
            	},
            	minInvestMoney:{
            		required:true,
            		number:true
            	},
            	maxInvestMoney:{
            		required:true,
            		number:true
            	},
            	increaselMoney:{
            		required:true,
            		number:true
            	},
            	deadLine:{
            		digits:true
            	},
            	repayDate:{
            		required:true,
            		digits:true,
            		range:[1,28]
            	},
            	upInvestTime:"required",
            	startInvestTime:"required",
            	investType:{
            		required:true,
            	}
            },
            messages:{
            	frontUserId:"请重新输入供应商",
            	pledgeCompanyId:"请重新选择质押公司",
            	borrowRate:"请输入合理的利率",
            	investRate:"请输入合理的利率",
            	loanMoney:{
            		max:"最大申请额度${scfLoan.loanMoney}元"
            	},
            	productScale:{
            		max:"最大申请额度${scfLoan.loanMoney}元"
            	}
            },
            submitHandler: function (form) {
                save('<%=request.getContextPath()%>/admin/project/loan/saveFromDebt','menu256');
            }
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