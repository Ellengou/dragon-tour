<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/10/25
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="utf-8">
<% String ucagentUrl = "http://192.168.10.201:8080"; %>
<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript"
        src="<%=ucagentUrl %>/ucagent/jquery/jquery.atmosphere.js"></script>
<script type="text/javascript"
        src="<%=ucagentUrl %>/ucagent/jquery/jquery.form.js"></script>
<script type="text/javascript"
        src="<%=ucagentUrl %>/ucagent/widgetJs/IAgentBar.js"></script>
<script type="text/javascript"
        src="<%=ucagentUrl %>/ucagent/widgetJs/common.js"></script>
<script type="text/javascript"
        src="<%=ucagentUrl %>/ucagent/widgetJs/AgentProfileDo.js"></script>
<script type="text/javascript"
        src="<%=ucagentUrl %>/ucagent/widgetJs/utilis.js"></script>
<script type="text/javascript"
        src="<%=ucagentUrl %>/ucagent/AgentBar.js"></script>
<script type="text/javascript">
    function getAgentBar(id) {
        var url = '<%=ucagentUrl %>';
        var agentBar = new AgentBar(url + "/ucagent", id, "ready");
        var mlist = [ {
            'status' : '免打扰',
            'lastTime' : 60 * 10
        } ];
        agentBar.setStatusMonitorList(mlist);
        agentBar.setPermissions("calledId;replaceCallId;taskBtn;agentPanelBtn;waitPanelBtn;dialogRecordBtn;configurePanelBtn;msgPanelId;inviteBtn;holdBtn;setMuteBtn;servesClosedBtn;returnBtn;endRehabilitationBtn;remarkBtn;meetingId;coachId;clientPhoneNumber;voiceTime;statusMenu;logoutToVirtual");
        agentBar.setIsUI("1");
        agentBar.insert(
                9,
                -1,
                {
                    id : "xq",
                    text : "小憩",
                    handler : function() {
                        var nowStatus = $.agentBar
                                .getLoginAgentStatus();
                        // 就绪、免打搅
                        if (nowStatus.extendState == "小憩") {
                            alert("已经是小憩状态，不允许重复设置");
                        } else if ((nowStatus.mainState == "beReadying" && nowStatus.extendState == "")
                                || (nowStatus.mainState == "noDisturb" && nowStatus.extendState == "")) {
                            sendNoDistrubToPortal(agentProfile.configure_userName, '小憩');
                        } else {
                            alert("该状态不允许小憩，请先就绪或者免打扰");
                        }
                    }
                });

        agentBar.insert(
                10,
                -1,
                {
                    id : "hxcl",
                    text : "后续处理",
                    handler : function() {
                        var nowStatus = $.agentBar.getLoginAgentStatus();
                        // 就绪、免打搅
                        if (nowStatus.extendState == "后续处理") {
                            alert("已经是后续处理状态，不允许重复设置!");
                        } else if ((nowStatus.mainState == "beReadying" && nowStatus.extendState == "")
                                || (nowStatus.mainState == "noDisturb" && nowStatus.extendState == "")) {
                            sendNoDistrubToPortal(agentProfile.configure_userName, '后续处理');
                        } else {
                            alert("该状态不允许后续处理，请先就绪或者免打扰!");
                        }
                    }
                });
        agentBar.load("taskBarid");
        //自动提醒
    }
    var userId = "";
    var newSessionId = "";
    var islocation = "https://crm.redlion56.com/gwcrm";
    function AutoMessage(msg) {
        rightBttomWindow("业务信息提醒", msg);
    }
    function AjaxJsonp(url, postData, callBack) {

        var reg = /^(https|http)?:\/\/[a-zA-Z0-9]+\.[a-zA-Z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
        if (reg.test(url)) {
            url = url;
        } else {
            url = islocation + url;
        }
        ;
        if (typeof postData == "string")
            postData = {};
        postData['sessionId'] = newSessionId;
        var ajaxTimeoutTest = $.ajax({
            url : url,
            type : "post",
            data : postData,
            timeout : 10000,
            dataType : "jsonp",
            jsonp : "callback",
            cache : false,
            async : false,
            headers : {
                "sessionId" : newSessionId
            },
            success : function(data) {
                if (data.success == false) {
                    if (data.errCode == "230017" || data.errCode == "230006") {
                        tipDialog(data.errMsg, 5, "0");
                        $.removeCookie('newSessionId', {
                            path : '/',
                            domain : 'redlion56.com'
                        });
                        $.removeCookie('userId', {
                            path : '/',
                            domain : 'redlion56.com'
                        });
                        top.Urlhref(Website + '/error/logout.html');
                        return false;
                    }
                    alert(data.errMsg)
                    return false;
                } else if (data.success == true) {
                    callBack(data.body);
                } else {
                    alert("访问数据错误");
                    return false;
                }
            },
            complete : function(XMLHttpRequest, status) { //请求完成后最终执行参数
                if (status == 'timeout') {//超时,status还有success,error等值的情况
                    ajaxTimeoutTest.abort();
                    alert("超时访问");
                    return false;
                }
                if (status != 'success') {
                    ajaxTimeoutTest.abort();
                    alert("访问数据错误");
                    return false;
                }
            }
        });
    }
    var IPCC_UNAME = '';
    $(function() {
        var IPCC_ENABLE = '1';
        IPCC_UNAME = '${ipccUname}';
        if (IPCC_UNAME == '') {
            layer.alert('未被分配IPCC座机号，请联系站点管理员', {
                icon: 5
            });
            return;
        }
        if(IPCC_ENABLE == 1){
            getAgentBar(IPCC_UNAME);
            $("#header").show();
        }

    });

    //document.component = "127.0.0.1"
    var crossDomain = false;
    //var agentProfile = new AgentProfileDo();
    function onInvite(jobId, fromNumber, toNumber, serviceType, callType, agentServiceID, phoneNumber, url) {
        var phone = fromNumber.match(/:+\S*?(?=@)/).toString().replace(/:/g, '');
        if (phone.substr(0, 1) == 0) {
            phone = phone.substr(1);
        }
        // 转后台数据
//        $('#iframe').attr('src','admin/ipcc/merchants/merchantsMainPage?source_number=' + phone + '&jobId=' + jobId);
//        location.href = 'admin/ipcc/merchants/merchantsMainPage?source_number=' + phone + '&jobId=' + jobId;
//                siMenu('z999', 'lm999', '客户来电', 'admin/ipcc/merchants/merchantsMainPage?source_number=' + phone + '&jobId=' + jobId);
        $('#indexPage').show();
        $('#homeHtml').hide();
        $('#iframe').attr('src', '<%=request.getContextPath()%>/admin/ipcc/merchants/merchantsMainPage?source_number=' + phone + '&jobId=' + jobId);

        $.agentBar.setJobId(jobId);
        $.agentBar.answer(jobId, phoneNumber, fromNumber, toNumber, type, url, function(result) {});
    }

    function setReady(){
        $.agentBar.updateStatusToReady(IPCC_UNAME, "",function (result){});
    }
</script>
<style type="text/css">
    .commitopacity {
        position: absolute;
        width: 100%;
        height: 100px;
        background: #7f7f7f;
        filter: alpha(opacity = 50);
        -moz-opacity: 0.8;
        -khtml-opacity: 0.5;
        opacity: 0.5;
        top: 0px;
        z-index: 99999;
    }

    #logBar {
        height: 39px!important;
        width: 100%!important;
    }
</style>

<div id="header" style="display: none;">
    <div>
        <table width="100%" height="39" cellspacing="0" cellpadding="0">
            <tr>
                <td width="100%" valign="top">
                    <div style="border: 1px" id="taskBarid"></div>
                </td>
            </tr>
        </table>
    </div>
    <div class="middleLayOut" style="display: none">
        <table width="100%" cellspacing="0" cellpadding="0" border=0>
            <tr>
                <td valign="top" width="100%">
                    <div id="dialogPortalDiv" style="dispaly: none"></div>
                </td>
            </tr>
        </table>
        <div class="messageBox" id="innerPhone"></div>
        <div class="messageBox" id="forumtree"></div>
    </div>
</div>