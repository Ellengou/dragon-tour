<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/11/7
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="utf-8">
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                咨询内容录入
            </div>
            <div class="panel-body">
                <form id="myForm">
                    <input type="hidden" class="form-control" name="detailId" id="detailId">
                    <input type="hidden" class="form-control" name="consultId" id="consultId">
                    <input type="hidden" class="form-control" name="solveId" id="solveId">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-addon">咨询方式</span>
                                <select class="form-control" id="consultingApproach" >
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group input-group">
                                <span class="input-group-addon">咨询类型</span>
                                <select class="form-control" id="consultingBusiness">
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group input-group">
                                <span class="input-group-addon">处理状态</span>
                                <select class="form-control" id="status" >
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

<script>
    $(function () {
        var approachList = $.parseJSON('${approachList}');
        for (var i = 0; i < approachList.length; i++) {
            $(new Option(approachList[i].dicDataName, approachList[i].dicDataValue)).appendTo('#consultingApproach');
        }

        var statusList = $.parseJSON('${statusList}');
        for (var i = 0; i < statusList.length; i++) {
            $(new Option(statusList[i].dicDataName, statusList[i].dicDataValue)).appendTo('#status');
        }

        var businessList = $.parseJSON('${businessList}');
        for (var i = 0; i < businessList.length; i++) {
            $(new Option(businessList[i].name, businessList[i].id)).appendTo('#consultingBusiness');
        }
    })

    function submitCon() {
        //询问框
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/ipcc/detail/add',
            dataType: 'json',
            type: 'POST',
            data: {
                detailId:$('#detailId').val(),
                consultId:$('#consultId').val(),
                solveId:$('#solveId').val(),
                consultingApproach: $('#consultingApproach').val(),
                consultingBusiness: $('#consultingBusiness').val(),
                status: $('#status').val(),
                consultContent: $('#consultContent').val(),
                solveContent: $('#solveContent').val(),
                phone:'${phone}',
                jobId:'${jobId}'
            },
            success: function (data) {
                if(data.status == 'ok'){
                    layer.closeAll('dialog');
                    layer.alert('保存成功', {icon : 6});
                    $('#detailId').val(data.msg.detailId);
                    $('#consultId').val(data.msg.consultId);
                    $('#solveId').val(data.msg.solveId);
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