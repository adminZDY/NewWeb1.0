package com.sec.news.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import com.sec.news.model.*;


public interface TypeDao {
    /**
     * 根据类型对象查询是否存在该类型
     * @param type
     * @return
     */
    public boolean existsNewsType(Type type);

    /**
     * 根据新闻类型查询是否存在该类型
     * @param typeName
     * @return
     */
    public boolean existsNewsType(String typeName);
    /**
     * 将对象直接添加到数据库中
     * @param type
     * @return
     */
    public int insertNewsType(Type type);

    /**
     * 根据类型编号删除类型
     * @param typeId
     * @return
     */
    public int deleteNewsType(int typeId) throws SQLException;

    public boolean deleteByArray(int[] newsId) throws SQLException;

    /**
     * 修改类型
     * @param type
     * @return
     */
    public int updateNewsType(Type type);

    /**
	 * 查询所有类型
	 * @return 类型集合
	 */
	public ArrayList<Type> selectNewsType();

    /**
     * 返回页面
     * @return 分页模型（封装了页数【pageNo】、一页显示多少张【pageSize】）
     */
    public ArrayList<Type> selectNewsType(PageModel<Type> pm);
	
	/**
	 * 查询类型编号下的ID(根据编号查询)
	 * @param typeId 
	 * @return
	 */
	public Type selectNewsTypeById(int typeId);

	/**
	 * 返回类型总数
	 * @return
	 */
	public int typeNumCount();
}
