<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/22
  Time: 15:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <title>CMS内容管理系统</title>
    <meta name="keywords" content="Admin">
    <meta name="description" content="Admin">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

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

        /**
         *提交时的验证
         */
        function Submit()
        {
            var tip = document.getElementById("tips");
            var typeName = document.getElementsByName("typeName")[0];
            var remark = document.getElementsByName("remark")[0];
            if(typeName.value == null || typeName.value.length == 0)
            {
                tip.innerHTML = "类型名称不能为空！！！";
                typeName.focus();
                return false;
            }else if(remark.value == null || remark.value.length == 0)
            {
                tip.innerHTML = "备注不能为空！！！";
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
                        <div class="panel-title">新增新闻类型</div>
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
                                <div class="input-group"><span class="input-group-addon">类型名称：</span>
                                    <input type="text" name="typeName" value="" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group"><span class="input-group-addon">类型备注：</span>
                                    <textarea rows="5px" cols="80px"  class="form-control" name="remark"></textarea>
                                </div>
                            </div>

                        </div>
<%--                        <div class="form-group col-md-12">类型备注：--%>
<%--                            <textarea name="remark" id="myEditor"--%>
<%--                                    style="width:100%;height:200px;"></textarea>--%>
<%--                        </div>--%>
                        <div class="col-md-7">
                            <div class="form-group">
                                <input type="submit" value="提交" class="submit btn btn-blue"/>
                                <input type="reset" value="重置" class="submit btn btn-blue"/>
                                <input type="hidden" value="add" name="op">
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- End: Main -->
<%--<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/manage/umeditor/themes/default/_css/umeditor.css">--%>
<%--<script src="${pageContext.request.contextPath}/manage/umeditor/umeditor.config.js" type="text/javascript"></script>--%>
<%--<script src="${pageContext.request.contextPath}/manage/umeditor/editor_api.js" type="text/javascript"></script>--%>
<%--<script src="${pageContext.request.contextPath}/manage/umeditor/lang/zh-cn/zh-cn.js" type="text/javascript"></script>--%>
<%--<script type="text/javascript">--%>
<%--    var ue = UM.getEditor('myEditor', {--%>
<%--        autoClearinitialContent: true,--%>
<%--        wordCount: false,--%>
<%--        elementPathEnabled: false,--%>
<%--        initialFrameHeight: 300--%>
<%--    });--%>
<%--</script>--%>
</body>

</html>
