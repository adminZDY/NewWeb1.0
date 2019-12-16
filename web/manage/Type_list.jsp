<%@ page import="com.sec.news.model.Type" %>
<%@ page import="com.sec.news.model.PageModel" %>
<%@ page import="com.sec.news.admin.biz.TypeBiz" %>
<%@ page import="com.sec.news.admin.biz.Impl.TypeBizImpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/23
  Time: 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    private String QueryURL(int pageNo)
    {
        String basePath = "../servlet/TypeServlet?op=query&pageNo=";

        return basePath+pageNo;
    }
    private String QueryURL(int pageNo,int total)
    {
        String basePath = "../servlet/TypeServlet?op=query&pageNo=";
        if(pageNo<=1)
        {
            pageNo = 1;
        }
        else if(pageNo >= total)
        {
            pageNo = total;
        }
        return basePath+pageNo;
    }
//    private String deleteURL(int pageNo)
//    {
//        String basePath = "../servlet/TypeServlet?op=delete&typeId=";
//
//        return basePath+pageNo;
//    }
    private String updateURL(int typeId)
    {
        String basePath = "../manage/Type_update.jsp?op=update&typeId=";

        return basePath+typeId;
    }
%>

<html>
<head>
    <title>Title</title>
</head>
<!-- Core CSS  -->
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/glyphicons.min.css">

<!-- Theme CSS -->
<link rel="stylesheet" type="text/css" href="../css/theme.css">
<link rel="stylesheet" type="text/css" href="../css/pages.css">
<link rel="stylesheet" type="text/css" href="../css/plugins.css">
<link rel="stylesheet" type="text/css" href="../css/responsive.css">

<!-- Boxed-Layout CSS -->
<link rel="stylesheet" type="text/css" href="../css/boxed.css">

<!-- Demonstration CSS -->
<link rel="stylesheet" type="text/css" href="../css/demo.css">

<!-- Your Custom CSS -->
<link rel="stylesheet" type="text/css" href="../css/custom.css">

<!-- Core Javascript - via CDN -->
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/uniform.min.js"></script>
<script type="text/javascript" src="../js/main.js"></script>
<script type="text/javascript" src="../js/custom.js"></script>

<script type="text/javascript">

    function change(obj)
    {
        window.location = "${pageContext.request.contextPath}/servlet/NewServlet?op=query&jsp=/manage/article_list.jsp&pageNo=1&typeId="+obj;
    }

</script>
<body>
<div class="container" >

    <div class="row">
        <div class="col-md-12" style="padding: 0 0 0 0;">
            <div class="panel">
                <div class="panel-heading">
                    <div class="panel-title">新闻类型列表</div>
                    <a href="${pageContext.request.contextPath}/manage/Type_add.jsp" class="btn btn-info btn-gradient pull-right">
                        <span class="glyphicons glyphicon-plus"></span> 添加新闻类型</a>
                </div>

                <form action="" method="post">
                    <div class="panel-body">
                        <div class="panel-body-title"><font size="5">新闻类型管理</font>

                        </div>

                        <table class="table table-striped table-bordered table-hover dataTable">
                            <tr class="active">
<%--                                <th class="text-center" width="100"><input type="checkbox" value="" id="checkall" class=""> 全选</th>--%>
                                <td >编号</td>
                                <td >新闻类型</td>
                                <td >备注</td>
                                <td >操作</td>
                            </tr>

                                    <%
			 PageModel<Type> pm = (PageModel<Type>)request.getAttribute("data");
			 for(Type type : pm.getData())
			 {%>
                            <tr>
<%--                                <td class="text-center"><input type="checkbox" value="1" name="idarr[]" class="cbox"></td>--%>
                                <%--编号--%>
                                <td><%=type.getTypeId() %></td>
                                <%--新闻类型 --%>
                                <td><%=type.getTypeName() %></td>
                                <td><%=type.getRemark() %></td>
                                <td>
                                    <%--管理新闻：查询出该类型对应的新闻 --%>
                                    <a href="javascript:void(0)" onclick="change(<%=type.getTypeId() %>)" >[管 理 新 闻]</a>
                                    <%--删除类型 --%>
<%--                                    <a href="<%=deleteURL(pm.get(i).getTypeId())%>">[删 除]</a>--%>
                                    <%--修改类型 --%>
                                    <a href="<%=updateURL(type.getTypeId()) %>">[修 改]</a>
                                </td>
                            </tr>
                            <%}%>
                        </table>

<%--                        <div class="pull-left">--%>
<%--                            <button type="submit" class="btn btn-default btn-gradient pull-right delall">--%>
<%--                                <span class="glyphicons glyphicon-trash"></span>--%>
<%--                            </button>--%>
<%--                        </div>--%>

                        <div class="pull-right">
                            <ul class="pagination" id="paginator-example">
                                <!-- <li><a>共<%--=pm.getCountData() %>条数据，</a></li>
										<li><a>每页<%=pm.getPageSize() %>条，</a></li>
										<li><a>共<%=pm.getTotalPages() --%>页，</a></li> -->
                                <li><a href="<%=QueryURL(1)%>">&lt;&lt;</a></li>
                                <li><a href="<%=QueryURL(pm.getPageNo()-1,pm.getTotalpages())%>">&lt;</a></li>

                                <li class="active"><a><%=pm.getPageNo() %></a></li>

                                <li><a href="<%=QueryURL(pm.getPageNo()+1,pm.getTotalpages())%>">&gt;</a></li>
                                <li><a href="<%=QueryURL(pm.getTotalpages())%>">&gt;&gt;</a></li>
                            </ul>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- End: Content -->

<!-- End: Main -->
</body>
</html>
</body>
</html>
