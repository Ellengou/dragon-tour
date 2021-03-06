<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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
									<%@ include file="/WEB-INF/views/loan/template/productTemplate.jsp"%>
									
									<ul id="myTab" class="nav nav-tabs">
										<li class="active"><a href="#verifySituation">审核情况</a></li>
										<li><a href="#investSituation">投资情况</a></li>
										<li><a href="#dataProve">资料证明</a></li>
										<li><a href="#productSituation">产品详情</a></li>
										<li><a href="#giveMoney">放款</a></li>
										<li><a href="#deals">合同</a></li>
									</ul>
									<div id="myTabContent" class="tab-content">
										<div class="tab-pane fade in active" id="verifySituation">
										<%@ include file="/WEB-INF/views/loan/template/verifyTemplate.jsp"%>
   										</div>
   										<div class="tab-pane fade" id="investSituation">
									   </div>
									   <div class="tab-pane fade" id="dataProve">
									   </div>
									   <div class="tab-pane fade" id="productSituation">
									      <p>${scfLoan.introductions }</p>
									   </div>
									   <div class="tab-pane fade" id="giveMoney">
									   <div class="panel panel-default">
											<table class="table">
											   <thead>
											      <tr>
											         <th>借款人</th>
											         <th>借款额度</th>
											         <th>电子账户</th>
											         <th>放款时间</th>
											      </tr>
											   </thead>
											   <tbody>
											      <tr>
											         <td>${scfLoan.userFrontName}</td>
											         <td>${scfLoan.realMoney}</td>
											         <td>${serial_num}</td>
											         <td></td>
											      </tr>
											   </tbody>
											</table>
											</div>
									   </div>
									   <div class="tab-pane fade" id="deals">
									   </div>
									</div>
								</form>
								
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<button type="button" class="btn btn-primary" onclick="verify('${scfLoan.id}');">放款</button>
										<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
									</div>
								</div>
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
	<%@ include file="/WEB-INF/views/template/bootstrap-fileinput-master.jsp"%>
	<script>
	var loanId = '${scfLoan.id}';
	var baseUrl = '${baseUrl}';
	function showPic(target){
		var $this = $(target);
		var src = $this.attr('src');
		var name = $this.attr('alt');
		layer.photos({
			photos:{
				  "title": name, //相册标题
				  "data": [   //相册包含的图片，数组格式
				    {
				      "alt": name,
				      "src": src, //原图地址
				    }
				  ]
				}
		})
	}
    function getInitialPreview(list){
		var tmp = [];
		for(var i=0;i<list.length;i++){
			var obj = list[i];
			tmp.push('<img onclick="showPic(this)" alt="'+obj['name']+'" title="'+obj['name']+'" src="'+baseUrl+obj['web_url']+'" class="file-preview-image" style="width: 120px;height: 80px;">')
		}
		return tmp;
	}
    function getInitialPreviewConfig(list){
    	var tmp = [];
    	for(var i=0;i<list.length;i++){
			var obj = list[i];
			var initObj = {
		        caption: obj['name'], 
		        filetype:'image',
		        width:'100%'
			};
			tmp.push(initObj);
		}
    	return tmp;
    }
    function getHtml(list,name,id){
    	var html = '';
    	html += '<div class="panel panel-default">';
    	html += '<div class="panel-heading">';
    	html += '<h3 class="panel-title">'+name+'</h3>';
    	html += '</div>';
    	html += '<div class="panel-body">';
    	html += '<input id="'+id+'" type="file" class="file" multiple disabled="disabled">';
    	html += '</div>';
    	html += '</div>';
    	$("#dataProve").append(html);
    	$('#'+id).fileinput({
            language: 'zh',
            initialPreview:getInitialPreview(list),
            initialPreviewConfig:getInitialPreviewConfig(list),
            initialPreviewFileType:'image',
            showRemove:false,
            showUpload:false,
            showCancel:false,
            showClose:false,
            showBrowse:false,
            initialPreviewShowDelete:false,
            allowedFileExtensions : ['jpg', 'png','gif']
        })
    }
    var initList = '${list}';
    if('' != initList){
    	initList = $.parseJSON(initList);
    	var base = [];
    	var qysh = [];
    	var ptsh = [];
    	var mbsh = [];
    	for(var i = 0;i<initList.length;i++){
    		var obj = initList[i];
    		var type = obj.type;
    		if(type == 'loan_base'){
    			base.push(obj);
    		}else if(type == 'loan_qysh'){
    			qysh.push(obj);
    		}else if(type == 'loan_ptsh'){
    			ptsh.push(obj);
    		}else if(type == 'loan_mbsh'){
    			mbsh.push(obj);
    		}
    	}
    	if(base.length > 0){
    		getHtml(base,'基础资料','dataFile_base');
    	}
    	if(qysh.length > 0){
    		getHtml(qysh,'企业审核资料','dataFile_qysh');
    	}
    	if(ptsh.length > 0){
    		getHtml(ptsh,'平台审核资料','dataFile_ptsh');
    	}
    	if(mbsh.length > 0){
    		getHtml(mbsh,'满标审核资料','dataFile_mbsh');
    	}
    }
	
	function verify(id){
		layer.open({
    	    type: 2,
    	    area: ['600px', '400px'],
    	    offset: [100,(($(window).width()-600)/2)],
    	    title: '放款',
    	    content: '<%=request.getContextPath()%>/admin/project/loan/fkVerifyPage?id=' + id
    	});
    }
	//单独激活每个标签
	$('#myTab a').click(function (e) {
		  e.preventDefault()
		  var $this = $(this);
		  if($this.attr('href') == "#verifySituation"){
			  
		  }else if($this.attr('href') == "#investSituation"){
			  var url = "<%=request.getContextPath()%>/admin/project/loan/invest/investSituation?id="+loanId;
			  $.get(url, function(result){
				    $("#investSituation").html(result);
				 });
		  }else if($this.attr('href') == "#repaySituation"){
			  
		  }else if($this.attr('href')  == "#dataProve"){
			  var url = "<%=request.getContextPath()%>/admin/project/loan/getPicsPage?id="+loanId;
			  $.get(url, function(result){
				    $("#dataProve").html(result);
				  });
		  }else if($this.attr('href') == "#productSituation"){
			  
		  }else if($this.attr('href') == "#giveMoney"){
			  
		  }else if($this.attr('href') == "#deals"){
			  var url = "<%=request.getContextPath()%>/admin/project/loan/getLoanDeal?loanId="+loanId;
			  $.get(url, function(result){
				    $("#deals").html(result);
				  });
		  }
		  $this.tab('show')
		})
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}
	</script>
</body>
</html>