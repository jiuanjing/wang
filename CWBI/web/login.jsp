<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Random" %>
<%
    Random rand = new Random();
    long randnum = Math.abs(rand.nextLong());
%>
<!DOCTYPE html>
<html>
<head>
    <title>北京首创股份有限公司-经营决策系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- 页面 -->
    <script src="scripts/lib/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="scripts/lib/aYin/aYin.min.js"></script>
    <script src="scripts/lib/bootstrap/js/bootstrap.js"></script>
    <script src="scripts/lib/chart/Chart.js"></script>
    <link rel="stylesheet" type="text/css" href="scripts/lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="scripts/lib/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="scripts/lib/aYin/aYin.min.css">
    <!--[if lt IE 9]>
     <script src="scripts/lib/ie8/ie8-responsive-file-warning.js"></script>
     <script src="scripts/lib/ie8/html5shiv.min.js"></script>
     <script src="scripts/lib/ie8/respond.min.js"></script>
   <![endif]-->
    <script type="text/javascript" src="scripts/jquery.easyui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="scripts/easyui-1.3.6/themes/pepper-grinder/easyui.css">
    <link rel="stylesheet" type="text/css" href="scripts/easyui-1.3.6/themes/icon.css">
    <!-- method -->
    <script type="text/javascript" src="scripts/login/jsBase64.js"></script>
    <script type="text/javascript" src="scripts/login/auth.js"></script>
    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        .wrap {
            width: 100%;
            height: 100%;
            background-image: url(images/login/bg.jpg);
            z-index: -1;
        }

        .main {
            width: 937px;
            height: 580px;
            margin-left: auto;
            margin-right: auto;
            position: relative;
        }

        .wrap-box {
            height: 374px;
            width: 937px;
            position: absolute;
            top: 180px;
        }

        .control-image {
            float: left;
        }

        .wrap-image {
            width: 937px;
            height: 60px;
            position: absolute;
            top: 120px;
        }

        .logo {
            float: left;
            margin-top: 5px;
        }

        .title {
            float: right;
            margin-top: 15px;
        }

        .footer {
            color: #fff;
            text-align: right;
            line-height: 32px;
            font-size: 14px;
            font-family: "宋体", Georgia, Serif;
        }

        .footer a {
            color: #fff;
        }

        .control-box {
            padding: 20px;
            float: right;
            height: 374px;
            width: 400px;
            background-color: #fff;
        }

        .nav-tabs {
            padding: 0 0 0 12px;
        }

        .nav-tabs li a {
            width: 168px;
            text-align: center;
        }

        .tab-content {
            padding: 20px;
        }

        .tab-content .tab-pane {
        }

        .tab-content .tab-pane .tab-footer {
            position: absolute;
            line-height: 40px;
            padding: 0 0 2px;
            10px;
            left: 537px;
            bottom: 0;
            width: 400px;
            height: 40px;
            background-color: #f5f5f5;
        }

        .input-wrap {
        }

        .input-wrap li {
            padding: 20px 0;
        }

        .input-wrap2 li {
            padding: 10px 0;
        }

        .file {
            position: relative;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 10px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }

        .file input {
            position: absolute;
            font-size: 22px;
            right: 0;
            top: 0;
            opacity: 0;
        }
    </style>
    <script type="text/javascript" charset="utf-8">
        $(function () {
            $(".god-wrap").css("padding-top", ($(window).height() - 650) / 2 + "px");
            $('#win1').window({
                width: 400,
                height: 300,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                closed: true,
                modal: true
            });
            $('#win2').window({
                width: 400,
                height: 360,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                closed: true,
                modal: true
            });
            $('#win3').window({
                width: 400,
                height: $(window).height() - 100,
                collapsible: false,
                minimizable: false,
                maximizable: false,
                closed: true,
                modal: true
            });
            $('#tt').tree({
                url: 'common/DoAjaxGetCompany_Login.jsp',
                method: 'post',
                animate: true,
                cascadeCheck: false,
                onClick: function (node) {
                    $("#UK_CompanyName").val(node.text);
                    $("#CK_CompanyName").val(node.text);
                    var cookies = getCookie("CompanyName");
                    if (cookies == "" || cookies == null) {
                        setCookie("CompanyName", node.text);
                    } else {
                        if (cookies != node.text) {
                            setCookie("CompanyName", node.text);
                        }
                    }
                    $('#win3').window('close');
                }
            });
            var CompanyName = getCookie("CompanyName");
            if (CompanyName != "" || CompanyName != null) {
                $("#UK_CompanyName").val(CompanyName);
                $("#CK_CompanyName").val(CompanyName);
            }
        });
        //写cookies
        function setCookie(name, value) {
            var Days = 65;
            var exp = new Date();
            exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
            document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
        }

        //读取cookies
        function getCookie(name) {
            var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");

            if (arr = document.cookie.match(reg))

                return unescape(arr[2]);
            else
                return null;
        }
        //删除cookies
        function delCookie(name) {
            var exp = new Date();
            exp.setTime(exp.getTime() - 1);
            var cval = getCookie(name);
            if (cval != null)
                document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
        }

        function UKTabClick() {
            $('#textfield').val("");
            $('#textfield1').val("");
            $('#CK_cert').val("");
        }
        function CKTabClick() {
            $('#UK_cert').val("");
        }
        function UK_submit() {
            var form = document.getElementById("UKLogin");
            if (doEkeyAuth()) {
                form.submit();
            }
        }
        function CK_submit() {
            var form = document.getElementById("CKLogin");
            form.CompanyName.value = $('#CK_CompanyName').val();
            if (doCertfileAuth()) {
                form.submit();
            }
        }

        //修改UK密码
        function modifyUKPW() {
            $('#win1').window('open');
        }
        function modifyCKPW() {
            $('#win2').window('open');
        }
        //选择公司
        function selectCompany() {
            $('#win3').window('open');
        }
    </script>
