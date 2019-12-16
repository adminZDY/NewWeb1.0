<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.sec.news.biz.FrontBiz" %>
<%@ page import="com.sec.news.biz.Impl.FrontBizImpl" %>
<%@ page import="com.sec.news.model.News" %>
<%@ page import="com.sec.news.model.Type" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>schoolNews首页</title>
    <style type="text/css">
        /*页面版心*/
        #main{
            width: 1366px;
            height: 700px;
            margin-top:10px;
            margin-bottom: 20px;
        }
        /*版心div*/
        #main div
        {
            float: left;
        }
        /*版心左边*/
        #main_left
        {
            margin-left:60px;
            width:300px;
        }
        #main_left a
        {
            text-decoration: none;
            color:#000;
        }
        #main_left a:HOVER
        {
            color: gray;
        }

        /*版心右边  产品区*/
        #main_left_type
        {
            margin-top:5px;
            border:1px solid #E6E6E6;
            width: 300px;
        }

        #main_left_type #title
        {
            width:300px;
        }
        /*产品类别标题*/
        #main_left_type #content_product1,#main_left_type #content_product2,#main_left_type #content_product3,
        #main_left_type #content_product4,#main_left_type #content_product5,#main_left_type #content_product6,
        #main_left_type #content_product7
        {
            border: 1px solid;
            margin-top: 3px;
            height: 120px;
        }
        /*产品类别项*/
        #main_left_type #content_text
        {
            float:left;
            margin-left: 20px;
            margin-top: 2px;
            background-color: blue;
        }
        #main_left_type #content_text a
        {
            float: right;
        }
        #all
        {
            float: right;
            width: 300px;
        }

        /*版心右边*/
        #main_right
        {
            margin-left:15px;
            border:1px solid #E6E6E6;
            width: 750px;
            padding-left: 8px;
            padding-top: 20px;
        }
        #main_right a
        {
            text-decoration: none;
            color: white;
        }
        #main_right a:HOVER
        {
            color: gray;
        }
    </style>

    <!-- 左边样式 -->
    <style type="text/css">
        /*产品导航*/
        .content_product
        {
            width:300px;
            height:800px;
        }
        .content_product_type1
        {
            width:290px;
            border:2px solid gray;

        }
        .content_product_type2
        {
            width:290px;
            border: 2px solid #000;
        }
        /*表格项*/
        .datailItem td
        {
            text-indent:20px;
            width: 200px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            text-align: left;
        }

        /*标题失去焦点的*/
        .content_title1
        {
            width:24px;
        }
        /*标题得到焦点的*/
        .content_title2
        {
            background:none;
            width:24px;
            background-color:white;
        }
        td{
            border-bottom:1px blue dashed;
        }
        #main_left_type li {
            max-width: 270px;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>

<body>
    <%@ include file="top.jsp"%>

    <!-- 版心 -->
    <div id="main">
        <!-- 左div -->
        <div id = "main_left">
            <!-- 产品导航 （7种产品）-->
            <div id="main_left_type">
                <!-- 模块一 -->
                <table class="content_product" cellspacing="0">
                    <tr>
                        <td class="datailItem"   align="center">
                            <table class = "content_product_type1">
                                <tr>
                                    <th class="content_title1">最新新闻</th>
                                </tr>

                                <%
                                    FrontBiz biz = new FrontBizImpl();
                                    List<News> n1 = biz.selectTopNews(10);
                                    for(News j : n1){%>
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/servlet/FrontServlet?op=show_pvw&newsId=<%=j.getNewsId()%>" >
                                        <li><%=j.getTitle()%></li></a></td>
                                </tr>
                                <%}%>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="datailItem"  align="center">
                            <table class = "content_product_type1">
                                <tr>
                                    <th class="content_title1">热点新闻</th>
                                </tr>
                                <%

                                n1 = biz.selectHotNews(10);
                                for(News j : n1){%>
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/servlet/FrontServlet?op=show_pvw&newsId=<%=j.getNewsId()%>" ><li><%=j.getTitle()%></li></a></td>
                                </tr>
                                <%}%>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="datailItem" align="center">
                            <table class = "content_product_type1">
                                <tr>
                                    <th class="content_title1">新闻类型</th>
                                </tr>
                                <%
                                    List<Type> type = biz.selectNewsType();
                                    for(Type j : type){%>
                                <tr>
                                    <td><li><%=j.getTypeName()%></li></td>
                                </tr>
                                <%}%>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>


        <!-- 右div(商品信息：) -->
        <div id = "main_right">
            <div class="content_title1" style="width: 100px;font-size: 20px;">新闻列表</div>
            <iframe src="${pageContext.request.contextPath }/servlet/FrontServlet?op=query" frameborder="0" scrolling="no" style="width: 110%; height:700px; padding: 0 0 0 0;" width="100%" name="iframe" id="docs-content"></iframe>
        </div>

    <%@ include file="btm.jsp"%>
</body>
</html>
