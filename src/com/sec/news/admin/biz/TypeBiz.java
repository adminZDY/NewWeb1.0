package com.sec.news.admin.biz;

import com.sec.news.model.PageModel;
import com.sec.news.model.Type;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @author zdy
 * @site XXX
 * @company XXX公司
 * @create 2019-11-20-17:14
 */
public interface TypeBiz {
    /**
     * 添加新闻类型
     * @return 添加是否成功
     */
    public boolean addType(Type type);

    /**
     * 删除新闻类型
     * @return 删除是否成功
     */
    public boolean deleteType(int id) throws SQLException;

    /**
     * 删除多个新闻类型
     * @return 删除是否成功
     */
    public boolean deleteTypeByArray(int[] id) throws SQLException;

    /**
     * 修改新闻类型
     * @return 删除是否成功
     */
    public boolean updateType(Type type);

    /**
     * 根据Id查询类型
     * @param id
     * @return
     */
    public Type selectTypeById(int id);

    /**
     * 查询所有新闻类型
     * @return
     */
    public ArrayList<Type> selectType();

    /**
     * 分页查询新闻类型
     * @param pageModel
     * @return
     */
    public ArrayList<Type> selectTypeByPage(PageModel<Type> pageModel);

    /**
     * 查询新闻类型统计数
     * @return 返回统计数
     */
    public int selctTypeCount();

    /**
     * 根据名称 验证新闻类型是否存在
     * @return
     */
    @Deprecated
    public boolean vaildateType(String typeName);

    /**
     * 根据编写和名称 验证新闻类型是否存在
     * @return
     */
    public boolean vaildateType(Type type);
}
