<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<!-- 活期，理财 -->
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
	<input type="text" value="${id }" id="id" name="id" hidden="true">
	<input type="text" value="${prodType }" id="prodType" name="prodType" hidden="true">
	<div class="panel panel-default panel-wrap">
		<div class="panel-heading">
	      <h3 class="panel-title">${prodTypeName }(${type })</h3>
	   </div>
	<div class="panel panel-default">
		<div class="panel-body">
		<div  class="form-group">
			<label class="col-xs-2 control-label">核心企业</label>
			<div class="input-group col-xs-9">
				<select name="compCoreId" id = "compCoreId" class="form-control" onchange="getSerialNum();clearSub();"></select>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品编号</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="serialNum" id = "serialNum" value="${serialNum}" readonly="readonly">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品发布标题</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="applyName">
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
			<input type="text" id = "investType" name = "investType" hidden="true">
			<div class="input-group col-xs-9" id= "cpsydx">
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品年收益率</label>
			<div class="input-group col-xs-9">
				<input type="hidden" class="form-control" name="borrowRate" id = "borrowRate">
				<input type="text" class="form-control" id="investRate" name="investRate" style= "ime-mode:Disabled">
				<span class="input-group-addon">%</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">产品规模</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control"  name="loanMoney" id = "loanMoney">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">最小投资额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="minInvestMoney">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">最大投资额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="maxInvestMoney">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">递增额度</label>
			<div class="input-group col-xs-9">
				<input type="text" class="form-control" name="increaselMoney">
				<span class="input-group-addon">元</span>
			</div>
		</div>
		<div  class="form-group">
			<label class="col-xs-2 control-label">还款方式</label>
			<div class="input-group col-xs-9" >
				<select class="form-control" id= "loanType"  name="loanType" onchange="loanTypeChange(this)">
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
			<div class="input-group col-xs-9">
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
				<input class="form-control" type="text"  name="upInvestTime" id = "upInvestTime"  readonly="readonly">
				<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
			</div>
		</div>
		<div  class="form-group" id="div_kssj">
			<label class="col-xs-2 control-label">开售时间</label>
			<div class="input-group date form_time col-xs-3"  id= "kssj">
				<input class="form-control" type="text"  name="startInvestTime" id= "startInvestTime"  readonly="readonly">
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
		<div class="col-xs-12" id = "div_buttons" style="text-align: center;">
		<shiro:hasPermission name="loan:dq:save">
			<button type="submit" class="btn btn-primary" id="tjsh">提交审核</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</shiro:hasPermission>
		<shiro:hasPermission name="loan:dq:tmpSave">
			<button type="button" class="btn btn-success" id="zsbc" onclick="tmpSave('<%=request.getContextPath()%>/admin/project/loan/tmpSave_dq');">暂时保存</button>
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
	$('#dataFile').fileinput({
	    language: 'zh',
	    showUpload:false,
	    showClose:false,
	    uploadUrl: '<%=request.getContextPath()%>/pics/addLoan?id=${id}',
	    allowedFileExtensions : ['jpg', 'png','gif']
	})
	//设置借款人对象
	  $("#jkrdx").showList('radio',{infoList:'${scf_loan_jkrdx}',name:'businessType',column_name:'dicDataName',column_value:'dicDataValue',lableClass:'checkbox-inline'});
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
			  
			//产品适用对象
			  //设置当前产品类型预先配置的产品适用对象
			  var prodUserConnList = '${prodUserConnList}';
			  var prodUser = null;
			  if('' != prodUserConnList){
				  prodUser = $.parseJSON(prodUserConnList);
			  }
			  var cpsydx = ${scf_loan_cpsydx};
			  template = "";
			  for(var i=0;i<cpsydx.length;i++){
				  var obj = cpsydx[i];
				  if(null != prodUser){
					  for(var j=0;j<prodUser.length;j++){
						  var a = prodUser[j];
						  if(a.userTypeId == obj.dicDataValue){
							  template += "<label class=\"radio-inline\">"+obj.dicDataName+"<input type=\"checkbox\" name=\"check_inver\" ";
							  template += " onclick=\"setInvestType(this,"+obj.dicDataValue+")\" value="+obj.dicDataValue+"></label>";
						  }
					  }
				  }
			  }
			  $("#cpsydx").append(template);
			  
			
			  $('#myForm').validate_popover({
		            onsubmit:true,
		            popoverPosition: 'right',
		            rules: {
		            	userFrontName:"required",
		            	prodType:"required",
		            	scfElemId:"required",
		            	check_inver:{
		            		checkOne:true
		            	},
		            	investType:{
		            		required:true,
		            		min:1
		            	},
		            	loanMoney:{
		            		required:true,
		            		number:true,
		            		min:1
		            	},
		            	investRate:{
		            		required:true,
		            		number:true,
		            		range:[0,30]
		            	},
		            	applyName:"required",
		            	prodType:{
		            		required:true
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
		            	investRate:"请输入合理的利率",
		            	investType:"请至少选择一项"
		            },
		            submitHandler: function (form) {
		            	var investRate = $("#investRate").val();
		            	$("#borrowRate").val(investRate);
		                save('<%=request.getContextPath()%>/admin/project/loan/save_hq','menu124');
		            }
		        });
			  
		});
		
		
	</script>
</body>
</html>