</head>
<body>
<div class="wrap">
    <div class="main">
        <div class="wrap-image">
            <div class="logo"><img alt="" src="images/login/logo.png"></div>
            <div class="title"><img alt="" src="images/login/title.png"></div>
        </div>
        <div class="wrap-box">
            <div class="control-image">
                <img alt="" src="images/login/img.jpg">
            </div>
            <div class="control-box">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs " role="tablist">
                    <li role="presentation" class="active"><a onclick="UKTabClick();" href="#ukey" aria-controls="ukey"
                                                              role="tab" data-toggle="tab">UKey登录</a></li>
                    <li role="presentation"><a onclick="CKTabClick();" href="#cert" aria-controls="cert" role="tab"
                                               data-toggle="tab">证书登录</a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="ukey">
                        <form id="UKLogin" name="UKLogin" method="post" action="LoginServlet">
                            <ul class="input-wrap">
                                <li>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-addon" style="background-color:#fff;"><i
                                                class="fa fa-building-o"></i></span>
                                        <input type="text" id="UK_CompanyName" name="CompanyName"
                                               onfocus="selectCompany();" class="form-control" placeholder="公司名称"
                                               aria-describedby="sizing-addon2">
                                    </div>
                                </li>
                                <li>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-addon" style="background-color:#fff;"><i
                                                class="fa fa-lock"></i></span>
                                        <input type="password" id="UK_cert" name="cipher" class="form-control"
                                               placeholder="密码" aria-describedby="sizing-addon2">
                                    </div>
                                </li>
                                <li>
                                    <!-- <input type="hidden" name="userPIN" value="" />
                                           <input type="hidden" name="authType" value="ukey">
                                           <input type="hidden" name="appId" value="310" /> -->
                                    <input type="hidden" name="randnum" value="<%=randnum%>"/>
                                    <button class="btn btn-lg btn-primary" onclick="UK_submit();" style="width:100%;"
                                            type="button">登录
                                    </button>
                                </li>
                            </ul>
                        </form>
                        <div class="tab-footer">
                            <!-- <i class="fa fa-caret-right" style="margin:0 28px 0 50px;">系统插件测试页</i> -->
                            <i class="fa fa-caret-right" style="margin:0 28px 0 28px;"><a
                                    href="javascript:modifyUKPW();">修改UKey登录密码</a></i>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="cert">
                        <form id="CKLogin" name="CKLogin" method="post" action="LoginServlet">
                            <ul class="input-wrap2">
                                <li>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-addon" style="background-color:#fff;"><i
                                                class="fa fa-building-o"></i></span>
                                        <input type="text" id="CK_CompanyName" name="CompanyName"
                                               onfocus="selectCompany();" class="form-control" placeholder="公司名称"
                                               aria-describedby="sizing-addon2">
                                    </div>
                                </li>
                                <li>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-addon" style="background-color:#fff;"><i
                                                class="fa fa-file-o"></i></span>
                                        <input type="text" class="form-control" id="textfield" name="tempfile"
                                               placeholder="证书文件" aria-describedby="sizing-addon2">
                                        <span class="input-group-btn">
                                    <a href="javascript:void(0);" class="btn btn-default file">选择文件 <input
                                            class="file_input" type="file" name="textfield1" id="textfield1"
                                            onchange="document.getElementById('textfield').value=this.value"></a>
                                  </span>
                                    </div>
                                </li>
                                <li>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-addon" style="background-color:#fff;"><i
                                                class="fa fa-lock"></i></span>
                                        <input type="password" id="CK_cert" name="cipher" class="form-control"
                                               placeholder="密码" aria-describedby="sizing-addon2">
                                    </div>
                                </li>
                                <li>
                                    <!-- <input type="hidden" name="userPIN" value="" />
                                       <input type="hidden" name="authType" value="cert">
                                       <input type="hidden" name="appId" value="310" /> -->
                                    <input type="hidden" name="randnum" value="<%=randnum%>"/>
                                    <button class="btn btn-lg btn-primary" onclick="CK_submit();" style="width:100%;"
                                            type="button">登录
                                    </button>
                                </li>
                            </ul>
                        </form>
                        <div class="tab-footer">
                            <!-- <i class="fa fa-caret-right" style="margin:0 28px 0 50px;">系统插件测试页</i> -->
                            <i class="fa fa-caret-right" style="margin:0 28px 0 28px;"><a
                                    href="javascript:modifyCKPW()">修改证书密码</a></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer">Copyright ©版权所有 <a href="http://www.capitalwater.cn" target="_blank"> 北京首创股份有限公司</a>
            </div>
        </div>
    </div>
