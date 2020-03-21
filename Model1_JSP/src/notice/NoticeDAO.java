package notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import member.DBConnection;

public class NoticeDAO {
	private final String url = "jdbc:mysql://localhost:3306/project1";
	private final String id = "root";
	private final String pwd = "1234";
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	String SQL = ""; 
	
	/*
	 * public NoticeDAO() { DBConnection DBC = new DBConnection(); conn =
	 * DBC.getConnection(); }
	 */
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url,id,pwd);
		
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	return conn;

	}
	public void resourceFree() {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		catch (Exception e) {
			System.out.println("resourceFree Method Error : " + e);
		}
	}
	
	public int noticeWrite(NoticeBean nBean) {
		int result = 0;
		try {
			SQL = "insert into notice (email, nickname, passwd, subject ,content, file, readcount, date ,ip)  "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, nBean.getEmail());
			pstmt.setString(2, nBean.getNickname());
			pstmt.setString(3, nBean.getPasswd());
			pstmt.setString(4, nBean.getSubject());
			pstmt.setString(5, nBean.getContent());
			pstmt.setString(6, nBean.getFile());
			pstmt.setInt(7, 0);
			pstmt.setTimestamp(8, nBean.getDate());
			pstmt.setString(9, nBean.getIp());
			
			result = pstmt.executeUpdate();

		}
		catch (Exception e) {
			System.out.println("noticeWrite Method Error : " + e);
			e.printStackTrace();
		}
		finally {
			resourceFree();
		}
		return result;
	}
	
	public int noticeSizeCheck() {
		int result = 0;
		try {
			SQL = "select count(*) from notice";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}
		catch (Exception e) {
			System.out.println("noticeSizeCheck Method Error : " + e);
		}
		finally {
			resourceFree();
		}
	  	return result;
	}
	
	public ArrayList<NoticeBean> noticeListCheck(int currentPage , int size){
		ArrayList<NoticeBean> arr = new ArrayList<NoticeBean>();
		try {
			SQL = "select * from notice order by num desc limit ? , ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, currentPage);
			pstmt.setInt(2, size);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				NoticeBean nBean = new NoticeBean();
				nBean.setNum(rs.getInt("num"));
				nBean.setEmail(rs.getString("email"));
				nBean.setNickname(rs.getString("nickname"));
				nBean.setSubject(rs.getString("subject"));
				nBean.setContent(rs.getString("content"));
				nBean.setDate(rs.getTimestamp("date"));
				nBean.setReadcount(rs.getInt("readcount"));
				arr.add(nBean);
			}
		}
		catch (Exception e) {
			System.out.println("noticeListCheck Method Error : " + e);
			e.printStackTrace();
		}
		finally {
			resourceFree();
		}
		return arr;
	}
	public int noticeIncreaseReadcount(int num) {
		int result = 0;
			try {
				SQL = "update notice set readcount = readcount + 1 where num = ?";
				conn = getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, num);
				result = pstmt.executeUpdate();
			}
			catch (Exception e){
				System.out.println("noticeIncreaseCount Method Error : " + e);
				e.printStackTrace();
			}
			finally {
				resourceFree();
			}
		return result;
	}
	public NoticeBean noticeInto(int num) {
		NoticeBean nBean = new NoticeBean();
		try {
			SQL = "select * from notice where num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				nBean.setNum(rs.getInt("num"));
				nBean.setEmail(rs.getString("email"));
				nBean.setNickname(rs.getString("nickname"));
				nBean.setSubject(rs.getString("subject"));
				nBean.setContent(rs.getString("content"));
				nBean.setDate(rs.getTimestamp("date"));
				nBean.setReadcount(rs.getInt("readcount"));
			}
		} 
		catch (Exception e) {
			System.out.println("noticeInto Method Error : " + e);
			e.printStackTrace();
		} 
		finally {
			resourceFree();
		}
		
		return nBean;
	}
	public int noticeDel(int num){
		int result = 0 ;
		try{
			SQL = "delete from notice where num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("noticeDel Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		
		return result;
	}
//	UPDATE 테이블명 SET 컬럼1 = 수정값1 [, 컬럼2 = 수정값2 ...] [WHERE 조건];
	public int noticeReWrite(NoticeBean nBean){
		int result = 0;
		try{
			SQL = "update notice set email = ? , nickname = ? , passwd = ? , subject = ? , content = ? , date = ? , ip = ? where num = ? ";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, nBean.getEmail());
			pstmt.setString(2, nBean.getNickname());
			pstmt.setString(3, nBean.getPasswd());
			pstmt.setString(4, nBean.getSubject());
			pstmt.setString(5, nBean.getContent());
			pstmt.setTimestamp(6, nBean.getDate());
			pstmt.setString(7, nBean.getIp());
			pstmt.setInt(8, nBean.getNum());
			result = pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("noticeReWrite Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
