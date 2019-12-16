<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 2019/11/26
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主页底部</title>
    <style type="text/css">
        /*尾部*/
        footer {
            margin-top:10px;
            float: left;
            text-align: center;
            background: url("${pageContext.request.contextPath}/front/img/images/bg.jpg");
            width: 1366px;
            height: 129px;
        }

        footer div {
            float: left;
        }

        #footer_bottom {
            background: url("${pageContext.request.contextPath}/front/img/bg.jpg") bottom;
            text-align: center;
            width: 1366px;
            height: 49px;
        }

        #footer_bottom p {
            padding-top: 0px;
            margin-top: 10px;
            font-size: 15px;
        }
    </style>
</head>
<body>
    <footer>
        <!-- 底部版权 -->
        <div id="footer_bottom">
            <p>千里之行&copy;(2009-2011)版权所有</p>
        </div>
    </footer>
</body>
</html>
