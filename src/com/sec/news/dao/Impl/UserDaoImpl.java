package com.sec.news.dao.Impl;

import com.sec.news.dao.DaoUtil;
import com.sec.news.dao.UserDao;
import com.sec.news.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDaoImpl implements UserDao {

    @Override
    public boolean insertUser(User user) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("insert into userInfo values (?,?)");
            //设置参数列表
            pstmt.setString(1,user.getUserName());
            pstmt.setString(2,user.getPassword());
            int i = pstmt.executeUpdate();
            if(i == 0)
            {
                return false;
            }
            else if(i == 1)
            {
                return true;
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
    public boolean deleteUser(int id) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("delete from userInfo where userId = ?");
            //设置参数列表
            pstmt.setInt(1,id);
            int i = pstmt.executeUpdate();
            if(i == 0)
            {
                return false;
            }
            else if(i == 1)
            {
                return true;
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
    public boolean updateUser(User user) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("update userInfo set password = ? where userName = ?");
            //设置参数列表
            pstmt.setString(2,user.getUserName());
            pstmt.setString(1,user.getPassword());
            int i = pstmt.executeUpdate();
            if(i == 0)
            {
                return false;
            }
            else if(i == 1)
            {
                return true;
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
    public boolean existsUser(String username) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select *  from userInfo where userName = ?");
            //设置参数列表
            pstmt.setString(1,username);
            //获得结果集
            rs = pstmt.executeQuery();
            //获取查询行数，存在
            flag = rs.next();
            //结果集赋值
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
    public User selectUserById(int userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = new User();
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select *  from userInfo where userId = ?");
            //设置参数列表
            pstmt.setInt(1,userId);
            //获得结果集
            rs = pstmt.executeQuery();
            //获取查询行数
            rs.next();
            user.setUserId(rs.getInt("userId"));
            user.setUserName(rs.getString("userName"));
            user.setPassword(rs.getString("password"));
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return user;
    }

    @Override
	public boolean validateUser(User user) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean flag = false;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select *  from userInfo where userName = ? and password = ?");
            //设置参数列表
            pstmt.setString(1,user.getUserName());
            pstmt.setString(2,user.getPassword());
            //获得结果集
            rs = pstmt.executeQuery();
            //获取查询行数，存在
            flag = rs.next();
            //结果集赋值
            user.setUserId(rs.getInt("userId"));
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
}
