<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 2019/11/26
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Logo区</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" charset="UTF-8"></script>
    <script type="text/javascript">
        /*关闭当前浏览窗口*/
        function closeForm()
        {
            this.close();
        }
        //时间更新
        function timeUpdate() {
            var date=new Date();
            var year=date.getFullYear();
            var month=date.getMonth()+1;
            var day=date.getDate();
            var hour="00"+date.getHours();
            hour=hour.substr(hour.length-2);
            var minute="00"+date.getMinutes();
            minute=minute.substr(minute.length-2);
            var second="00"+date.getSeconds();
            second=second.substr(second.length-2);
            $("#time").html(year+"-"+month+"-"+day+" "+" "+hour+":"+minute+":"+second);
            setTimeout("timeUpdate()", 1000); //设置过1000毫秒就是1秒，调用show方法

        }
        timeUpdate();
    </script>
    <script src="${pageContext.request.contextPath}/js/setHome.js" charset="UTF-8"></script>
    <style type="text/css">
        header a
        {
        text-decoration: none;
        color:#000;
        }
        header a:HOVER
        {
        color: gray;
        }
        header
        {
        background:url("${pageContext.request.contextPath}/front/img/bg.jpg");
        width:1366px;
        height: 129px;
        }
        header div
        {
        float:left;
        }
        /*logo区整体大小*/
        .logo
        {
        width: 1366px;
        height: 90px;
        }
        /*logo图,显示图片,以图片大小为准*/
        .logo_left
        {
        float:left;
        width:260px;
        height: 90px;
        }
        /*首页导航*/
        .logo_right
        {
        float:right;
        width:1101px;
        height: 90px;
        }
        /*首页导航（顶部）*/
        .logo_right_top
        {
        width:480px;
        height:30px;
        float:right;
        margin-right:50px;
        font-size:14px;

        }
        .logo_right_top li
        {
        list-style-type: none;
        }
        .logo_right_top a
        {
        text-decoration: none;
        }
        .logo_right_top div
        {
        float:left;
        height:21px;

        }

        /*首页导航（底部）*/
        .logo_right_bottom
        {
        float:left;
        margin-top:35px;
        width:1101px;
        height:10px;
        text-align:left;
        }
        /*搜索栏*/
        .logo_nav
        {
        width: 1366px;
        height: 30px;
        }
        .logo_nav div
        {
        float: right;
        }
        .shortcut_nav
        {
         margin-right: 60px;
        }
        .logoInfo{
        margin-left: 200px;
        }
    </style>
</head>
<body>
<!-- 页眉 -->
<header>
    <!-- logo整体 -->
    <div class  = "logo">
        <!-- logo左边 -->
        <div class="logo_left">
            <a href="${pageContext.request.contextPath}/front/homepage.jsp" style="color:transparent;">
                <span style="font-size: 24px;">schoolNews</span>
            </a>
        </div>
        <!-- logo右边 -->
        <div class ="logo_right">
            <div class ="logo_right_top">
                <div style="width:64px;margin-left: 5px; margin-top:5px;">
                    <a onclick="SetHome(this,window.location)" style="cursor:pointer">设为首页</a>
                </div>
                <div style="width:64px;margin-left: 15px; margin-top:5px;">
                    <a href="javascript:closeForm();">退出</a>
                </div>
                <div style="width:80px;margin-left: 5px; margin-top:5px;">
                    <a onclick="AddFavorite(window.location,document.title)" style="cursor:pointer">收藏网站</a>
                </div>
                <div style="width:64px;margin-left: 5px; margin-top:5px;">
                    <a href="javascript:alert('帮助')">帮助</a>
                </div>
            </div>
            <div class ="logo_right_bottom">
                <span class  = "logoInfo"> 你好,现在时间是<i id="time">XXXX</i></span>
            </div>
        </div>
    </div>
</header>
</body>
</html>