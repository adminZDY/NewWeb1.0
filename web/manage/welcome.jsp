<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.sec.news.model.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>--%>

<%-- <jsp:useBean id="date" class="java.util.Date"/>--%>
<%
	Properties props = System.getProperties(); // 系统属性


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
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
    <title>欢迎界面</title>
  
  </head>
  <body >
  	<h2 class="page-header margin-top-none">个人信息</h2>
					<table class="table">
						<tr>
						<td colspan="2">您好，${sessionScope.user.userName}</td>
						</tr>
						<tr>
						<td width="120">最后登录时间:</td>
						<td>${sessionScope.date}</td>
						</tr>
						<tr>
						<td>最后登录IP:</td>
						<td>${pageContext.request.remoteAddr}</td>
						</tr>
					</table>

					<h2 class="page-header margin-top-none">系统信息</h2>
					<table class="table">
						<tr>
							<td width="100">操作系统：</td>
							<td><%=props.getProperty("os.name")%></td>
						</tr>
						<tr>
							<td>java 版本:</td>
							<td><%=props.getProperty("java.version")%></td>
						</tr>
						<tr>
							<td>MySQL 版本:</td>
							<td>5.1.33</td>
						</tr>
					</table>	
  </body>
</html>
