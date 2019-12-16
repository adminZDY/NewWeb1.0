<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.sec.news.dao.NewDao" %>
<%@ page import="com.sec.news.dao.Impl.NewDaoImpl" %>
<%@ page import="com.sec.news.model.PageModel" %>
<%@ page import="com.sec.news.model.News" %>
<%@ page import="com.sec.news.model.Type" %>
<%@ page import="com.sec.news.biz.FrontBiz" %>
<%@ page import="com.sec.news.biz.Impl.FrontBizImpl" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'newsList.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <style type="text/css">
        .content_product_type3
        {
            width:700px;
        }
        td{
            border-bottom:1px blue dashed;
        }
        .content_product_type3 a:HOVER {
            color: gray;

        }
        .content_product_type3 a {
            text-decoration: none;
            color: #000;

        }
    </style>
      <script type="text/javascript">
          <%
            PageModel<News> pm = (PageModel<News>) request.getAttribute("data");
            List<News> newData = pm.getPage();
          %>
          //上一页、下一页、首页、尾页、删除、修改(路径提交)
          function Sumbit_bath(pageNo)
          {
              if(pageNo == <%=pm.getPageNo()%>){

                  return;
              }
              if(pageNo != null)
              {
                  document.getElementsByName("pageNo")[0].value = pageNo;
              }
              document.form1.submit();
          }

          //前往首页
          function toTopPage(){
              var pageNo = <%=pm.getIndexPageNo()%>;
              Sumbit_bath(pageNo);
          }
          //上一页
          function toPriviousPage(){
              var pageNo = <%=pm.getPreviousPageNo()%>;
              Sumbit_bath(pageNo);
          }
          //下一页
          function toNextPage(){
              <%-- request.setAttribute("text", text); --%>
              var pageNo = <%=pm.getNextPageNo()%>;

              Sumbit_bath(pageNo);
          }
          //尾页
          function toLastPage(){
              var pageNo = <%=pm.getLastPageNo()%>;
              Sumbit_bath(pageNo);
          }
          function changIndex(obj){
              document.getElementsByName("typeId")[0].value = obj.value;
              Sumbit_bath("a");
          }
          function submitPath(id) {
              var str = "${pageContext.request.contextPath}/servlet/FrontServlet?op=show_pvw&newsId="+id;
              if (window != top)
              {
                  top.location.href = str;
              }
              else{
                  location.href = str;
              }
          }
      </script>

  </head>
  
  <body >
  <table class = "content_product_type3">
      <tr>
          <select onchange="changIndex(this)">
              <option value="0">所有类型</option>
             <%
                 Integer t = (Integer) request.getAttribute("typeId");

                 FrontBiz biz = new FrontBizImpl();
                 List<Type> type = biz.selectNewsType();
              for(Type j : type){
             if(t == j.getTypeId()){%>
              <option value="<%=j.getTypeId()%>" selected><%=j.getTypeName()%></option>
            <% }else{%>

              <option value="<%=j.getTypeId()%>"><%=j.getTypeName()%></option>
                <%}}%>
          </select>
      </tr>
      <%
          for(News j : newData){%>
      <tr>
          <td align="left" style="padding-left: 80px;">
    <a href="javascript:submitPath(<%=j.getNewsId()%>)">
                  <li><%=j.getTitle()%></li></a></td>
          <td align="right">发布时间：<%=j.getReleaseTime()%></td>
      </tr>
      <%}%>
      <tr>
          <td colspan="2" align="center">
<%--              共有&nbsp;21&nbsp;条数据，每页&nbsp;20&nbsp;条，共&nbsp;2&nbsp;页，当前第1页&nbsp;&nbsp;&nbsp;--%>
<%--              [<a>首页</a>&nbsp;<a>上一页</a>&nbsp;<a>下一页</a>&nbsp;<a>尾页</a>&nbsp;]--%>
<%--              共找到<%=pm.getTotalRecords()%>条记录第<%=pm.getPageNo()%>/<%=pm.getTotalpages()%>--%>
<%--              页&nbsp;--%>
            <form action="${pageContext.request.contextPath}/servlet/FrontServlet" method="post" name="form1">
                共有&nbsp;${data.countData}&nbsp;条数据，每页&nbsp;${data.pageSize}&nbsp;条，共&nbsp;${data.totalpages}&nbsp;页，当前第${data.pageNo}页&nbsp;&nbsp;&nbsp;
                [<a href='javascript:toTopPage()'>首页</a>&nbsp;
              <a href='javascript:toPriviousPage()'>上一页</a>&nbsp;
              <a href='javascript:toNextPage()'>下一页</a>&nbsp;
              <a href='javascript:toLastPage()'>尾页</a>]

              <input type="hidden" name="typeId" value="${typeId}"/>
              <input type="hidden" name="op" value="query"/>
              <input type="hidden" name="pageNo" value = "${pageNo}"/>
              <input type="hidden" name="pageSize" value = "20"/>
            </form>
          </td>
      </tr>
  </table>
  </body>
</html>
