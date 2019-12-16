<%@page import="com.sec.news.model.Type"%>
<%@page import="com.sec.news.model.News"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.sec.news.admin.biz.TypeBiz" %>
<%@ page import="com.sec.news.admin.biz.Impl.TypeBizImpl" %>

<!DOCTYPE html>
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

		<%
    	News news = (News)request.getAttribute("data");
    	news = (news == null)?new News():(News)request.getAttribute("data");
    	int newsId = news.getNewsId();
    	request.setAttribute("data", news);
     %>
    <script type="text/javascript">
    	function returnMenu()
    	{
    		window.location.href = "${pageContext.request.contextPath}/servlet/NewServlet?op=query&jsp=../manage/article_add.jsp";
    	}	
    	
    	function VailLen(obj)
    	{
    		if(obj.value.length <= 0)
    		{
    			obj.focus();
    			return true;
    		}
    		return false;
    	}
    	
    	function Submt()
    	{
    		var title = document.getElementByName("title")[0];
    		var contenet = document.getElementsByName("content")[0];

    		if(Vailen(title))
    		{
    			alert("标题不能为空");
    			return false;
    		}
    		else if(Vailean(contenet))
    		{
    			alert("新闻内容不能为空");
    			return false;
    		}
    		else {
    			return  true;
    		}
    	}
    	
    	function fun1()
    	{
    		window.location = "../servlet/NewServlet?op=preview&newsId="+<%=newsId%>;
    	}
    	
    	function preview()
    	{
    		var obj = document.getElementsByName("op")[0];
    		obj.value = "preview";
    	}
    </script>
	</head>

	<body>
		<div class="row">
			<div class="col-md-10 col-lg-8 center-column">
				<form action="../servlet/NewServlet" method="post" class="cmxform" onsubmit="return Submt()">
					<div class="panel">
						<div class="panel-heading">
							<div class="panel-title">编辑文章</div>
								<div class="panel-btns pull-right margin-left">
								<a href="${pageContext.request.contextPath }/servlet/NewServlet?op=query&jsp=../manage/article_list.jsp" onclick="returnMenu()" class="btn btn-default btn-gradient dropdown-toggle">
									<span class="glyphicon glyphicon-chevron-left"></span>
								</a>
							</div>
						</div>
						<div class="panel-body">
							<div class="col-md-7">
								<div class="form-group">
									<div class="input-group"><span class="input-group-addon">分类</span>
										<select name="typeId" id="standard-list1" class="form-control">
										<%
											TypeBiz typeBiz = new TypeBizImpl();
	    									ArrayList<Type> lst = typeBiz.selectType();
	    									for(Type list:lst)
	    									{
	    										if(list.getTypeId() == news.getNewsId())
	    									{%>
	    										<option value="<%=list.getTypeId()%>" selected="selected"><%=list.getTypeName() %></option>
	    									<%}else%>
	    				  				 	<%{%>
	    										<option value="<%=list.getTypeId()%>"><%=list.getTypeName() %></option>
	    				  				 	<%}%>
	    					
	    			  					   <%}%>
										</select>
									</div>
								</div>
								<div class="form-group">
									<div class="input-group"><span class="input-group-addon">标题</span>
										<input type="text" name = "title" value="<%=news.getTitle() %>" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group"><span class="input-group-addon">作者</span>
										<input type="text" readonly="true" name="author" value="<%=news.getUser().getUserName() %>" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group">发布时间：
										<%=news.getReleaseTime() %>
									</div>
								</div>
								<div class="form-group">
									<div class="input-group">是否推荐该新闻:&nbsp;
									<%
										if(news.getRecommended() == 1) {
									%>
										<input type="radio" name="recommended" value="1" checked="checked" />推荐&nbsp;&nbsp;
										<input type="radio" name="recommended" value="0" />不推荐 
									<%
										} else {
									%>
										<input type="radio" name="recommended" value="1" />推荐 &nbsp;&nbsp;
										<input type="radio" name="recommended" value="0" checked="checked" />不推荐
									<%
										}
									%>
								</div>
							</div>
							</div>
								<div class="form-group col-md-12">新闻内容：
									<textarea id="myEditor" name="content" style="width:100%;height:200px;"><%=news.getContent() %></textarea>
								</div>
							<div class="col-md-7">
								<div class="form-group">
									<input type="submit" value="提交" class="submit btn btn-blue"/>
									<input type="reset" value="重置" class="submit btn btn-blue"/> 
									<input type="submit" value="预览" class="submit btn btn-blue" onclick="preview()"/>
    								<input type="hidden" value="update" name="op"> 
    								<input type="hidden" value="<%=newsId %>" name="newsId"/>
    								<input type="hidden" value="../manage/news.jsp" name="jsp"> 
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/manage/umeditor/themes/default/_css/umeditor.css">
		<script src="${pageContext.request.contextPath }/manage/umeditor/editor_api.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath }/manage/umeditor/umeditor.config.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath }/manage/umeditor/lang/zh-cn/zh-cn.js" type="text/javascript"></script>。
		<script type="text/javascript">
		var ue = UM.getEditor('myEditor', {
		autoClearinitialContent: true,
		wordCount: false,
		elementPathEnabled: false,
		initialFrameHeight: 300
		});
		</script>
	</body>

</html>