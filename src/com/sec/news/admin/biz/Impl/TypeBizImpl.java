package com.sec.news.admin.biz.Impl;

import com.sec.news.admin.biz.TypeBiz;
import com.sec.news.dao.Impl.TypeDaoImpl;
import com.sec.news.dao.TypeDao;
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
public class TypeBizImpl implements TypeBiz {

    private  TypeDao typeDao = new TypeDaoImpl();

    /**
     * 添加新闻类型
     *
     * @param type
     * @return 添加是否成功
     */
    @Override
    public boolean addType(Type type) {
        return typeDao.insertNewsType(type) > 0 ?true:false;
    }

    /**
     * 删除新闻类型
     *
     * @param id
     * @return 删除是否成功
     */
    @Override
    public boolean deleteType(int id) throws SQLException {
       return typeDao.deleteNewsType(id) > 0?true:false;
    }

    /**
     * 删除多个新闻类型
     *
     * @param id
     * @return 删除是否成功
     */
    @Override
    public boolean deleteTypeByArray(int[] id) throws SQLException {

        return typeDao.deleteByArray(id);
    }

    /**
     * 修改新闻类型
     *
     * @param type
     * @return 修改是否成功
     */
    @Override
    public boolean updateType(Type type) {
        return typeDao.updateNewsType(type) > 0 ?true:false;
    }

    public Type selectTypeById(int id){
        return typeDao.selectNewsTypeById(id);
    }
    /**
     * 查询所有新闻类型
     *
     * @return
     */
    @Override
    public ArrayList<Type> selectType() {
        return typeDao.selectNewsType();
    }

    @Override
    public ArrayList<Type> selectTypeByPage(PageModel<Type> pageModel) {
        return typeDao.selectNewsType(pageModel);
    }

    /**
     * 查询新闻类型统计数
     *
     * @return 返回统计数
     */
    @Override
    public int selctTypeCount() {
        return typeDao.typeNumCount();
    }

    /**
     * 验证新闻类型是否存在
     *
     * @param typeName
     * @return
     */
    @Override
    public boolean vaildateType(String typeName) {
        return typeDao.existsNewsType(typeName);
    }

    /**
     * 根据编写和名称 验证新闻类型是否存在
     *
     * @param type
     * @return
     */
    @Override
    public boolean vaildateType(Type type) {
        return typeDao.existsNewsType(type);
    }
}
