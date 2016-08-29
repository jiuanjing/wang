<%
    /*********************************************************************************************************************
     *程序名称：MainFrame.jsp
     *功能描述：用户登录后的主框架，左边是导航栏，右边显示具体内容
     *编写人：万怀
     *编写时间：2014-09-24
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,java.sql.ResultSet" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    //检查用户权限
    /****
     if(CheckUserRight.check(userInfo,"107","1",pageContext) == false)
     {
     return ;
     }//检查用户权限代码结束
     *****/
    String UserID = "";
    String UserAccount = "";
    String UserName = "";
    String UserPassword = "";
    UserID = Integer.toString(userInfo.getUserID());
    UserAccount = userInfo.getUserAccount();
    UserName = userInfo.getUserName();
    UserPassword = userInfo.getUserPassword();

    if (!(userInfo.getUserID() > 0)) {
        out.println("<script language='javascript'>alert('您还没有登录，请从登录页面进入系统!');window.location.href='../login.jsp';</script>");
    }

    String TopicID = "";
    String str_navi_tree_html = "";
    /****TopicID = request.getParameter("TopicID");
     if((TopicID==null || TopicID != ""))
     {
     TopicID = "1";
     }****/
    //实例化数据库链接
    DBOperation db = new DBOperation();

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            /***Level1一级菜单--分析主题---开始****/
            String sql_count1 = "select count(*) from bim.user_info a,bim.role_module c,bim.module d";
            sql_count1 = sql_count1 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1";
            sql_count1 = sql_count1 + " and d.module_level=1 and c.right_type=1";

            String sql_level1 = "select d.module_id,module_code,module_name,URL from bim.user_info a,bim.role_module c,bim.module d";
            sql_level1 = sql_level1 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1";
            sql_level1 = sql_level1 + " and d.module_level=1 and c.right_type=1";
            sql_level1 = sql_level1 + " order by d.order_no";

            ResultSet rs_count1 = null;
            ResultSet rs_level1 = null;

            rs_count1 = db.executeQuery(sql_count1);//
            rs_level1 = db.executeQuery(sql_level1);//通过数据库访问程序返回一个可滚动的记录集

            if (rs_count1 == null) {
                throw new Exception("对不起！系统在查询数据库时出错1");
            }
            if (rs_level1 == null) {
                throw new Exception("对不起！系统在查询数据库时出错2");
            }
            int i1 = 0;
            if (rs_count1.next()) {
                i1 = rs_count1.getInt(1);
            }
            if (i1 >= 1) {
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>欢迎访问经营决策系统</title>
    <link rel="stylesheet" type="text/css" href="../scripts/easyui-1.3.6/themes/myself/easyui.css">
    <link rel="stylesheet" type="text/css" href="../scripts/easyui-1.3.6/themes/icon.css">
    <script type="text/javascript" src="../scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../scripts/easyui-1.3.6/jquery.easyui.min.js"></script>
    <style>
        a {
            text-decoration: none
        }

        *:focus {
            noFocusLine: expression(this.onFocus=this.blur());
        }

        .north {
            height: 88px;
            background-color: #FFFFFF;
            border-bottom: 1px ridge #eff4f7;
        }

        .north_logo {
            height: 88px;
            width: 200px;
        / / 宽度同左侧导航栏宽度 position: absolute;
            float: left;
            background-color: #3c96c9;
        }

        .north_nav {
            height: 88px;
            width: 972px;
            float: left;
            margin-left: 200px;
            position: absolute;

        }

        .north_nav ul {
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .north_nav ul li {
            padding: 35px 42px;
            font-size: 14px;
            font-family: '微软雅黑', '黑体', '宋体', Arial;
            font-weight: bold;
            color: #ffffff;
            text-decoration: none;
            border-right: 1px solid #9fd9f2;
            background-color: #52bee9;
            float: left;
            cursor: pointer;
        }

        /* 小三角 */
        .arrow-up {
            width: 0;
            height: 0;
            margin-top: 27px;
            margin-left: 27px;
            position: absolute;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-bottom: 10px solid #fff;
            display: none;
        }

        .nav_li10 {
            background: url("../images/index/navico_01.png") no-repeat 34px 32px;
        }

        .nav_li15 {
            background: url("../images/index/navico_02.png") no-repeat 34px 32px;
        }

        .nav_li20 {
            background: url("../images/index/navico_03.png") no-repeat 34px 32px;
        }

        .nav_li25 {
            background: url("../images/index/navico_04.png") no-repeat 34px 32px;
        }

        .nav_li99 {
            background: url("../images/index/navico_05.png") no-repeat 34px 32px;
        }

        .nav_li98 {
            background: url("../images/index/navico_06.png") no-repeat 34px 32px;
        }

        .north_info {
            width: 200px;
            height: 88px;
            float: left;
            margin-left: 1171px;
            position: absolute;
            background: url("../images/index/info.png") no-repeat #52bee9 40px 32px;
        }

        .center_main {
            background-color: #FFFFFF;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var h = $(window).width() - 1171;
            $(".north_info").css("width", h);

            var Topic = document.getElementsByName("Topic")[0].id;
            var TopicID = Topic.substr(5);
            showChildMenu(TopicID);
            $("#" + Topic + " ul li span a")[0].click();

            /*  $('#mb').menubutton({
             menu: '#mm'
             }); */
        });
        function showChildMenu(TopicID) {
            var topic = "Topic" + TopicID;
            var TopicCount = document.getElementsByName("Topic").length;
            for (var i = 0; i < TopicCount; i++) {
                document.getElementsByName("Topic")[i].style.display = "none";
            }
            if (document.getElementById(topic)) {
                document.getElementById(topic).style.display = "block";
            }
            $(".arrow-up").css('display', 'none');
            $("#arrow-up" + TopicID).css('display', 'block');
        }
    </script>
</head>
<body class="easyui-layout">
<div class="north" data-options="region:'north',border:false">
    <div class="north_logo">
        <img src="../images/index/logo.png" style="margin-top: 16px;margin-left: 26px;">
    </div>
    <div class="north_nav">
        <ul id="firstMenu">
            <%
                while (rs_level1.next()) {
            %>
            <li id="nav_li<%=rs_level1.getString(1) %>" class="nav_li<%=rs_level1.getString(1) %>"
                onclick="javascript:showChildMenu(<%=rs_level1.getString(1) %>)">
                &nbsp;&nbsp;&nbsp;&nbsp;<%=rs_level1.getString(3) %>
                <div id="arrow-up<%=rs_level1.getString(1) %>" class="arrow-up">
                    <!--向上的三角-->
                </div>
                
            </li>
            <%
                        /***Level2二级菜单开始****/
                        String sql_count2 = "select count(*) from bim.user_info a,bim.role_module c,bim.module d";
                        sql_count2 = sql_count2 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1 and c.right_type=1";
                        sql_count2 = sql_count2 + " and d.module_level=2 and substr(module_code,1,2)='" + rs_level1.getString(2) + "'";

                        String sql_level2 = "select d.module_id,module_code,module_name,URL,access_method from bim.user_info a,bim.role_module c,bim.module d";
                        sql_level2 = sql_level2 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1 and c.right_type=1";
                        sql_level2 = sql_level2 + " and d.module_level=2 and substr(module_code,1,2)='" + rs_level1.getString(2) + "'";
                        sql_level2 = sql_level2 + " order by d.order_no";

                        ResultSet rs_count2 = null;
                        ResultSet rs_level2 = null;

                        rs_count2 = db.executeQuery(sql_count2);//
                        rs_level2 = db.executeQuery(sql_level2);//通过数据库访问程序返回一个可滚动的记录集

                        if (rs_count2 == null) {
                            throw new Exception("对不起！系统在查询数据库时出错3");
                        }
                        if (rs_level2 == null) {
                            throw new Exception("对不起！系统在查询数据库时出错4");
                        }

                        int i2 = 0;
                        if (rs_count2.next()) {
                            i2 = rs_count2.getInt(1);
                        }
                        if (i2 >= 1) {
                            str_navi_tree_html = str_navi_tree_html + "<div id=\"Topic" + rs_level1.getString(2) + "\" name=\"Topic\" style=\"display:none\" class=\"easyui-accordion\" fit=\"true\" border=\"false\">";
                            while (rs_level2.next()) {
                                str_navi_tree_html = str_navi_tree_html + "<div title=" + rs_level2.getString(3) + " style=\"overflow-x:hidden;border:0;\">";
                                /***Level3三级菜单开始****/
                                String sql_count3 = "select count(*) from bim.user_info a,bim.role_module c,bim.module d";
                                sql_count3 = sql_count3 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1 and c.right_type=1";
                                sql_count3 = sql_count3 + " and d.module_level=3 and substr(module_code,1,4)='" + rs_level2.getString(2) + "'";

                                String sql_level3 = "select d.module_id,module_code,module_name,URL,access_method from bim.user_info a,bim.role_module c,bim.module d";
                                sql_level3 = sql_level3 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1 and c.right_type=1";
                                sql_level3 = sql_level3 + " and d.module_level=3 and substr(module_code,1,4)='" + rs_level2.getString(2) + "'";
                                sql_level3 = sql_level3 + " order by d.order_no";

                                ResultSet rs_count3 = null;
                                ResultSet rs_level3 = null;

                                rs_count3 = db.executeQuery(sql_count3);//
                                rs_level3 = db.executeQuery(sql_level3);//通过数据库访问程序返回一个可滚动的记录集

                                if (rs_count3 == null) {
                                    throw new Exception("对不起！系统在查询数据库时出错5");
                                }
                                if (rs_level3 == null) {
                                    throw new Exception("对不起！系统在查询数据库时出错6");
                                }

                                int i3 = 0;
                                if (rs_count3.next()) {
                                    i3 = rs_count3.getInt(1);
                                }
                                if (i3 >= 1) {
                                    str_navi_tree_html = str_navi_tree_html + "<ul  class=\"easyui-tree\">";
                                    while (rs_level3.next()) {
                                        if ((rs_level3.getString(4) != null) && (rs_level3.getString(4).trim() != "")) {
                                            if (rs_level3.getString(5).equals("OLAP")) {
                                                str_navi_tree_html = str_navi_tree_html + "<li><span><a onclick=\"window.frames['contentFrame'].location.href='" + rs_level3.getString(4) + "&CAMUsername=" + UserAccount + "&CAMPassword=" + UserPassword + "'\">" + rs_level3.getString(3) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></span>";
                                                //
                                            } else {
                                                str_navi_tree_html = str_navi_tree_html + "<li><span><a onclick=\"window.frames['contentFrame'].location.href='" + rs_level3.getString(4) + "'\">" + rs_level3.getString(3) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></span>";
                                            }
                                        } else {
                                            str_navi_tree_html = str_navi_tree_html + "<li><span>" + rs_level3.getString(3) + "</span>";
                                        }
                                        /***Level4四级菜单开始****/
                                        String sql_count4 = "select count(*) from bim.user_info a,bim.role_module c,bim.module d";
                                        sql_count4 = sql_count4 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1 and c.right_type=1";
                                        sql_count4 = sql_count4 + " and d.module_level=4 and substr(module_code,1,6)='" + rs_level3.getString(2) + "'";

                                        String sql_level4 = "select d.module_id,module_code,module_name,URL,access_method from bim.user_info a,bim.role_module c,bim.module d";
                                        sql_level4 = sql_level4 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1 and c.right_type=1";
                                        sql_level4 = sql_level4 + " and d.module_level=4 and substr(module_code,1,6)='" + rs_level3.getString(2) + "'";
                                        sql_level4 = sql_level4 + " order by d.order_no";

                                        ResultSet rs_count4 = null;
                                        ResultSet rs_level4 = null;

                                        rs_count4 = db.executeQuery(sql_count4);//
                                        rs_level4 = db.executeQuery(sql_level4);//通过数据库访问程序返回一个可滚动的记录集

                                        if (rs_count4 == null) {
                                            throw new Exception("对不起！系统在查询数据库时出错7");
                                        }
                                        if (rs_level4 == null) {
                                            throw new Exception("对不起！系统在查询数据库时出错8");
                                        }

                                        int i4 = 0;
                                        if (rs_count4.next()) {
                                            i4 = rs_count4.getInt(1);
                                        }
                                        if (i4 >= 1) {
                                            str_navi_tree_html = str_navi_tree_html + "<ul  class=\"easyui-tree\">";
                                            while (rs_level4.next()) {
                                                if ((rs_level4.getString(4) != null) && (rs_level4.getString(4).trim() != "")) {
                                                    if (rs_level4.getString(5).equals("OLAP")) {
                                                        str_navi_tree_html = str_navi_tree_html + "<li><span><a onclick=\"window.frames['contentFrame'].location.href='" + rs_level4.getString(4) + "&CAMUsername=" + UserAccount + "&CAMPassword=" + UserPassword + "'\">" + rs_level4.getString(3) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></span>";
                                                    } else {
                                                        str_navi_tree_html = str_navi_tree_html + "<li><span><a onclick=\"window.frames['contentFrame'].location.href='" + rs_level4.getString(4) + "'\">" + rs_level4.getString(3) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></span>";
                                                    }
                                                } else {
                                                    str_navi_tree_html = str_navi_tree_html + "<li><span>" + rs_level4.getString(3) + "</span>";
                                                }
                                                /***Level5五级菜单开始****/
                                                String sql_count5 = "select count(*) from bim.user_info a,bim.role_module c,bim.module d";
                                                sql_count5 = sql_count5 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1 and c.right_type=1";
                                                sql_count5 = sql_count5 + " and d.module_level=5 and substr(module_code,1,8)='" + rs_level4.getString(2) + "'";

                                                String sql_level5 = "select d.module_id,module_code,module_name,URL,access_method from bim.user_info a,bim.role_module c,bim.module d";
                                                sql_level5 = sql_level5 + " where a.user_id=" + UserID + " and a.role_id=c.role_id and c.module_id=d.module_id and d.status=1 and c.right_type=1";
                                                sql_level5 = sql_level5 + " and d.module_level=5 and substr(module_code,1,8)='" + rs_level4.getString(2) + "'";
                                                sql_level5 = sql_level5 + " order by d.order_no";

                                                ResultSet rs_count5 = null;
                                                ResultSet rs_level5 = null;

                                                rs_count5 = db.executeQuery(sql_count5);//
                                                rs_level5 = db.executeQuery(sql_level5);//通过数据库访问程序返回一个可滚动的记录集

                                                if (rs_count5 == null) {
                                                    throw new Exception("对不起！系统在查询数据库时出错9");
                                                }
                                                if (rs_level5 == null) {
                                                    throw new Exception("对不起！系统在查询数据库时出错10");
                                                }

                                                int i5 = 0;
                                                if (rs_count5.next()) {
                                                    i5 = rs_count5.getInt(1);
                                                }
                                                if (i5 >= 1) {
                                                    str_navi_tree_html = str_navi_tree_html + "<ul  class=\"easyui-tree\">";
                                                    while (rs_level5.next()) {
                                                        if ((rs_level5.getString(4) != null) && (rs_level5.getString(4).trim() != "")) {
                                                            if (rs_level5.getString(5).equals("OLAP")) {
                                                                str_navi_tree_html = str_navi_tree_html + "<li><span><a onclick=\"window.frames['contentFrame'].location.href='" + rs_level5.getString(4) + "&CAMUsername=" + UserAccount + "&CAMPassword=" + UserPassword + "'\">" + rs_level5.getString(3) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></span>";
                                                            } else {
                                                                str_navi_tree_html = str_navi_tree_html + "<li><span><a onclick=\"window.frames['contentFrame'].location.href='" + rs_level5.getString(4) + "'\">" + rs_level5.getString(3) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></span>";
                                                            }
                                                        } else {
                                                            str_navi_tree_html = str_navi_tree_html + "<li><span>" + rs_level5.getString(3) + "</span>";
                                                        }
                                                        /***如果要加6级菜单，可以从这里开始****/

                                                        /***如果要加6级菜单，这里写6级菜单的代码，拷贝5级菜单，适当修改即可****/

                                                        /***如果要加6级菜单，到这里结束****/
                                                        str_navi_tree_html = str_navi_tree_html + "</li>";
                                                    }
                                                    str_navi_tree_html = str_navi_tree_html + "</ul>";
                                                }
                                                /***Level5五级菜单结束****/
                                                rs_level5.close();
                                                rs_count5.close();
                                                str_navi_tree_html = str_navi_tree_html + "</li>";
                                            }
                                            str_navi_tree_html = str_navi_tree_html + "</ul>";
                                        }
                                        /***Level4四级菜单结束****/
                                        rs_level4.close();
                                        rs_count4.close();
                                        str_navi_tree_html = str_navi_tree_html + "</li>";
                                    }
                                    str_navi_tree_html = str_navi_tree_html + "</ul>";
                                }
                                /***Level3三级菜单结束****/
                                rs_level3.close();
                                rs_count3.close();

                                str_navi_tree_html = str_navi_tree_html + "</div>";
                            }
                            str_navi_tree_html = str_navi_tree_html + "</div>";

                            /***Level2二级菜单结束****/

                        } else {
                            //out.println("<script language='javascript'>alert('您没有被授权访问该主题下的任何分析，如有疑问，请和系统管理员联系!');</script>");
                        }
                        rs_level2.close();
                        rs_count2.close();
                    }
                } else {
                    out.println("<script language='javascript'>alert('您没有被授权访问本系统除用户设置外的的任何功能模块，如有疑问，请和系统管理员联系!');window.location.href='../login.jsp';</script>");
                }
                rs_level1.close();
                rs_count1.close();
            %>
        </ul>
    </div>
    <!-- 		<div id="mm" style="width:130px;">
                <div iconCls="icon-user"><a href="../UserSetting/UserInfo/UserInfoChange.jsp" target="contentFrame">个人信息修改</a></div>
                <div iconCls="icon-lock"><a href="../UserSetting/UserPw/PasswordChange.jsp" target="contentFrame">密 码 修 改</a></div>
                <div class="menu-sep"></div>
                <div iconCls="icon-undo"><a href="../SystemFrame/Logout.jsp">注 销</a></div>
            </div> -->
    <div class="north_info">
        <div style="margin-left: 85px;margin-top: 40px;color: #ffffff;font-size: 16px;font-weight:bold;"><a
                style="color:#ffffff;" href="javascript:void(0)" id="mb"><%=UserName %>
        </a></div>
    </div>
</div>
<div id="childMenu" name="childMenu" title="导航" data-options="region:'west',split:true,border:false"
     style="width:200px;">
    <%=str_navi_tree_html %>
</div>
<div id="main" name="main" class="center_main" data-options="region:'center',split:false,border:false">
    <iframe id="contentFrame" name="contentFrame" height="99%" width="100%" frameborder="0" scrolling="auto"
            marginheight="0" marginwidth="0">
    </iframe>
</div>
</body>
</html>
<%
        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>

