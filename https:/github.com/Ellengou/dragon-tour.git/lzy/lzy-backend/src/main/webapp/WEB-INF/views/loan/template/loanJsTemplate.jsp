<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script>
    //弹出口默认的高度设置
    var offset_h = ($(window).height() - window.screen.height/2)+'px';
    $("[data-toggle='tooltip']").tooltip();
    //还款方式
    $("#loanType").showList('option',{infoList:'${repayTypeMainList}',column_value:'id',selectValue:'${repayType}'})
    //借款奖励
    $("#jkjl").showList('radio',{infoList:'${scf_loan_jkjl}',name:'loanPrizeType',column_name:'dicDataName',column_value:'dicDataValue',selectValue:'${scfLoan.loanPrizeType}'});
    //标的性质
    $("#bdxz").showList('radio',{infoList:'${scf_1oan_elem}',name:'scfElemId',column_name:'dicDataName',column_value:'dicDataValue',selectValue:'${scfLoan.scfElemId}'});
    //筹标期限
    $("#deadLine").showList('option',{infoList:'${scf_loan_dead_line}',selectValue:'${scfLoan.deadLine}',emptySelect:false});
    //设置理财协议
    var procotolList = $.parseJSON('${procotolList}');
    var temp = '';
    for(var i = 0;i<procotolList.length ;i++){
        var obj = procotolList[i];

        temp+='<div class="panel panel-default">'
        temp+='<div class="panel-heading">'
        temp+='协议系列:'+obj.name
        temp+='</div>'
        temp+='<div class="panel-body">'
        var content = obj.contentTitles;
        for(var j=0;j<content.length;j++){
            var ct = content[j];
            temp+='<label>';
            temp+='<input type="checkbox" value="'+ct.id+'" onclick="setProcotolsValues()">'+ct.title;
            temp+='</label>';
        }
        temp+='</div>'
        temp+='</div>'
    }
    $("#div_pro").append(temp);

    function setProcotolsValues(){
        var rs = '';
        $("#div_pro").find("input[type=checkbox]").each(function(){
            var $this = $(this);
            var checked = $this.prop('checked');
            var val = $this.val();
            if(true == checked){
                rs += val+',';
            }
        })
        if('' != rs){
            rs = rs.substring(0,rs.length - 1);
            $("#procotols").val(rs);
        }else{
            $("#procotols").val(null);
        }
    }

    function redirect(target){
        $(top.window.parent.document).find(".active").attr('class','');
        var t = $(top.window.parent.document).find(target);
        t.attr('class','active');
        if(window.parent != top){
            window.parent.location = t.attr('href');
        }else{
            window.location = t.attr('href');
        }
    }
    function showMsg(msg,iconNum,redirectMenuId){
        var index = layer.alert(msg, {
            icon: iconNum,
            offset:offset_h
        },function(index){
            if(typeof redirectMenuId != 'undefined'){
                redirect("#"+redirectMenuId);
            }else{
                layer.close(index);
            }
        });
        return index;
    }

    var repayTypeMainList = '${repayTypeMainList}'
    function loanTypeChange(){
        var loanType=$("#loanType").val();
        //根据还款方式是否展示还款日
        var rList = $.parseJSON(repayTypeMainList);
        var showUnit;
        for(var i=0;i<rList.length;i++){
            var obj = rList[i];
            if(obj.id == loanType){
                if(obj.showUnit == '0'){
                    var template = '<label class="col-xs-2 control-label">还款日</label><div class="input-group col-xs-9"><input type="text" class="form-control" name="repayDate" id="repayDate" value="${scfLoan.repayDate}"><span class="input-group-addon">日</span></div>';
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
    }

    function getSerialNum(){
        var compCoreId = $("#compCoreId").val();
        $.get('<%=request.getContextPath()%>/admin/project/loan/getSerialNum?compCoreId='+compCoreId+'&type=${type}',function(data){
            data = $.parseJSON(data);
            $("#serialNum").val(data.json)
        });
    }

    //显示已上传的资料
    function showData(loanData){
        if('' !== loanData){
            loanData = $.parseJSON(loanData);
            var template = '';
            for(var i=0;i<loanData.length;i++){
                var data = loanData[i];
                template += '<div class="col-xs-4" style="cursor: pointer;" onclick="showPic('+data.id+')"><a class="thumbnail"><img src="<%=request.getContextPath()%>/admin/project/loan/getPic?id='+data.id+'" alt="'+data.name+'"></a>'+data.name+'</div>';
            }
            $("#loanData").append(template);
        }
    }
    //大图展示单张图片
    function showPic(id){
        var url = '<%=request.getContextPath()%>/admin/project/loan/getPic?id='+id;
        layer.photos({
            photos: {"data": [{"src": url}]}
        });
    }

    $('#fbsj').datetimepicker({
        format: 'yyyy-mm-dd hh:ii:00',
        language:'zh-CN',
        weekStart: 1,
        todayHighlight:true,
        autoclose:true,
        pickerPosition: "bottom-left",
        linkField: "startInvestTime",
        linkFormat:'yyyy-mm-dd hh:ii:00'
    });
    $('#kssj').datetimepicker({
        format: 'yyyy-mm-dd hh:ii:00',
        language:'zh-CN',
        weekStart: 1,
        todayHighlight:true,
        autoclose:true,
        pickerPosition: "bottom-left"
    });

    function setInvestType(checkBox,id){
        var ckArr =$("input[name='check_inver']");
        var inversType = "";
        for(var i=0;i<ckArr.length;i++){
            var obj = ckArr[i];
            if(obj.checked){
                inversType += obj.value+",";
            }
        }
        if(inversType.length>0){
            inversType =  inversType.substring(0,inversType.length-1);
        }
        $("#investType").val(inversType);
    }
    function setPledgeCompanyInfo(frontUserId){
        $("#pledgeCompanyId").empty();
        var compCoreId = $("#compCoreId").val();
        var url = "<%=request.getContextPath()%>/admin/company/queryCompanysByGys?frontUserId="+frontUserId+'&compCoreId='+compCoreId;
        $.get(url, function (data) {
            data = $.parseJSON(data);
            if(data.status == 'ok'){
                var companys = $.parseJSON(data.json);
                if(null != companys && companys.length > 0){
                    $("#pledgeCompanyId").showList('option',{infoList:companys,column_value:'id',column_name:'name',selectValue:'${scfLoan.pledgeCompanyId}'})
                }
            }
        });
    }
    //存放剩余可用额度
    var bc = null;

    function pledgeCompanyChange(pledgeCompanyId){
        var frontUserId = $("#frontUserId").val();
        var type = $("input[name='businessType']").val();
        if(null != frontUserId && "" != frontUserId && null != pledgeCompanyId && ""!= pledgeCompanyId){
            $.get('<%=request.getContextPath()%>/admin/userSupp/getCredit?frontUserId='+frontUserId+'&pledgeCompanyId='+pledgeCompanyId+'&type='+type,function(data){
                data = $.parseJSON(data);
                var rs = $.parseJSON(data.json);
                if(null != rs){
                    balanceCredit = rs.balanceCredit
                    bc = balanceCredit;
                }else{
                    balanceCredit = 0;
                    bc = null;
                }
                $("#productScale").rules("remove");
                $("#productScale").rules("add",{required: true,max:balanceCredit,number:true,messages:{max:"不能大于最大额度"+balanceCredit+'元'}});
                $("#productScale").attr('placeholder','可用额度'+balanceCredit);
                $("#loanMoney").rules("remove");
                $("#loanMoney").rules("add",{required: true,max:balanceCredit,number:true,messages:{max:"不能大于最大额度"+balanceCredit+'元'}});
                $("#loanMoney").attr('placeholder','可用额度'+balanceCredit);
            });
        }else{
            $("#productScale").rules("remove");
            $("#productScale").attr('placeholder','请选择质押公司');
            $("#loanMoney").rules("remove");
        }
    }
    $("#pledgeCompanyId").change(function(){
        var pledgeCompanyId = $("#pledgeCompanyId").val();
        pledgeCompanyChange(pledgeCompanyId);
    });
    function clearSub(){
        $("#frontUserId").val(null);
        $("#userFrontName").val(null);
        $("#pledgeCompanyId").empty();
    }

    function getValues(){
        var jsonData = $("form").serializeArray();
        var introductions = $('#summernote').summernote('code');
        var commonProblem = $('#commonProblem').summernote('code');
        var procotols;
        var userLoanId = $("#userLoanId").val();
        var jStr = "{ ";
        for(var i=0;i<jsonData.length;i++){
            //协议另外处理
            if('procotols' == jsonData[i].name){
                procotols = jsonData[i].value;
            }else{
                if(null != jsonData[i].value && ''!=jsonData[i].value){
                    jStr += "\""+jsonData[i].name+"\":\""+jsonData[i].value+"\",";
                }
            }
        }
        jStr = trimSplit(jStr,",");
        jStr += " }";
        var json = {data:jStr,introductions:introductions,procotols:procotols,commonProblem:commonProblem};
        if(null != userLoanId){
            json.userLoanId = userLoanId;
        }
        return json;
    }
    function trimSplit(str,split){
        if(null != str && str.length > 0){
            if(str.charAt(str.length - 1) == split){
                return str.substring(0,str.length - 1);
            }
        }
        return str;
    }
    function tmpSave(url){
        var productScale = $("#productScale").val();
        if(null != productScale && ''!= productScale){
            if(bc == null || bc < productScale){
                layer.alert('申请额度不能大于用户可用余额')
                return;
            }
        }
        layer.msg('数据开始保存....',{offset:offset_h});
        var jStr = getValues();
        $.ajax({
            dataType: 'json',
            type:'POST',
            url:url,
            data:getValues(),
            success:function(data){
                if(data.status == 'ok'){
                    $("#dataFile").fileinput('upload');
                    showMsg('暂时保存成功',1,"menu139");
                    //上传文件
                }else{
                    showMsg(data.msg,5)
                }
            },
            error: function () {
                showMsg('系统错误',5)
            }
        });
    }

    function save(url,redirectMenuId){
        layer.confirm('确认保存?', {icon: 3, title:'提示',offset: offset_h}, function(index){
            layer.msg('数据开始保存....',{offset:offset_h});
            var jStr = getValues();
            $.ajax({
                dataType: 'json',
                type:'POST',
                url:url,
                data:getValues(),
                success:function(data){
                    if(data.status == 'ok'){
                        //上传文件
                        $("#dataFile").fileinput('upload');
                        showMsg('保存成功',1,redirectMenuId);
                        $("input").each(function(){
                            $(this).attr('disabled','disabled');
                        })
                        $("selectByPrimaryKey").each(function(){
                            $(this).attr('disabled','disabled');
                        })
                        $("#div_buttons").remove();

                    }else{
                        showMsg(data.msg,5)
                    }
                },
                error: function () {
                    showMsg('系统错误',5)
                }
            });
            layer.close(index);
        });
    }

    //产品详情
    $('#summernote').summernote({
        lang: 'zh-CN',
        height: 180
    });
    //常见问题
    $('#commonProblem').summernote({
        lang: 'zh-CN',
        height: 180
    });
    function showPro(id){
        var index = layer.open({
            type: 2,
            offset: [100,(($(window).width()-900)/2)],
            title: false,
            content: '<%=request.getContextPath()%>/admin/protocolType/view?id=' + id
        });
        layer.full(index);
    }

    function cleanFrontUserId(){
        var userFrontName = $("#userFrontName").val();
        if(null == userFrontName || '' == userFrontName){
            $("#frontUserId").val(null);
        }
    }
</script>