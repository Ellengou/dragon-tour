<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <!-- Bootstrap Core CSS -->
    <link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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
                                            <span class="input-group-addon">选择文件</span>
                                            <input type="file" class="form-control" id="file_name" name="file_name">
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">借款产品</span>
                                            <select class="form-control" name="borrowProductId" id = "borrowProductId">
					
											</select>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="input-group">
                                            <span class="input-group-addon">核心企业</span>
                                            <select class="form-control" name="compCoreId" id = "compCoreId">
					
											</select>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <hr>
                            <div class="row" align="center">
                                <div class="col-xs-12">
                                    <button type="button" class="btn btn-primary" onclick="submit();">确定</button>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-xs-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">模板下载</span>
                                        <select class="form-control" id = "download" onchange="downLoad(this);">
											<option value="<%=request.getContextPath()%>/template/useloan/应收账款质押贷款模板.xls">应收账款质押贷款模板</option>
											<option value="<%=request.getContextPath()%>/template/useloan/外部担保贷款模板.xls">外部担保贷款模板</option>
											<option value="<%=request.getContextPath()%>/template/useloan/通用贷款模板.xls">通用贷款模板</option>
										</select>
										<span class="input-group-addon">
											<a href="<%=request.getContextPath()%>/template/useloan/应收账款质押贷款模板.xls" id = "but_download">下载</a>
										</span>
                                    </div>
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
<script src="<%=request.getContextPath()%>/bootstrap/plugin/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
<script>

	function downLoad(target){
		var url = $(target).val();
		$("#but_download").attr('href',url);
	}

	$("#compCoreId").showList('option',{infoList:'${compCoreList}',emptySelect:false});
	$("#borrowProductId").showList('option',{infoList:'${borrowProducts}',column_value : 'id',emptySelect:false});
	//$("#borrowType").showList('option',{infoList:'${borrowTypes}',column_name:'name',column_value:'id',emptySelect:false});
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    //关闭窗口并刷新页面
    function closePage(){
        parent.layer.close(index);
    }

    function submit(){
    	var file_name = $("#file_name").val();
    	if(null == file_name || '' == file_name){
    		layer.alert('请选择文件');
    	}else{
    		var borrowProductName = $("#borrowProductId").find("option:selected").text();
	    	layer.confirm('您选择导入的借款产品名称是<'+borrowProductName+'>,请确保导入的数据正确',{
	            btn: ['确定','取消'] //按钮
	        }, function(){
	        	var url = '<%=request.getContextPath()%>/admin/userloan/uploadUserLoan';
		        var loading = layer.load(1, {
		            shade: [0.1,'#fff'] //0.1透明度的白色背景
		        });
		        var data = {compCoreId:$("#compCoreId").val(),status:'${status}',borrowProductId : $("#borrowProductId").val()};
		        $.ajaxFileUpload({
		            url : url,
		            secureuri:false,
		            method : 'POST',
		            fileElementId:'file_name',
		            dataType: 'json',
		            data : data,
		            beforeSend: function(){
	//	                loading = layer.load(2);
		            },
		            error: function (data, status, e) {
		                layer.close(loading);
		                layer.alert("系统错误", {icon: 6});
		            },
		            success: function (data, status) {
		                if(data.status == 'ok'){
		                	layer.alert('导入成功')
		                    layer.close(loading);
		                    parent.search(parseInt(parent.$('.active').attr('jp-data')));
		                    closePage();
		                }else{
		                    layer.close(loading);
		                    layer.alert(data.msg, {icon : 5});
		                }
		            }
		        });
	        }, function(){
	        });
    	}
        
    }
</script>
</body>
</html>