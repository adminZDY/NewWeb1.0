package com.sec.news.control;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sec.news.admin.biz.Impl.UserBizImpl;
import com.sec.news.admin.biz.UserBiz;
import com.sec.news.model.User;

/**
 * 处理用户登录、注销、修改密码的业务逻辑
 * @author 郑
 *
 */
public class UserServlet extends HttpServlet {

	//创建全局的数据访问类对象
	private UserBiz userBiz = new UserBizImpl();

	private String baseURL=null;
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}


	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.baseURL = request.getContextPath();
		// 得到参数op的值
		String op = request.getParameter("op");

		//out.println("<script>alert(\""+op+"\");</script>");
		// 根据op的值执行不同的方法
		if ("login".equals(op)) {
			// 调用登录方法
			this.login(request, response);
		}
		else if("logout".equals(op))
		{
			this.logout(request, response);
		}
		else if("update".equals(op))
		{
			this.update(request, response);
		}
	}
	
	/**
	 * 登录的方法
	 */
	public void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//得到表单数据
		String userName = request.getParameter("userName").trim();
		String password = request.getParameter("password").trim();
		User user = new User(userName,password);
		//调用数据访问类的方法判断登录是否成功
		boolean flag = userBiz.adminLogin(user);
		//登录成功，将用户信息存入Session中，并跳转到manage.jsp
		if(flag)
		{
			//用户信息存入Session
			request.getSession().setAttribute("user", user);
			//创建时间
			Date date = new Date();
			SimpleDateFormat ft = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
			//时间存入session
			request.getSession().setAttribute("date", ft.format(date));
			//跳转到manage.jsp
			response.sendRedirect(baseURL+"/manage/index.jsp");
		}
		//登录失败，转发到登录页面，提示用户输入错误
		else
		{
			response.sendRedirect(baseURL+"/manage/login.jsp?user="+userName);
		}
	}
	
	/**
	 * 修改用户密码的方法
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void update(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取表单提交的数据
		//新密码
		String newPwd =request.getParameterValues("newPwd")[0];
		//获取Session值，根据Session值和用户旧密码进行验证，如果不同，提示用户
		User user = (User)request.getSession().getAttribute("user");
		user.setPassword(newPwd);
		//如果成功,操作数据库和Session进行修改，后转到主页
		if(userBiz.updateUserInfo(user))
		{
			//跳转到主界面
			response.sendRedirect(baseURL+"/manage/welcome.jsp");
		}
		else
		{
			error(request, response);
		}
	}
	
	/**
	 * 注销用户的方法 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void logout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//移除Session中保存的用户数据
		request.getSession().removeAttribute("user");
		//跳转到登录界面
		response.sendRedirect(baseURL+"/manage/login.jsp");
	}
	
	/**
	 * 错误界面
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void error(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//转发到错误提示页面
		request.getRequestDispatcher(baseURL+"/manage/error.jsp").forward(request, response);
	}
}
