package com.sec.news.control;

import com.sec.news.admin.biz.Impl.UserBizImpl;
import com.sec.news.admin.biz.NewBiz;
import com.sec.news.admin.biz.UserBiz;
import com.sec.news.biz.FrontBiz;
import com.sec.news.biz.Impl.FrontBizImpl;
import com.sec.news.dao.Impl.NewDaoImpl;
import com.sec.news.dao.NewDao;
import com.sec.news.model.News;
import com.sec.news.model.PageModel;
import com.sec.news.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 处理用户登录、注销、修改密码的业务逻辑
 * @author 陈
 *
 */
public class FrontServlet extends HttpServlet {

	//创建全局的数据访问类对象
	private UserBiz userBiz = new UserBizImpl();
	private FrontBiz frontBiz = new FrontBizImpl();
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
		if("query".equals(op))
		{
			this.query(request, response);
		}
		else if("show_pvw".equals(op))
		{
			this.show_pvw(request,response);
		}else if("type_dim".equals(op)){
			try {
				this.type_dim(request,response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void query(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int pageNo = 1;//页面，初始化为1
		int pageSize = 20;//每页数据条数，初始化为6
		int typeId = 0;//类型编号
		//类型转换
		try {pageNo = Integer.parseInt(request.getParameter("pageNo"));
		}catch (Exception e) {}

		try {
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}catch (Exception e) {}

		try {
			typeId = Integer.parseInt(request.getParameter("typeId"));
		}catch (Exception e) {
			typeId = 0;
		}

		try {
			PageModel<News> pm = new PageModel<News>();
			pm.setPageNo(pageNo);
			pm.setPageSize(pageSize);
			//判断是否根据新闻类型查询
			if(typeId == 0)
			{
				frontBiz.selectNewByPage(pm);
				pm.setCountData(frontBiz.selectNewCount());
			}else {
				frontBiz.selectNewByType(pm,typeId);//查询指定类型的新闻
				pm.setCountData(frontBiz.selectNewsByIdCount(typeId));
			}
			//将PageModel对象存入request对象中
			request.setAttribute("data", pm);
			request.setAttribute("typeId",typeId);
			request.setAttribute("pageNo",pageNo);
			//转发到指定页面
			request.getRequestDispatcher("/front/newsList.jsp").forward(request, response);
		} catch (Exception e) {
			//设置异常信息到request中
			e.printStackTrace();
			request.setAttribute("msg", e.getMessage());

			//转发到错误页面
			this.error(request, response);
		}

	}

	/**
	 * 预览
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void show_pvw(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int newsId = 0;
		int count = 0;

		//类型转换
		try {
			//得到被修改新闻的编号
			newsId = Integer.parseInt(request.getParameter("newsId"));
		}catch (Exception e){

		}
		try {
			//获取点击次数
			count = frontBiz.selectByNewsId(newsId).getClick();
		}catch (Exception e){

		}
		try {
			//修改点击次数
			frontBiz.updatcount(newsId, ++count);
			//调用业务访问类的方法，查询新闻信息
			News news = frontBiz.selectNewById(newsId);
			//将段落标签<p>转换为\r\n方便在<textarea>中显示是保持格式
			news.setContent(news.getContent().replaceAll("<p>", "\r\n"));
			//将查询出的新闻信息设置到request属性中
			request.setAttribute("data", news);
			//转发到修改新闻页面
			request.getRequestDispatcher("/front/show.jsp").forward(request, response);
		} catch (Exception e) {
			System.out.println(e);
			// TODO: handle exception
			request.setAttribute("msg", e.getMessage());
			this.error(request, response);
		}
	}

	public void type_dim(HttpServletRequest request , HttpServletResponse response) throws Exception{
		int pageNo = 1;//页面，初始化为1
		int pageSize = 6;//每页数据条数，初始化为6
		String text = "";//类型编号
		//类型转换
		try {
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
		}catch (Exception e) {}

		try {
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}catch (Exception e) {}

		try {
			text = request.getParameter("IfselectAll");
		}catch (Exception e) {
			text = "";
		}

		try {
			PageModel<News> pm = new PageModel<News>();
			pm.setPageNo(pageNo);
			pm.setPageSize(pageSize);

			//判断是否根据字符串
			frontBiz.selectNewsdim(pm,text);//查询指定字符串
			pm.setCountData(frontBiz.selectNewCount());

			//将PageModel对象存入request对象中
			request.setAttribute("data", pm);
			//要转发的jsp页面
			String jsp = request.getParameter("jsp");
			//转发到指定页面
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (Exception e) {
			//设置异常信息到request中
			e.printStackTrace();
			request.setAttribute("msg", e.getMessage());

			//转发到错误页面
			this.error(request, response);
		}
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