</div>

<div id="win1" iconCls="icon-edit" title="修改UKey登录密码">
    <div style="padding: 30px 30px; height:100%;">
        <input type="password" name="KeyPIN_OLD" class="form-control" style="margin: 5px 0;" placeholder="旧密码"
               aria-describedby="sizing-addon2">
        <input type="password" name="KeyPIN_NEW1" class="form-control" style="margin: 5px 0;" placeholder="新密码"
               aria-describedby="sizing-addon2">
        <input type="password" name="KeyPIN_NEW2" class="form-control" style="margin: 5px 0;" placeholder="重新输入新密码"
               aria-describedby="sizing-addon2">
        <button class="btn btn-lg btn-primary" onclick="changeKeyPIN();" style="width:100%;margin-top: 10px;"
                type="button">确定
        </button>
    </div>
</div>
<div id="win2" iconCls="icon-edit" title="修改证书密码">
    <div style="padding: 15px 30px; height:100%;">
        <a href="javascript:void(0);" class="btn file">选择文件 <input class="file_input" type="file" name="textfield2"
                                                                   id="textfield2"
                                                                   onchange="document.getElementById('textfield3').value=this.value"></a>
        <input type="text" class="form-control" id="textfield3" name="textfield3" style="margin: 5px 0;"
               placeholder="证书文件" aria-describedby="sizing-addon2">
        <input type="password" name="CertPIN_OLD" class="form-control" style="margin: 5px 0;" placeholder="旧密码"
               aria-describedby="sizing-addon2">
        <input type="password" name="CertPIN_NEW1" class="form-control" style="margin: 5px 0;" placeholder="新密码"
               aria-describedby="sizing-addon2">
        <input type="password" name="CertPIN_NEW2" class="form-control" style="margin: 5px 0;" placeholder="重新输入新密码"
               aria-describedby="sizing-addon2">
        <button class="btn btn-lg btn-primary" onclick="changeCertPIN();" style="width:100%;margin-top: 10px;"
                type="button">确定
        </button>
    </div>
</div>
<div id="win3" iconCls="icon-edit" title="选择公司(单击选择)">
    <div style="height:100%;">
        <ul id="tt"></ul>
    </div>
</div>
</body>
<OBJECT CLASSID="CLSID:F83A15A2-BAD8-465E-85C4-74ACB165924C" ID="SafeCtrl" onerror="SafeCtrlCOMErrorTrap();"></OBJECT>
</html>