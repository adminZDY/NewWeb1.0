package com.sec.news.filter.front;

import com.sec.news.dao.Impl.NewDaoImpl;
import com.sec.news.dao.NewDao;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.LogRecord;

public class FrontFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;

        try {
            int newsid = Integer.parseInt(request.getParameter("newsid"));
            int count = Integer.parseInt(request.getParameter("click"));

            NewDao newDao = new NewDaoImpl();
            newDao.updatecount(newsid, count++);

            filterChain.doFilter(request,response);
        }catch (Exception e){
            response.sendRedirect("");
        }

    }

    @Override
    public void destroy() {

    }
}
