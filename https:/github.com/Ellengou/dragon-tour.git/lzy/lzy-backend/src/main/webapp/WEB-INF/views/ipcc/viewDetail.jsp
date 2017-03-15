<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
</head>
<body>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                咨询历史内容
            </div>
            <div class="panel-body">

                <div class="row">
                    <div class="col-md-4">
                        <div class="input-group">
                            <span class="input-group-addon">咨询方式</span>
                            <input type="text" class="form-control" value="${oldApproach}" readonly>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group input-group">
                            <span class="input-group-addon">咨询类型</span>
                            <input type="text" class="form-control" value="${oldBusiness}" readonly>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group input-group">
                            <span class="input-group-addon">处理状态</span>
                            <input type="text" class="form-control" value="${oldStatus}" readonly>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                咨询内容
                            </div>
                            <div class="panel-body" style="padding: 0px" id="oldContent">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                处理方案
                            </div>
                            <div class="panel-body" style="padding: 0px" id="oldSolve">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                咨询内容追加
            </div>
            <div class="panel-body">
                <form id="myForm">
                    <input type="hidden" class="form-control" name="consultId" id="consultId">
                    <input type="hidden" class="form-control" name="solveId" id="solveId">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-addon">咨询方式</span>
                                <input type="text" class="form-control" value="${oldApproach}" readonly>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group input-group">
                                <span class="input-group-addon">咨询类型</span>
                                <select class="form-control" id="consultingBusiness">
                                    <option value="">无</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group input-group">
                                <span class="input-group-addon">处理状态</span>
                                <select class="form-control" id="status" >
                                    <option value="">无</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    咨询内容
                                </div>
                                <div class="panel-body" style="padding: 0px">
                                    <textarea class="form-control" rows="6" id="consultContent"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    处理方案
                                </div>
                                <div class="panel-body" style="padding: 0px">
                                    <textarea class="form-control" rows="6" id="solveContent"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <button type="button" class="btn btn-info btn-lg btn-block" onclick="submitCon();">立即保存</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
<script>
    $(function () {
        var consultList = $.parseJSON('${consultList}');
        for (var i = 0; i < consultList.length; i++) {
            $('#oldContent').append('<div class="alert alert-warning" role="alert">【'
                    + consultList[i].operateTime + '】 ' + consultList[i].operator + ' ： ' + consultList[i].content + '</div>');
        }

        var solveList = $.parseJSON('${solveList}');
        for (var i = 0; i < solveList.length; i++) {
            $('#oldSolve').append('<div class="alert alert-warning" role="alert">【'
                    + solveList[i].operateTime + '】 ' + solveList[i].operator + ' ： ' + solveList[i].content + '</div>');
        }

        var statusList = $.parseJSON('${statusList}');
        for (var i = 0; i < statusList.length; i++) {
            $(new Option(statusList[i].dicDataName, statusList[i].dicDataValue)).appendTo('#status');
        }

        var businessList = $.parseJSON('${businessList}');
        for (var i = 0; i < businessList.length; i++) {
            $(new Option(businessList[i].name, businessList[i].id)).appendTo('#consultingBusiness');
        }

        $("#status").val("${recordDetail.status}");
        $("#consultingBusiness").val("${recordDetail.consultingBusiness}");
    })

    function submitCon() {
        //询问框
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/ipcc/detail/add',
            dataType: 'json',
            type: 'POST',
            data: {
                detailId:'${recordDetail.id}',
                consultId:$('#consultId').val(),
                solveId:$('#solveId').val(),
                consultingApproach: $('#consultingApproach').val(),
                consultingBusiness: $('#consultingBusiness').val(),
                status: $('#status').val(),
                consultContent: $('#consultContent').val(),
                solveContent: $('#solveContent').val(),
            },
            success: function (data) {
                if(data.status == 'ok'){
                    layer.closeAll('dialog');
                    layer.alert('保存成功', {icon : 6});
                    $('#consultId').val(data.msg.consultId);
                    $('#solveId').val(data.msg.solveId);

                    $('#oldContent').html('');
                    var consultListNew = $.parseJSON(data.msg.consultList);
                    for (var i = 0; i < consultListNew.length; i++) {
                        $('#oldContent').append('<div class="alert alert-warning" role="alert">【'
                                + consultListNew[i].operateTime + '】 ' + consultListNew[i].operator + ' ： ' + consultListNew[i].content + '</div>');
                    }

                    $('#oldSolve').html('');
                    var solveListNew = $.parseJSON(data.msg.solveList);
                    for (var i = 0; i < solveListNew.length; i++) {
                        $('#oldSolve').append('<div class="alert alert-warning" role="alert">【'
                                + solveListNew[i].operateTime + '】 ' + solveListNew[i].operator + ' ： ' + solveListNew[i].content + '</div>');
                    }

                    parent.search(parseInt(parent.$('.active').attr('jp-data')));

                }else{
                    layer.alert(data.msg, {icon : 5});
                }
            },
            error: function(){
                layer.alert('系统错误', {icon : 5});
            }
        });
    }
</script>