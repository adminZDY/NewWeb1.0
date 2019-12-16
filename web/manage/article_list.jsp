
<%@page import="com.sec.news.model.Type"%>
<%@page import="com.sec.news.dao.TypeDao"%>
<%@page import="com.sec.news.model.News"%>
<%@page import="com.sec.news.model.PageModel"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.sec.news.admin.biz.TypeBiz" %>
<%@ page import="com.sec.news.admin.biz.Impl.TypeBizImpl" %>
<%!  String path = "";%>
<% path = request.getContextPath();%>
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
		<script type="text/javascript">
    	function returnMenu()
    	{
    		window.location.href = "${pageContext.request.contextPath}/manage/manage.jsp";
    	}	
    	function VailLen(obj)
    	{
    		if(obj.value.length >= 6)
    		{
    			obj.focus();
    			return true;
    		}
    		return false;
    	}
    	function change(obj)
		{
    		window.location = "${pageContext.request.contextPath}/servlet/NewServlet?op=query&jsp=/manage/article_list.jsp&pageNo=1&IfselectAll="+obj.value;
    	}
    	
    	function click1()
    	{
    		window.location= "${pageContext.request.contextPath}/manage/addNews.jsp";
    	}
    </script>
    <style type="text/css">
    	.select{
    			height: 34px;
    			padding: 0px 15px;
    			font-size: 14px;
   				line-height: 1.428571429;
   				color: #555;
    			background-color: #fff;
    			background-image: none;
    			border: 1px solid #ccc;
    			border-radius: 4px;
    			float: right;
    			margin-top: -10px;
    			}
    </style>
     <%
    	//获取查询好的集合信息
    	PageModel<News> pm = (PageModel<News>)request.getAttribute("data");
    	if(pm == null)
    	{
    		pm = new PageModel<News>();
    	}
     %>
		<script type="text/javascript">

			//上一页、下一页、首页、尾页、删除、修改(路径提交)
			function Sumbit_bath(pageNo)
			{
				console.log("请求页数"+pageNo+"  当前页数<%=pm.getPageNo()%> 请求Id");
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
				alert(pageNo);
				Sumbit_bath(pageNo);
			}
			//尾页
			function toLastPage(){
				var pageNo = <%=pm.getLastPageNo()%>;
				Sumbit_bath(pageNo);
			}
			function changIndex(obj){
				document.getElementsByName("typeId")[0].value = obj.value;
				console.log("类型"+document.getElementsByName("typeId")[0].value);
				Sumbit_bath("a");
			}

		</script>
		<%!
			public String update(int newsId)
			{
				return path+"/servlet/NewServlet?op=update&newsId="+newsId;
			}

			public String delete(int newsId)
			{
				return path+"/servlet/NewServlet?op=delete&jsp=/manage/article_list.jsp&delete="+newsId;
			}
		%>
	</head>

	<body>
	<!-- Start: Content -->

	<div class="container" >

		<div class="row">
			<div class="col-md-12" style="padding: 0 0 0 0;">
				<div class="panel">
					<div class="panel-heading">
						<div class="panel-title">新闻列表</div>
						<a href="${pageContext.request.contextPath}/manage/article_add.jsp" class="btn btn-info btn-gradient pull-right"><span class="glyphicons glyphicon-plus"></span> 添加文章</a>
					</div>

					<form action="${pageContext.request.contextPath}/servlet/NewServlet" name="form1" method="post">
						<input type="hidden" name="typeId" value="${typeId}"/>
						<input type="hidden" name="op" value="query"/>
						<input type="hidden" name="pageNo" value = "${pageNo}"/>
						<input type="hidden" name="pageSize" value = "6"/>
						<div class="panel-body">
							<div class="panel-body-title"><font size="5">新闻管理</font>
								<select onchange="changIndex(this)" class="select" >
									<option value="0">所有新闻</option>
									<%
										Integer t = (Integer) request.getAttribute("typeId");

										System.out.println(t);
										TypeBiz typeBiz = new TypeBizImpl();
										ArrayList<Type> lst = typeBiz.selectType();
										for(Type list:lst)
										{
											if(t == list.getTypeId()){%>
												<option value="<%=list.getTypeId()%>" selected><%=list.getTypeName()%></option>
									<%  	}
											else{%>
												<option value="<%=list.getTypeId()%>"><%=list.getTypeName()%></option>
									<%		}
										}%>
								</select>
							</div>

							<table class="table table-striped table-bordered table-hover dataTable">
								<tr class="active">
									<th class="text-center" width="100"><input type="checkbox" value="" id="checkall" class=""> 全选</th>
									<td>编号</td>
									<td>标题</td>
									<td>类型</td>
									<td>点击次数</td>
									<td>正文大小</td>
									<td>发布时间</td>
									<td>推荐</td>
									<td>发布者</td>
									<td>操作</td>
								</tr>
								<tr class="success">
										<%
    							for(News news: pm.getPage())
    							{%>
								<tr>
									<td class="text-center"><input type="checkbox" value="1" name="idarr[]" class="cbox"></td>
									<td><%=news.getNewsId() %></td>
									<td><%=news.getTitle() %></td>
									<td><%=news.getType().getTypeName() %></td>
									<td><%=news.getClick() %></td>
									<td><%=news.getContent().getBytes().length %></td>
									<td><%=news.getReleaseTime() %></td>
									<td><%=(news.getRecommended() == 1 ?"是":"否")%></td>

									<td><%=news.getUser().getUserName() %></td>
									<td>
										<div class="btn-group">
											<a href="<%=update(news.getNewsId())%>" class="btn btn-default btn-gradient">
												<span class="glyphicons glyphicon-pencil"></span>
											</a>
											<a onclick="return confirm('确定要删除吗？');" href="<%=delete(news.getNewsId())%>" class="btn btn-default btn-gradient dropdown-toggle">
												<span class="glyphicons glyphicon-trash"></span>
											</a>
										</div>
									</td>
								</tr>
								<%}%>
							</table>

							<div class="pull-left">
								<button type="submit" class="btn btn-default btn-gradient pull-right delall">
									<span class="glyphicons glyphicon-trash"></span>
								</button>
							</div>

							<div class="pull-right">
								<ul class="pagination" id="paginator-example">
									<li><a href="javascript:void(0)">共有&nbsp;${data.countData}&nbsp;条数据，每页&nbsp;${data.pageSize}&nbsp;条，共&nbsp;${data.totalpages}&nbsp;页</a></li>
									<li><a href='javascript:toTopPage()'>&lt;&lt;</a></li>
									<li><a href='javascript:toPriviousPage()'>&lt;</a></li>

									<li class="active"><a>${data.pageNo}</a></li>

									<li><a href='javascript:toNextPage()'>&gt;</a></li>
									<li><a href='javascript:toLastPage()'>&gt;&gt;</a></li>

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
