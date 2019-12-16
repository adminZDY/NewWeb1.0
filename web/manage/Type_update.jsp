<%@ page import="com.sec.news.dao.Impl.TypeDaoImpl" %>
<%@ page import="com.sec.news.dao.TypeDao" %>
<%@ page import="com.sec.news.model.Type" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/25
  Time: 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int typeId = 0;

    try{
        //获取类型编号
        typeId =Integer.parseInt(request.getParameter("typeId"));
    }catch(Exception e){typeId = 0;}

    TypeDao typedao = new TypeDaoImpl();
    //查询该编号的信息
    Type type = typedao.selectNewsTypeById(typeId);
%>
<html>
<head>
    <title>Title</title>
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
    <script type="text/javascript" src="../js/main.js"></script>
    <script type="text/javascript" src="../js/custom.js"></script>

    <script type="text/javascript">
        function returnMenu()
        {
            window.location.href = "welcome.jsp";
        }

        /**
         *提交时的验证
         */
        function Submit()
        {
            var tip = document.getElementById("tips");
            var typeName = document.getElementsByName("typeName")[0];
            if(typeName.value == null)
            {
                tip.innerHTML = "类型名称不能为空！！！";
                typeName.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="container" style="width: 100%;">
    <div class="row" style="margin-bottom: -15px;">
        <div class="col-md-10 col-lg-8 center-column" style="padding: 0 0 0 0; ">
            <form action="${pageContext.request.contextPath}/servlet/TypeServlet" method="post"
                  onsubmit="return Submt()" class="cmxform">
                <div class="panel">
                    <div class="panel-heading">
                        <div class="panel-title">修改新闻类型</div>
                        <div class="panel-btns pull-right margin-left">
                            <a href="${pageContext.request.contextPath }/manage/welcome.jsp"
                               class="btn btn-default btn-gradient dropdown-toggle" style="padding:15px 12px;">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="col-md-7">
                            <div class="form-group">
                                <div class="input-group"><span class="input-group-addon">类型编号：</span>
                                    <input type="text" name="typeId" value="<%=type.getTypeId()%>" readonly="readonly" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group"><span class="input-group-addon">类型名称：</span>
                                    <input type="text" name="typeName" value="<%=type.getTypeName()%>" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group"><span class="input-group-addon">类型备注：</span>
                                    <textarea rows="5px" cols="80px"  class="form-control" name="remark"><%=type.getRemark()%></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-7">
                            <div class="form-group">
                                <input type="submit" value="提交"/>&nbsp;&nbsp;
                                <input type="reset" value="重置"/>
                                <input type="hidden" value="update" name="op">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
