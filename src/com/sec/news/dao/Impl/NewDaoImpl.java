package com.sec.news.dao.Impl;

import com.sec.news.dao.DaoUtil;
import com.sec.news.dao.NewDao;
import com.sec.news.dao.TypeDao;
import com.sec.news.dao.UserDao;
import com.sec.news.model.News;
import com.sec.news.model.PageModel;
import com.sec.news.model.Type;
import com.sec.news.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewDaoImpl implements NewDao {
    @Override
    public int insertNews(News news) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int i = 0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("insert into newsInfo(typeId,userId,title,content,recommended,keywords)" +
                    " values(?,?,?,?,?,?);");
            pstmt.setInt(1, news.getType().getTypeId());
            pstmt.setInt(2, news.getUser().getUserId());
            pstmt.setString(3, news.getTitle());
            pstmt.setString(4, news.getContent());
            pstmt.setInt(5, news.getRecommended());
            pstmt.setString(6, news.getKeywords());
            //获得结果集
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
    public int updateNews(News news) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int i = 0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("update newsInfo set title=?,typeId=?,content=?,keywords=?,recommended=? where newsId = ?");
            pstmt.setString(1, news.getTitle());
            pstmt.setInt(2,news.getType().getTypeId());
            pstmt.setString(3, news.getContent());
            pstmt.setString(4, news.getKeywords());
            pstmt.setInt(5, news.getRecommended());
            pstmt.setInt(6, news.getNewsId());
            System.out.println("update newsInfo set title="+news.getTitle()+",typeId="+news.getType().getTypeId()+"," +
                    " content="+news.getContent()+",keywords="+news.getKeywords()+",recommended="+news.getRecommended()+" where newsId = "+news.getNewsId()+"");
            //获取结果集
            i = pstmt.executeUpdate();
            System.out.println("修改成功"+i);
        }
        catch (Exception e) {
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
    public int deleteNews(int newsId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        int i = 0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("delete from newsInfo where newsId = ?");
            pstmt.setInt(1,newsId);
            //获取结果集
            i = pstmt.executeUpdate();
        }
        catch (Exception e) {
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
    public boolean deleteNewsByType(int typeid){
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = true;
        int i = 0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("delete from newsInfo where typeId = ? ");
            pstmt.setInt(1,typeid);
            //获取结果集
            i = pstmt.executeUpdate();
        }
        catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            flag = false;
        }
        finally
        {
            DaoUtil.closeDB(null, pstmt, con);
        }
        return flag;
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
            StringBuffer sql = new StringBuffer("delete from newsInfo where newsId = 0 ");

            for (int num:newsId){
                sql.append("or newsId = ?");
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
    public News selectByNewsId(int newId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        News news = new News(newId);
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select * from newsInfo where newsid = ?");
            pstmt.setInt(1, news.getNewsId());
            //获取结果集
            rs = pstmt.executeQuery();
            TypeDao typeDao  = new TypeDaoImpl();
            UserDao userdao = new UserDaoImpl();
            while(rs.next())
            {
                String title = rs.getString("title");
                int click = rs.getInt("click");
                int recommended = rs.getInt("recommended");
                String content = rs.getString("content");
                String releaseTime = rs.getString("releaseTime");
                String keywords =  rs.getString("keywords");

                //类型
                Type type = typeDao.selectNewsTypeById(rs.getInt("typeId"));
                //用户
                User user = new User();
                user = userdao.selectUserById(rs.getInt("userId"));
                //新闻信息
                news.setNewsId(rs.getInt("newsId"));
                news.setTitle(title);

                news.setType(type);
                news.setClick(click);
                news.setReleaseTime(releaseTime);
                news.setContent(content);
                news.setKeywords(keywords);
                news.setUser(user);
                news.setRecommended(recommended);
            }
        }
        catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return news;
    }

    @Override
    public void selectNews(PageModel<News> pm) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int i = 0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            String str = String.format("select top %d * from newsInfo where newsId not in" +
                    "(select top %d newsId from newsInfo " +
                    "order by newsId desc)order by newsId desc", pm.getPageSize(),pm.getPageSize()*(pm.getPageNo()-1));

            pstmt = con.prepareStatement(str);
            //获取结果集
            rs = pstmt.executeQuery();
            List<News> lst = new ArrayList<News>();
            TypeDao typeDao  = new TypeDaoImpl();
            UserDao userdao = new UserDaoImpl();
            while(rs.next())
            {
                News news = new News();
                String title = rs.getString("title");
                int click = rs.getInt("click");
                String content = rs.getString("content");
                String releaseTime = rs.getString("releaseTime");
                String keywords =  rs.getString("keywords");
                int recommended = rs.getInt("recommended");

                news.setNewsId(rs.getInt("newsId"));

                //类型
                Type type = typeDao.selectNewsTypeById(rs.getInt("typeId"));

                //用户
                User user = userdao.selectUserById(rs.getInt("userId"));
                //新闻信息

                news.setTitle(title);
                news.setType(type);
                news.setUser(user);
                news.setClick(click);
                news.setReleaseTime(releaseTime);
                news.setContent(content);
                news.setKeywords(keywords);
                news.setRecommended(recommended);
                lst.add(news);
            }
            pm.setPage(lst);

            //得到本次查询新闻总数
            pm.setCountData(lst.size());

            //所有新闻数量
            str = "select * from newsInfo";
            pstmt = con.prepareStatement(str);
            rs = pstmt.executeQuery();
            while(rs.next())
            {
                i++;
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
    }

    /**
     * 查询所有新闻
     *
     * @return 所有新闻集合
     */
    @Override
    public ArrayList<News> selectNews() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<News> lst = new ArrayList<News>();
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select * from newsInfo");
            //获取结果集
            rs = pstmt.executeQuery();
            
            TypeDao typeDao  = new TypeDaoImpl();
            UserDao userdao = new UserDaoImpl();

            while(rs.next())
            {
                News news = new News();
                String title = rs.getString("title");
                int click = rs.getInt("click");
                int recommended = rs.getInt("recommended");
                String content = rs.getString("content");
                String releaseTime = rs.getString("releaseTime");
                String keywords =  rs.getString("keywords");

                //类型
                Type type = typeDao.selectNewsTypeById(rs.getInt("typeId"));
                //用户
                User user = new User();
                user = userdao.selectUserById(rs.getInt("userId"));
                //新闻信息
                news.setNewsId(rs.getInt("newsId"));
                news.setTitle(title);

                news.setType(type);
                news.setClick(click);
                news.setReleaseTime(releaseTime);
                news.setContent(content);
                news.setKeywords(keywords);
                news.setUser(user);
                news.setRecommended(recommended);
                lst.add(news);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return (ArrayList<News>) lst;
    }

    @Override
    public void selectNewsByTypeId(PageModel<News> pm, int typeId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int i = 0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select top "+pm.getPageSize()+" * from (select *  from newsInfo where typeId = "+typeId+")as table1 "+
                    " where newsId not in(select top "+pm.getPageSize()*(pm.getPageNo()-1)+" newsId from " +
                    "(select *  from newsInfo where typeId = "+typeId+")as table1)");
            //获取结果集
            rs = pstmt.executeQuery();
            List<News> lst = new ArrayList<News>();
            TypeDao typeDao  = new TypeDaoImpl();
            UserDao userdao = new UserDaoImpl();

            while(rs.next())
            {
                News news = new News();
                String title = rs.getString("title");
                int click = rs.getInt("click");
                int recommended = rs.getInt("recommended");
                String content = rs.getString("content");
                String releaseTime = rs.getString("releaseTime");
                String keywords =  rs.getString("keywords");

                //类型
                Type type = typeDao.selectNewsTypeById(rs.getInt("typeId"));
                //用户
                User user = new User();
                user = userdao.selectUserById(rs.getInt("userId"));
                //新闻信息
                news.setNewsId(rs.getInt("newsId"));
                news.setTitle(title);

                news.setType(type);
                news.setClick(click);
                news.setReleaseTime(releaseTime);
                news.setContent(content);
                news.setKeywords(keywords);
                news.setUser(user);
                news.setRecommended(recommended);
                lst.add(news);
            }
            pm.setPage(lst);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
    }

    @Override
    public int selectNewsCount() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select count(*) as 'num' from newsInfo");
            //获取结果集
            rs = pstmt.executeQuery();
            while(rs.next())
            {
                count = rs.getInt("num");
            }
        }
        catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return count;
    }

    @Override
    public int selectNewsByIdCount(int typeid) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count=0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select count(*) as 'num' from newsInfo where typeId = ?");
            pstmt.setInt(1,typeid);
            //获取结果集
            rs = pstmt.executeQuery();
            while(rs.next())
            {
                count = rs.getInt("num");
            }
        }
        catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return count;
    }

    @Override
    /**
     * 分页模糊查询
     */
    public void selectNewsdim(PageModel<News> pm,String text) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int i = 0;
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("select top "+pm.getPageSize()+" * from " +
                    "(select *  from newsInfo where content like '%"+text+"%' or title like '%"+text+"%' or keywords like '%"+text+"%')as table1 "+
                    " where newsId not in(select top "+pm.getPageSize()*(pm.getPageNo()-1)+" newsId from " +
                    "(select *  from newsInfo where content like '%"+text+"%' or title like '%"+text+"%' or keywords like '%"+text+"%')as table1)");
            //获取结果集
            rs = pstmt.executeQuery();
            List<News> lst = new ArrayList<News>();
            TypeDao typeDao  = new TypeDaoImpl();
            UserDao userdao = new UserDaoImpl();

            while(rs.next())
            {
                News news = new News();
                String title = rs.getString("title");
                int click = rs.getInt("click");
                int recommended = rs.getInt("recommended");
                String content = rs.getString("content");
                String releaseTime = rs.getString("releaseTime");
                String keywords =  rs.getString("keywords");

                //类型
                Type type = typeDao.selectNewsTypeById(rs.getInt("typeId"));
                //用户
                User user = new User();
                user = userdao.selectUserById(rs.getInt("userId"));
                //新闻信息
                news.setNewsId(rs.getInt("newsId"));
                news.setTitle(title);

                news.setType(type);
                news.setClick(click);
                news.setReleaseTime(releaseTime);
                news.setContent(content);
                news.setKeywords(keywords);
                news.setUser(user);
                news.setRecommended(recommended);
                lst.add(news);
            }
            pm.setPage(lst);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
    }

    @Override
    public boolean updatecount(int newsid,int count) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int i = 0;
        boolean f = true;
        try{
            conn = DaoUtil.getConn();

            ps = conn.prepareStatement("update newsinfo set click = ? where newsid = ?");
            ps.setInt(1,count);
            ps.setInt(2,newsid);

            i = ps.executeUpdate();

            if(i <= 0 ){
                f = false;
            }
        }catch (Exception e){
            f = false;
        }
        return f;
    }

    @Override
    public List<News> selectTopNews(int selectNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<News> lst = new ArrayList<News>();
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("SELECT TOP "+selectNum+" * FROM newsInfo " +
                    "ORDER BY releaseTime DESC");
            //获取结果集
            rs = pstmt.executeQuery();

            TypeDao typeDao  = new TypeDaoImpl();
            UserDao userdao = new UserDaoImpl();

            while(rs.next())
            {
                News news = new News();
                String title = rs.getString("title");
                int click = rs.getInt("click");
                int recommended = rs.getInt("recommended");
                String content = rs.getString("content");
                String releaseTime = rs.getString("releaseTime");
                String keywords =  rs.getString("keywords");

                //类型
                Type type = typeDao.selectNewsTypeById(rs.getInt("typeId"));
                //用户
                User user = new User();
                user = userdao.selectUserById(rs.getInt("userId"));
                //新闻信息
                news.setNewsId(rs.getInt("newsId"));
                news.setTitle(title);

                news.setType(type);
                news.setClick(click);
                news.setReleaseTime(releaseTime);
                news.setContent(content);
                news.setKeywords(keywords);
                news.setUser(user);
                news.setRecommended(recommended);
                lst.add(news);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return (ArrayList<News>) lst;
    }

    @Override
    public List<News> selectHotNews(int selectNum) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<News> lst = new ArrayList<News>();
        try {
            //打开连接
            con = DaoUtil.getConn();
            pstmt = con.prepareStatement("SELECT TOP "+selectNum+" * FROM newsInfo" +
                    " ORDER BY recommended DESC, releaseTime DESC");
            //获取结果集
            rs = pstmt.executeQuery();

            TypeDao typeDao  = new TypeDaoImpl();
            UserDao userdao = new UserDaoImpl();

            while(rs.next())
            {
                News news = new News();
                String title = rs.getString("title");
                int click = rs.getInt("click");
                int recommended = rs.getInt("recommended");
                String content = rs.getString("content");
                String releaseTime = rs.getString("releaseTime");
                String keywords =  rs.getString("keywords");

                //类型
                Type type = typeDao.selectNewsTypeById(rs.getInt("typeId"));
                //用户
                User user = new User();
                user = userdao.selectUserById(rs.getInt("userId"));
                //新闻信息
                news.setNewsId(rs.getInt("newsId"));
                news.setTitle(title);

                news.setType(type);
                news.setClick(click);
                news.setReleaseTime(releaseTime);
                news.setContent(content);
                news.setKeywords(keywords);
                news.setUser(user);
                news.setRecommended(recommended);
                lst.add(news);
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        finally
        {
            DaoUtil.closeDB(rs, pstmt, con);
        }
        return (ArrayList<News>) lst;
    }
}
