<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <!-- Bootstrap Core CSS -->
    <link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- validator -->
    <link href="<%=request.getContextPath()%>/bootstrap/plugin/validator/popover.css" rel="stylesheet">
</head>
<body>
<div id="page-wrapper" style="padding: 0 15px;">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <form id="myForm">
                                <br>
                                <input type="hidden" id="frontUserId" value="${userFront.id}">
                                <input type="hidden" id="userInfoId" value="${userInfo.id}">
                                <input type="hidden" id="orgEmpId" value="${orgEmp.id}">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="input-group">
                                            <span class="input-group-addon">公司名称</span>
                                            <input type="text" class="form-control" value="${compName}" disabled="disabled">
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称</span>
                                            <input type="text" class="form-control" id="nickName" name="nickName" value="${userFront.nickName}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">真实姓名</span>
                                            <input type="text" class="form-control" id="name" name="name" value="${userInfo.name}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">身份证号</span>
                                            <input type="text" class="form-control" id="idCard" name="idCard" value="${userFront.idCard}" readonly>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</span>
                                            <select class="form-control" id="sex" name="sex">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱</span>
                                            <input type="text" class="form-control" id="email" name="email" value="${userFront.email}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机</span>
                                            <input type="text" class="form-control" id="phone" name="phone" value="${userFront.phone}" onchange="checkPhone();" readonly>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">住宅电话</span>
                                            <input type="text" class="form-control" id="homeTel" name="homeTel" value="${userInfo.homeTel}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编</span>
                                            <input type="text" class="form-control" id="postCode" name="postCode" value="${userInfo.postCode}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">QQ号码</span>
                                            <input type="text" class="form-control" id="qq" name="qq" value="${userInfo.qq}">
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历</span>
                                            <select class="form-control" id="education" name="education">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">婚姻状况</span>
                                            <select class="form-control" id="marriageStatus" name="marriageStatus">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">有无子女</span>
                                            <select class="form-control" id="childStatus" name="childStatus">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">就业状况</span>
                                            <select class="form-control" id="employmentSituation" name="employmentSituation">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">公司部门</span>
                                            <select class="form-control" id="orgId" name="orgId">

                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">公司职位</span>
                                            <select class="form-control" id="positId" name="positId">

                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">收入/月</span>
                                            <input type="text" class="form-control" id="income" name="income" value="${userInfo.income}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">社保/公积金</span>
                                            <select class="form-control" id="socialSecurity" name="socialSecurity">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">员工编号</span>
                                            <input type="text" class="form-control" id="empno" name="empno" value="${orgEmp.empno}" readonly>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">紧急联系人</span>
                                            <input type="text" class="form-control" id="contPerson" value="${orgEmp.contPerson}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">紧急联系人电话</span>
                                            <input type="text" class="form-control" id="contPhone" value="${orgEmp.contPhone}">
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="input-group" id="financialSituationData">

                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="input-group">
                                            <span class="input-group-addon">选择居住地区</span>
                                            <input type="text" class="form-control" id="liveAreaCodeName" name="liveAreaCodeName" readonly="readonly" value="${liveAreaCodeName}" onclick="getArea('liveAreaCode','liveAreaCodeName');">
                                            <input type="hidden" id="liveAreaCode" value="${userInfo.liveAreaCode}">
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="input-group">
                                            <span class="input-group-addon">居住街道地址</span>
                                            <input type="text" class="form-control" id="liveAddress" value="${userInfo.liveAddress}">
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-5">
                                        <div class="input-group">
                                            <span class="input-group-addon">选择户籍地区</span>
                                            <input type="text" class="form-control" id="houseAreaCodeName" name="houseAreaCodeName" readonly="readonly" value="${houseAreaCodeName}" onclick="getArea('houseAreaCode','houseAreaCodeName');">
                                            <input type="hidden" id="houseAreaCode" value="${userInfo.houseAreaCode}">
                                        </div>
                                    </div>
                                    <div class="col-xs-7">
                                        <div class="input-group">
                                            <span class="input-group-addon">户籍街道地址</span>
                                            <input type="text" class="form-control" id="houseAddress" value="${userInfo.houseAddress}">
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
<!-- validate -->
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/ga.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.bootstrap.popover.js"></script>
<script>
    $(document).ready(function() {
        var compPositData = $.parseJSON('${compPositList}');
        for (var i = 0; i < compPositData.length; i++) {
            $(new Option(compPositData[i].name,compPositData[i].id)).appendTo('#positId');
        }
        $('#positId').val('${userInfo.positId}');

        var compOrgData = $.parseJSON('${compOrgList}');
        for (var i = 0; i < compOrgData.length; i++) {
            $(new Option(compOrgData[i].name,compOrgData[i].id)).appendTo('#orgId');
        }
        $('#orgId').val('${orgEmp.orgId}');

        var sexData = $.parseJSON('${sexList}');
        for (var i = 0; i < sexData.length; i++) {
            $(new Option(sexData[i].dicDataName,sexData[i].dicDataValue)).appendTo('#sex');
        }
        $('#sex').val('${userInfo.sex}');

        var educationData = $.parseJSON('${educationList}');
        for (var i = 0; i < educationData.length; i++) {
            $(new Option(educationData[i].dicDataName,educationData[i].dicDataValue)).appendTo('#education');
        }
        $('#education').val('${userInfo.education}');

        var marriageStatusData = $.parseJSON('${marriageStatusList}');
        for (var i = 0; i < marriageStatusData.length; i++) {
            $(new Option(marriageStatusData[i].dicDataName,marriageStatusData[i].dicDataValue)).appendTo('#marriageStatus');
        }
        $('#marriageStatus').val('${userInfo.marriageStatus}');

        var childStatusData = $.parseJSON('${childStatusList}');
        for (var i = 0; i < sexData.length; i++) {
            $(new Option(childStatusData[i].dicDataName,childStatusData[i].dicDataValue)).appendTo('#childStatus');
        }
        $('#childStatus').val('${userInfo.childStatus}');

        var employmentSituationData = $.parseJSON('${employmentSituationList}');
        for (var i = 0; i < employmentSituationData.length; i++) {
            $(new Option(employmentSituationData[i].dicDataName,employmentSituationData[i].dicDataValue)).appendTo('#employmentSituation');
        }
        $('#employmentSituation').val('${userInfo.employmentSituation}');

        var socialSecurityData = $.parseJSON('${socialSecurityList}');
        for (var i = 0; i < socialSecurityData.length; i++) {
            $(new Option(socialSecurityData[i].dicDataName,socialSecurityData[i].dicDataValue)).appendTo('#socialSecurity');
        }
        $('#socialSecurity').val('${userInfo.socialSecurity}');

        var financialSituationData = $.parseJSON('${financialSituationList}');
        var financialSituation = [];
        if('${userInfo.financialSituation}' != null && '${userInfo.financialSituation}' != ''){
            financialSituation = $.parseJSON('${userInfo.financialSituation}');
        }
        var str = '<span class="input-group-addon" >财力状况</span>&nbsp;&nbsp;&nbsp;&nbsp;';
        for (var i = 0; i < financialSituationData.length; i++) {
            str = str + '<label class="checkbox-inline"><input type="checkbox" name="financialSituation" id="financialSituation' + i + '" value="'+ financialSituationData[i].dicDataValue + '"';
            if (financialSituation != null) {
                for (var j = 0; j < financialSituation.length; j++) {
                    if (financialSituationData[i].dicDataValue == financialSituation[j]) {
                        str = str + 'checked="checked"';
                    }
                }
            }
            str = str + '>' + financialSituationData[i].dicDataName + ' </label>';
        }
        $("#financialSituationData").html(str);

        $.validator.addMethod("phone",function(value,element,params){
            if(!(/^1[3|4|5|7|8]\d{9}$/.test(value))){
                return false;
            }else{
                return true;
            }
        },"请输入正确的手机号码");

        $.validator.addMethod("idCard",function(value,element,params) {
            if(!(/^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/.test(value))){
                return false;
            }else{
                return true;
            }
        },"请输入正确的身份证号码");

        $.validator.addMethod("idCard",function(value,element,params) {
            var isTrue = true;
            if(value != null && value != ''){
                $.ajax({
                    url: '<%=request.getContextPath()%>/admin/userFront/checkIdCard',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: {
                        idCard:value,
                        id:'${sysUserImportInfo.id}'
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
        },"当前身份证号码已在员工中存在");

        $.validator.addMethod("finance",function(value,element,params){
            if(!(/^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/.test(value))){
                return false;
            }else{
                return true;
            }
        },"请输入正确的金额");

        $.validator.addMethod("myNumber",function(value,element,params){
            if(!(/^[0-9]*$/.test(value))){
                return false;
            }else{
                return true;
            }
        },"请输入正确的QQ号码");

        $.validator.addMethod("tel",function(value,element,params){
            if(!(/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/.test(value))){
                return false;
            }else{
                return true;
            }
        },"请输入正确的座机号码");

        $.validator.addMethod("checkEmpNo",function(value,element,params){
            var isTrue = true;
            if(value != null && value != ''){
                if('${orgEmp.empno}' == value){
                    return true;
                }
                $.ajax({
                    url: '<%=request.getContextPath()%>/admin/userFront/checkEmpNo',
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: {
                        empno:value
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
        },"当前员工编号已在员工中存在");

        $('#myForm').validate_popover({
            onsubmit:true,
            rules: {
                nickName: {
                    required: true
                },
                name: {
                    required: true
                },
                idCard: {
                    required: true
                },
                email: {
                    required: true,
                    email:true
                },
                phone: {
                    required: true,
                    phone:true
                },
                empno: {
                    required: true
                },
                positId: {
                    required: true
                },
                income: {
                    finance: true
                },
                qq: {
                    myNumber: true
                },
                homeTel: {
                    tel: true
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
        $('input[name="financialSituation"]:checked').each(function(){
            chk_value.push($(this).val());
        });
        if(chk_value.length > 0){
            jsonData.financialSituation = JSON.stringify(chk_value);
        }else{
            jsonData.financialSituation = '';
        }

        $.ajax({
            url: '<%=request.getContextPath()%>/admin/subCompany/editEmployee',
            dataType: 'json',
            type: 'POST',
            data: jsonData,
            success: function (data) {
                if(data.status == 'ok'){
                    parent.search(parseInt(parent.$('.active').attr('jp-data')));
                    closePage();
                }else{
                    layer.alert(data.msg, {
                        icon : 5
                    });
                }
            },
            error: function(){
                layer.alert('系统错误', {
                    icon : 5
                });
            }
        });
    }

    //校验手机号码是否重复
    function checkPhone(){
        if($('#phone').val() == '' || $('#lealPhone').val() ==null){
            return;
        }

        if('${userFront.phone}' == $('#phone').val()){
            return;
        }
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/userFront/selectByPhone',
            dataType: 'json',
            type: 'POST',
            data: {
                phone:$('#phone').val()
            },
            success: function (data) {
                if(data.status != 'ok'){
                    $('#phone').val('');
                    layer.alert(data.msg, {
                        icon : 5
                    });
                }
            },
            error: function(){
                layer.alert('系统错误', {
                    icon : 5
                });
            }
        });
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
    }
</script>
</body>
</html>