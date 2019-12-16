package com.sec.news.dao;

import com.sec.news.model.News;
import com.sec.news.model.PageModel;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public interface NewDao{
	/**
	 * 发布新闻
	 * @param news
	 * @return
	 */
	public int insertNews(News news);
	
	/**
	 * 修改新闻
	 * @param news
	 * @return
	 */
	public int updateNews(News news);
	
	/**
	 * 删除新闻
	 * @param newsId 新闻Id
	 * @return
	 */
	public int deleteNews(int newsId);

    /**
     * 删除多个新闻
     * @param newsId 要删除的所有编号（数组）
     * @return
     */
    public boolean deleteByArray(int[] newsId) throws SQLException;

    /**
     * 根据类型删除新闻
     * @param typeid
     * @return
     */
    public boolean deleteNewsByType(int typeid);

    /**
     * 用户事先设置好类型Id然后在该方法，初始化其他值
     * 根据新闻编号查询新闻信息
     * @param newId 封装该类型的所有新闻
     * 新闻对象
     */
    public News selectByNewsId(int newId);

    /**
     * （查询所有类型的新闻）
     * 查询所有新闻(分页查询)
     * @param pm 所有新闻集合
     * @return 所有新闻总数
     */
    public void selectNews(PageModel<News> pm);

    /**
     * 查询所有新闻
     * @return 所有新闻集合
     */
    public ArrayList<News> selectNews();

	/**
	 * (下拉列表查询指定类型新闻)类型管理查询
	 * 根据类型查询新闻信息并且分页
	 * @param pm 封装该类型的新闻分页对象
	 * @param typeId 类型编号
	 * @return 该类型新闻总数
	 */
	public void selectNewsByTypeId(PageModel<News> pm, int typeId);

	/**
	 * 查询新闻总数据量
	 * @return
	 */
	public int selectNewsCount();

	/**
	 * 根据类型ID查询所有新闻的总数据量
	 * @param typeid
	 * @return
	 */
	public int selectNewsByIdCount(int typeid);

	/**
	 * 模糊查询
	 * @param  pm
	 * @param text
	 * @return
	 */
	public void selectNewsdim(PageModel<News> pm, String text);

	/**
	 * 访问次数
	 * @param count
	 */
	public boolean updatecount(int newsid, int count);

	/**
	 * 根据时间降序查询新闻
	 * @param selectNum
	 * @return
	 */
	public List<News> selectTopNews(int selectNum);

	/**
	 * 根据时间，推荐状态降序查询
	 * @param selectNum
	 * @return
	 */
	public List<News> selectHotNews(int selectNum);
}
