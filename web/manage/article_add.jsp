<%@page import="com.sec.news.model.Type"%>
<%@page import="com.sec.news.dao.TypeDao"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.sec.news.admin.biz.TypeBiz" %>
<%@ page import="com.sec.news.admin.biz.Impl.TypeBizImpl" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
    		if(Vailean(contenet))
    		{
    			alert("新闻内容不能为空");
    			return false;
    		}
    		else {
    			falg =  true;
    		}
    		return false;
    	}
    </script>
	</head>

	<body>
	<div class="container" style="width: 100%;">
		<div class="row" style="margin-bottom: -15px;">
			<div class="col-md-10 col-lg-8 center-column" style="padding: 0 0 0 0; ">
				<form action="${pageContext.request.contextPath}/servlet/NewServlet" method="post" onsubmit="return Submt()" class="cmxform">
					<div class="panel">
						<div class="panel-heading">
							<div class="panel-title">添加文章</div>
							<div class="panel-btns pull-right margin-left">
								<a href="${pageContext.request.contextPath }/servlet/NewServlet?op=query&jsp=../manage/article_list.jsp"
								   class="btn btn-default btn-gradient dropdown-toggle" >
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
												for (Type list : lst) {%>
											<option value="<%=list.getTypeId()%>"><%=list.getTypeName() %>
											</option>
											<%}%>
										</select>
									</div>
								</div>
								<div class="form-group">
									<div class="input-group"><span class="input-group-addon">标题</span>
										<input type="text" name="title" value="" class="form-control">
									</div>
								</div>

								<div class="form-group">
									<div class="input-group"><span class="input-group-addon">关键字:</span>
										<input type="text" name="keywords" value="" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<div class="input-group">是否推荐该新闻:
										<input type="radio" name="recommended" value="1" checked="checked"/>推荐
										<input type="radio" name="recommended" value="0"/>不推荐
									</div>
								</div>
							</div>
							<div class="form-group col-md-12">新闻正文:
								<textarea  id="myEditor" name="content" style="width:100%;height:200px;"></textarea>
							</div>
							<div class="col-md-7">
								<div class="form-group">
									<input type="submit" value="提交" class="submit btn btn-blue"/>
									<input type="reset" value="重置" class="submit btn btn-blue"/>
									<input type="hidden" value="add" name="op">
									<input type="hidden" value="/manage/article_list.jsp" name="jsp">
									<input type="hidden" value="0" name="IfselectAll"/>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript">

		//实例化编辑器
		//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
		var ue = UE.getEditor('myEditor',{
			toolbars: [[
			'fullscreen', 'source', '|', 'undo', 'redo', '|',
			'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
			'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
			'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
			'directionalityltr', 'directionalityrtl', 'indent', '|',
			'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify',
			'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
			'insertimage', 'emotion','insertvideo', 'music', 'attachment', 'pagebreak', 'template', 'background', '|',
			'horizontal', 'date', 'time', 'spechars', 'snapscreen', 'wordimage', '|',
			'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|',
			'preview', 'searchreplace'
		]]
		});

		function disableBtn(str) {
			var div = document.getElementById('btns');
			var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
			for (var i = 0, btn; btn = btns[i++];) {
				if (btn.id == str) {
					UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
				} else {
					btn.setAttribute("disabled", "true");
				}
			}
		}
		function enableBtn() {
			var div = document.getElementById('btns');
			var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
			for (var i = 0, btn; btn = btns[i++];) {
				UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
			}
		}

	</script>
		<!-- End: Main -->
<%--		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/manage/umeditor/themes/default/_css/umeditor.css">--%>
<%--		<script src="${pageContext.request.contextPath}/manage/umeditor/umeditor.config.js" type="text/javascript"></script>--%>
<%--		<script src="${pageContext.request.contextPath}/manage/umeditor/editor_api.js" type="text/javascript"></script>--%>
<%--		<script src="${pageContext.request.contextPath}/manage/umeditor/lang/zh-cn/zh-cn.js" type="text/javascript"></script>--%>
<%--		<script type="text/javascript">--%>
<%--		var ue = UM.getEditor('myEditor', {--%>
<%--		autoClearinitialContent: true,--%>
<%--		wordCount: false,--%>
<%--		elementPathEnabled: false,--%>
<%--		initialFrameHeight: 300--%>
<%--		});--%>
<%--		</script>--%>
	</body>

</html>
