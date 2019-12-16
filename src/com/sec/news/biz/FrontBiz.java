package com.sec.news.biz;

import com.sec.news.model.News;
import com.sec.news.model.PageModel;
import com.sec.news.model.Type;

import java.util.ArrayList;
import java.util.List;

public interface FrontBiz {


    /**
     * 查询所有新闻
     * @return
     */
    public ArrayList<News> selectNew();
    /**
     * 根据类型的id查询新闻分页
     * @param pm
     * @param id
     */
    public void selectNewByType(PageModel<News> pm, int id);

    /**
     * 根据id查询新闻
     * @param typeid
     * @return
     */
    public News selectNewById(int typeid);

    /**
     * 分页查询
     * @param pm
     */
    public void selectNewByPage(PageModel<News> pm);


    /**
     *统计
     * @return
     */
    public int selectNewCount();

    /**
     * 根据类型id统计新闻
     * @param typeid
     * @return
     */
    public int selectNewsByIdCount(int typeid);
    /**
     * 查询所有类型
     * @return 类型集合
     */
    public ArrayList<Type> selectNewsType();

    //模糊查询
    public void selectNewsdim(PageModel<News> pm, String text);

    //修改新闻次数
    public boolean updatcount(int newsid, int count);

    /**
     * 根据时间降序查询新闻
     * @param selectNum
     * @return
     */
    public List<News> selectTopNews(int selectNum);

    public List<News> selectHotNews(int selectNum);

    /**
     * 根据新闻id查询新闻
     * @param newId
     * @return
     */
    public News selectByNewsId(int newId);
}
