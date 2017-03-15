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
	<div class="panel panel-default panel-wrap">
		<div class="panel-heading">
	      <h3 class="panel-title">修改</h3>
	   </div>
	<div class="panel panel-default">
		<div class="panel-body">
		
		<div  class="form-group">
			<label class="col-xs-2 control-label">借款人对象</label>
			<div class="input-group col-xs-9" id = "jkrdx">
				
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">借款类型</label>
			<div class="input-group col-xs-9">
			<select  class="form-control" name="borrowType" id = "borrowType"></select>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">核心企业</label>
			<div class="input-group col-xs-9">
				<select name="compCoreId" id = "compCoreId" class="form-control" onchange="getSerialNum();clearSub();"></select>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">供应商名称</label>
			<div class="input-group col-xs-9">
				<input type="text" name="frontUserId" id="frontUserId" hidden="true" value="${scfLoan.frontUserId }">
				<input type="text" class="form-control" id="userFrontName" name="userFrontName" autocomplete="off" data-provide="typeahead" value="${scfLoan.userFrontName }" onblur="cleanFrontUserId()">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">质押公司</label>
			<div class="input-group col-xs-9">
				<select id="pledgeCompanyId" name="pledgeCompanyId" class="form-control">
				</select>
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
				<input type="text" class="form-control" name="productScale" placeholder="请选择质押公司" id = "productScale" value="${scfLoan.productScale }">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">贷款申请年利率</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="borrowRate" value="${scfLoan.borrowRate }" style= "ime-mode:Disabled">
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
				<select class="form-control" name="prodType" id = "prodType" onchange="selectProtocol()"></select>
			</div>
		</div>
		<div  class="form-group" id = "div_p">
			<label class="col-xs-2 control-label">合同/协议</label>
			<div class="input-group col-xs-9" id = "div_pro">
				<input type="hidden" name="procotols" id="procotols">
			</div>
		</div>
		<!-- <div  class="form-group">
			<label class="col-xs-2 control-label">标的性质</label>
			<div class="input-group col-xs-offset-2 col-xs-9"  id="bdxz">
			</div>
		</div> -->
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品适用对象</label>
			<input type="text" id = "investType" name = "investType" hidden="true" value="${scfLoan.investType }">
			<div class="input-group col-xs-9" id= "cpsydx">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品年收益率</label>
			<div class="input-group col-xs-9">
				<input type="hidden" class="form-control" name="borrowRate" id = "borrowRate">
				<input type="text" class="form-control" id="investRate" name="investRate" style= "ime-mode:Disabled" value="${scfLoan.investRate }">
				<span class="input-group-addon">%</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品规模</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="loanMoney" value="${scfLoan.loanMoney }" id = "loanMoney">
				
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">最小投资额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="minInvestMoney" id = "minInvestMoney">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">最大投资额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="maxInvestMoney" id = "maxInvestMoney">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">递增额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="increaselMoney" id = "increaselMoney">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">还款方式</label>
			<div class="input-group col-xs-9" >
				<select class="form-control" id= "loanType"  name="loanType" onchange="loanTypeChange()">
				</select>
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
		<%-- <div  class="form-group">
			<label class="col-xs-2 control-label">筹标期限</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="deadLine" value="${scfLoan.deadLine }">
				<span class="input-group-addon">天</span>
			</div>
		</div> --%>
		
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
				<div id="summernote">${scfLoan.introductions}</div>
			</div>
		</div>
		<div  class="form-group" id="files" data-toggle="tooltip" title = "上传前,请确保文件名正确">
			<label class="col-xs-2 control-label">资料上传</label>
			<div class="input-group col-xs-9" >
				<input id="dataFile" type="file" class="file" multiple>
			</div>
		</div>
		<!-- <div  class="form-group" id="div_fbfs">
			<label class="col-xs-2 control-label">发布方式</label>
			<div class="input-group col-xs-9"  id= "fbfs">
			</div>
		</div> -->
		
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
				<div id = "commonProblem">${scfLoan.commonProblem}</div>
			</div>
		</div>
		</div>
	</div>
		<div  class="form-group">
			<div class="col-xs-offset-2 col-xs-9" id = "div_buttons">
			<shiro:hasPermission name="loan:save:fromtmp">
				<button type="submit" class="btn btn-primary" id="tjsh">提交审核</button>
			</shiro:hasPermission>
				<button type="button" class="btn btn-danger" id="cancel" onclick="closePage()">取消</button>
			<shiro:hasPermission name="loan:tmpSave:fromtmp">
				<button type="button" class="btn btn-success" id="zsbc" onclick="tmpSave('<%=request.getContextPath()%>/admin/project/loan/tmpSave_fromtmp');">暂时保存</button>
			</shiro:hasPermission>
			</div>
		</div>
	</div>
	</form>
	
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap-typeahead.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/views/template/summernote.jsp"%>
	<%@ include file="/WEB-INF/views/loan/template/loanJsTemplate.jsp"%>
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	<script>
	var baseUrl = '${baseUrl}';
	var list = '${list}';
	var tp = [];
	if('[]' != list){
		list = $.parseJSON(list);
		for(var i = 0;i<list.length ;i++){
			var obj = list[i];
			tp[i] = '<img alt="" src="'+baseUrl+obj['web_url']+'">';
		}
	}
	$('#dataFile').fileinput({
	    language: 'zh',
	    showUpload:false,
	    initialPreview:tp,
	    uploadUrl: '<%=request.getContextPath()%>/pics/addLoan?id=${scfLoan.id}',
	    allowedFileExtensions : ['jpg', 'png','gif']
	})
	
	if('' != '${scfLoan.productLine}'){
		var productLine = parseFloat('${scfLoan.productLine}');
		$("#productLine").val(productLine);
	}
	if('' != '${scfLoan.minInvestMoney}'){
		var minInvestMoney = parseFloat('${scfLoan.minInvestMoney}');
		$("#minInvestMoney").val(minInvestMoney);
	}
	if('' != '${scfLoan.maxInvestMoney}'){
		var maxInvestMoney = parseFloat('${scfLoan.maxInvestMoney}');
		$("#maxInvestMoney").val(maxInvestMoney)
	}
	if('' != '${scfLoan.increaselMoney}'){
		var increaselMoney = parseFloat('${scfLoan.increaselMoney}');
		$("#increaselMoney").val(increaselMoney)
	}
	//设置借款人对象
	$("#jkrdx").showList('radio',{infoList:'${scf_loan_jkrdx}',name:'businessType',column_name:'dicDataName',column_value:'dicDataValue',selectValue:'${scfLoan.businessType}',lableClass:'checkbox-inline',selectFirst:false});
	//核心公司列表
	$("#compCoreId").showList('option',{infoList:'${compCoreList}',emptySelect:false,selectValue:'${scfLoan.compCoreId}'});
	$(document).ready(function(){
	  var template = "";
	  
	  //设置供应商
	  var gysList;
	  $('#userFrontName').typeahead({
		    source: function (query, process) {
		    	var compCoreId = $("#compCoreId").val();
		    	var type = $("input[name='businessType']").val();
		        var parameter = {query: query,compCoreId:compCoreId,type:type};
		        var url = "<%=request.getContextPath()%>/admin/userSupp/getUserListByRegName";
		        $.post(url, parameter, function (data) {
		        	data = $.parseJSON(data);
		        	gysList = $.parseJSON(data.json);
		        	var names = [];
		        	for(var i=0;i<gysList.length;i++){
		        		names.push(gysList[i].name)
		        	}
		            process(names);
		        });
		    },

		    updater: function (item) {
		    	for(var i=0;i<gysList.length;i++){
		    		var obj = gysList[i];
		    		if(obj.name == item){
		    			$("#frontUserId").val(obj.id);
		    			//设置质押公司选择列表
		    			setPledgeCompanyInfo(obj.id)
		    		}
		    	}
		    	return item;
		    } 

		});

	  //设置质押公司
	  setPledgeCompanyInfo("${scfLoan.frontUserId}");
	  
		//设置还款日
	  loanTypeChange();
		
	//产品适用对象
	  var cpsydx = ${scf_loan_cpsydx};
	  var cpsydx_val = "${scfLoan.investType}";
	  template = "";
	  for(var i=0;i<cpsydx.length;i++){
		  var obj = cpsydx[i];
		  if(null != prodUser){
			  for(var j=0;j<prodUser.length;j++){
				  var a = prodUser[j];
				  if(a.userTypeId == obj.dicDataValue){
					  template += "<label class=\"radio-inline\">"+obj.dicDataName+"<input type=\"checkbox\" name=\"check_inver\" ";
					  if(cpsydx_val.indexOf(obj.dicDataValue)>-1){
						  template += "checked=\"checked\"";
					  }
					  template += " onclick=\"setInvestType(this,"+obj.dicDataValue+")\" value="+obj.dicDataValue+"></label>";
				  }
			  }
		  }
	  }
	  $("#cpsydx").append(template);
	  

	  //是否置顶
	  var isTop = "${scfLoan.isTop}";
	  $("input[name='isTop']").each(function(){
		  if(isTop == $(this).val()){
			  $(this).attr('checked',true);
		  }
	  })

	  
	  $('#myForm').validate_popover({
          onsubmit:true,
          popoverPosition: 'right',
          rules: {
        	check_inver:{
          		checkOne:true
          	},
          	investType:{
          		required:true,
          		min:1
          	},
          	applyName:"required",
          	productScale:{
          		digits:true,
          		min:1
          	},
          	prodType:{
          		required:true
          	},
          	loanMoney:{
        		required:true,
        		number:true,
        		min:1
        	},
          	minInvestMoney:{
          		required:true,
          		digits:true
          	},
          	maxInvestMoney:{
          		required:true,
          		digits:true
          	},
          	increaselMoney:{
          		required:true,
          		digits:true
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
          	investType:"请至少选择一项"
          },
          submitHandler: function (form) {
        	  var investRate = $("#investRate").val();
          	  $("#borrowRate").val(investRate);
              save('<%=request.getContextPath()%>/admin/project/loan/save_fromtmp','menu124');
          }
      });
	  pledgeCompanyChange('${scfLoan.pledgeCompanyId}');
	});
		
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	

	//页面加载时展示已上传的资料
	var pics = '${loanData}';
	showData(pics);
	
	//页面加载时展示合同/协议
	selectProtocol();

	</script>
</body>
</html>