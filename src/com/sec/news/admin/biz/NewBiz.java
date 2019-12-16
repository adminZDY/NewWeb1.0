package com.sec.news.admin.biz;

import com.sec.news.model.News;
import com.sec.news.model.PageModel;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @author zdy
 * @site XXX
 * @company XXX公司
 * @create 2019-11-20-17:14
 */
public interface NewBiz {

    /**
     * 添加新闻
     * @param news
     * @return
     */
    public boolean addNew(News news);

    /**
     * 删除新闻
     * @param id 根据id删除
     * @return
     */
    public boolean deleteNew(int id);

    /**
     * 删除多个新闻
     * @param newsId 数组
     * @return
     */
    public boolean deleteNewByArray(int[] newsId) throws SQLException;

    /**
     * 修改新闻
     * @param news
     * @return
     */
    public boolean updateNew(News news);

    /**
     * 查询所有新闻
     * @return
     */
    public ArrayList<News> selectNew();

    /**
     * 分页查询
     */
    public void selectNewByPage(PageModel<News> pm);

    /**
     * 统计新闻
     */
    public int selectNewCount();

    /**
     * 统计新闻
     */
    public int selectNewByIdCount(int typeId);

    /**
     * 根据id查询新闻
     * @param id
     * @return
     */
    public News selectNewById(int id);

    /**
     * 根据类型id 查询新闻并分页
     * @param pm
     * @param id
     */
    public void selectNewByType(PageModel<News> pm, int id);
}
