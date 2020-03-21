package gallery;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GalleryDAO {
	private final String url = "jdbc:mysql://localhost:3306/project1";
	private final String id = "root";
	private final String pwd = "1234";
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	String SQL = "";
	
	public Connection getConnection(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url,id,pwd);
		}
		catch (Exception e){
			System.out.println("GalleryDAO getConnection Method Error : " + e);
			e.printStackTrace();
		}
		return conn;
	}
	public void resourceFree() {
		try {
			if(rs != null)rs.close();
			if(pstmt != null)pstmt.close();
			if(conn != null)conn.close();
		} catch (SQLException e) {
			System.out.println("resourceFree Method Error : " + e);
		}
	}
	public int galleryWrite(GalleryBean gBean){
		int result = 0 ;
		try{
			SQL = "insert into gallery (email,passwd,nickname,subject,content,file,date,readcount) "
					+ "values(?,?,?,?,?,?,?,?)";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, gBean.getEmail());
			pstmt.setString(2, gBean.getPasswd());
			pstmt.setString(3, gBean.getNickname());
			pstmt.setString(4, gBean.getSubject());
			pstmt.setString(5, gBean.getContent());
			pstmt.setString(6, gBean.getFile());
			pstmt.setTimestamp(7, gBean.getDate());
			pstmt.setInt(8, 0);
			
			result = pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("galleryWrite Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	public ArrayList<GalleryBean> galleryListCheck(){
		ArrayList<GalleryBean> arr = new ArrayList<GalleryBean>();
		try{
			SQL = "select * from gallery order by num desc";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				GalleryBean gBean = new GalleryBean();
				gBean.setNum(rs.getInt("num"));
				gBean.setEmail(rs.getString("passwd"));
				gBean.setNickname(rs.getString("nickname"));
				gBean.setSubject(rs.getString("subject"));
				gBean.setContent(rs.getString("content"));
				gBean.setFile(rs.getString("file"));
				gBean.setReadcount(rs.getInt("readcount"));
				gBean.setDate(rs.getTimestamp("date"));
				arr.add(gBean);
			}
		}
		catch (Exception e){
			System.out.println("galleryListCheck Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		
		return arr;
	}

//	UPDATE 테이블명 SET 컬럼1 = 수정값1 [, 컬럼2 = 수정값2 ...] [WHERE 조건];
	public int galleryIncreaseReadcount(int num){
		int result = 0;
		try{
			SQL = "update gallery set readcount = readcount + 1 where num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("galleryIncreaseReadcount Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	/*	num	int(11)
	email	varchar(30)
	passwd	varchar(20)
	nickname	varchar(15)
	subject	varchar(50)
	content	varchar(2000)
	file	varchar(50)
	readcount	int(11)
	date	datetime
	 */		
	public GalleryBean galleryInto(int num){
		GalleryBean gBean = new GalleryBean();
		try{
			SQL = "select * from gallery where num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				gBean.setNum(rs.getInt("num"));
				gBean.setEmail(rs.getString("email"));
				gBean.setPasswd(rs.getString("passwd"));
				gBean.setNickname(rs.getString("nickname"));
				gBean.setSubject(rs.getString("subject"));
				gBean.setContent(rs.getString("content"));
				gBean.setFile(rs.getString("file"));
			}
		}
		catch (Exception e){
			System.out.println("galleryInto Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return gBean;
	}
	public int galleryDelete(int num){
		int result = 0 ;
		try{
			SQL = "delete from gallery where num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("galleryDelete Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	public int galleryReWrite(GalleryBean gBean){
		int result = 0;
		try{
			SQL = "update gallery set passwd = ? , subject= ? , content = ? , file = ? where num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, gBean.getPasswd());
			pstmt.setString(2, gBean.getSubject());
			pstmt.setString(3, gBean.getContent());
			pstmt.setString(4, gBean.getFile());
			pstmt.setInt(5, gBean.getNum());
			result = pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("galleryReWrite Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	
	
	
	
	
	
	
	
	
}
