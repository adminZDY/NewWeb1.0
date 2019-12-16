package com.sec.news.dao.Impl;

import com.sec.news.dao.DaoUtil;
import com.sec.news.dao.NewDao;
import com.sec.news.dao.TypeDao;
import com.sec.news.model.PageModel;
import com.sec.news.model.Type;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class TypeDaoImpl implements TypeDao {
    @Override
    public boolean existsNewsType(String typeName) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
            //打开连接
            con = DaoUtil.getConn();
            //查询不为该编号是否有该名称
            pstmt = con.prepareStatement("select * from newsTypeInfo where typeName = ? and typeId != 0");
            pstmt.setString(1, typeName);
            //获得结果集
            rs = pstmt.executeQuery();
            //获取查询行数
            while(rs.next())
            {
                //查询到说明已经重复了
                flag = true;
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return flag;
    }

    @Override
    public boolean existsNewsType(Type type) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
            //打开连接
            con = DaoUtil.getConn();
            //查询不为该编号是否有该名称
            pstmt = con.prepareStatement("select * from newsTypeInfo where typeName = ? and typeId != ?");
            pstmt.setString(1, type.getTypeName());
            pstmt.setInt(2, type.getTypeId());
            //获得结果集
            rs = pstmt.executeQuery();
            //获取查询行数
            while(rs.next())
            {
                //查询到说明已经重复了
                flag = true;
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return flag;
    }

    @Override
    public int insertNewsType(Type type) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int i=0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("insert into newsTypeInfo values(?,?)");
            pstmt.setString(1, type.getTypeName());
            pstmt.setString(2, type.getRemark());
            i = pstmt.executeUpdate();
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(null, pstmt, con);
        }
        return i;
    }

    @Override
    public int deleteNewsType(int typeId) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        int i=0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            con.setAutoCommit(false);
            NewDao newDao = new NewDaoImpl();
            newDao.deleteNewsByType(typeId);
            pstmt = con.prepareStatement("delete from newsTypeInfo where typeId = ?");
            pstmt.setInt(1, typeId);
            i = pstmt.executeUpdate();
            con.commit();
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            con.rollback();
        }
        finally
        {
            DaoUtil.closeDB(null, pstmt, con);
        }
        return i;
    }

    @Override
    public boolean deleteByArray(int[] newsId) throws SQLException {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = true;
        int i = 0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            con.setAutoCommit(false);

            NewDao newDao = new NewDaoImpl();
            if(!newDao.deleteByArray(newsId)){
                throw new Exception("删除新闻类型失败");
            }

            StringBuffer sql = new StringBuffer("delete from newsTypeInfo where typeId = ? ");

            for (int num:newsId){
                sql.append("or typeId = ?");
            }

            pstmt = con.prepareStatement(sql.toString());

            for (int index = 0; index<newsId.length;index++){
                pstmt.setInt(index+1,newsId[index]);
            }
            //获取结果集
            i = pstmt.executeUpdate();
            con.commit();
        }
        catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            con.rollback();
            flag = false;
        }
        finally
        {
            DaoUtil.closeDB(null, pstmt, con);
        }
        return flag;
    }

    @Override
    public int updateNewsType(Type type) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int i=0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("update newsTypeInfo set typeName = ? ,remark = ? where typeId = ?");
            pstmt.setString(1, type.getTypeName());
            pstmt.setString(2, type.getRemark());
            pstmt.setInt(3, type.getTypeId());
            i = pstmt.executeUpdate();
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(null, pstmt, con);
        }
        return i;
    }

    @Override
    public ArrayList<Type> selectNewsType() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Type> lst = new ArrayList<Type>();
        try {
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select * from newsTypeInfo");
            //获得结果集
            rs = pstmt.executeQuery();
            //获取查询行数
            while(rs.next())
            {
                Type type = new Type();
                type.setTypeId(rs.getInt("typeId"));
                type.setTypeName(rs.getString("typeName"));
                type.setRemark(rs.getString("remark"));
                lst.add(type);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return lst;
    }

    @Override
    public ArrayList<Type> selectNewsType(PageModel<Type> pm) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Type> lst = new ArrayList<Type>();
        try {
            int no = pm.getPageNo();
            int size = pm.getPageSize();
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select top "+size+" * from newsTypeInfo where typeId not in" +
                    "(select top (?*(?-1)) typeId from newsTypeInfo)");
            pstmt.setInt(1, size);
            pstmt.setInt(2, no);
            //获得结果集
            rs = pstmt.executeQuery();
            //获取查询行数
            while(rs.next())
            {
                Type type = new Type();
                type.setTypeId(rs.getInt("typeId"));
                type.setTypeName(rs.getString("typeName"));
                type.setRemark(rs.getString("remark"));
                pm.getPage().add(type);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return lst;
    }

    @Override
    public Type selectNewsTypeById(int typeId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Type type = new Type(typeId);
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select * from newsTypeInfo where typeId = ?");
            pstmt.setInt(1, type.getTypeId());
            //获得结果集
            rs = pstmt.executeQuery();
            //获取查询行数
            if(rs.next())
            {
                type.setTypeId(rs.getInt("typeId"));
                type.setTypeName(rs.getString("typeName"));
                type.setRemark(rs.getString("remark"));
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return type;
    }

    @Override
    public int typeNumCount() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int i = 0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select count(*) as 'num' from newsTypeInfo ");
            //获得结果集
            rs = pstmt.executeQuery();
            //获取查询行数
            while(rs.next())
            {
                i = rs.getInt("num");
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return i;
    }
}
