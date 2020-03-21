package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class CommentDAO {
	private final String url = "jdbc:mysql://localhost:3306/project1";
	private final String id = "root";
	private final String pwd = "1234";
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	String SQL = "";
	
/*	public CommentDAO(){
		DBConnection DBC = new DBConnection();
		conn = DBC.getConnection();
	}
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
	public void resourceFree(){
		try {
			if(rs != null)rs.close();
			if(pstmt != null)pstmt.close();
			if(conn != null)conn.close();
		} catch (SQLException e) {
			System.out.println("resourceFree Method Error : " + e);
		}
	}
	
/*	num int(11) 
	email varchar(30) 
	nickname varchar(15) 
	reg_date datetime*/	
	
	public int commentWrite(CommentBean cBean){
		int result = 0;
		int reg_seq = 0 ;
		try {
			SQL = "select max(reg_seq) from comment where num = ? ";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cBean.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){
				reg_seq = rs.getInt(1) + 1;
			}
			
			SQL = "insert into comment (num ,email, nickname, content, date, reg_seq)"
					+ " values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cBean.getNum());
			pstmt.setString(2, cBean.getEmail());
			pstmt.setString(3, cBean.getNickname());
			pstmt.setString(4, cBean.getContent());
			pstmt.setTimestamp(5, cBean.getDate());
			pstmt.setInt(6, reg_seq);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("commentWrite Method Error : " + e);
		} finally{
			resourceFree();
		}
		return result;
	}

	public ArrayList<CommentBean> commentListCheck(int boardNum){
		ArrayList<CommentBean> arr = new ArrayList<CommentBean>();
		try {
			System.out.println("commentListCheck 호출 !!!");
			SQL = "select * from comment where num = ? order by reg_seq desc";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardNum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				CommentBean cBean = new CommentBean();
				cBean.setNum(rs.getInt("num"));
				cBean.setEmail(rs.getString("email"));
				cBean.setNickname(rs.getString("nickname"));
				cBean.setContent(rs.getString("content"));
				cBean.setDate(rs.getTimestamp("date"));
				cBean.setReg_seq(rs.getInt("reg_seq"));
				System.out.println("cBeanArr 데이터 추가 !!!");
				arr.add(cBean);
			}
			
		} 
		catch (Exception e) {
			System.out.println("commentListCheck Method Error : " + e);
		}
 	 	finally{ 
 	 		resourceFree(); 
 	 	}
		return arr;
	}
	public int commentSizeCheck(int boardNum){
		int result = 0;
		try {
			SQL = "select count(*) from comment where num = ? ";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardNum);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
		} 
		catch (Exception e) {
			System.out.println("commentSizeCheck Method Error : " + e);
		}
		finally {
			resourceFree();
		}
		return result;
	}
	public int commentOwnCheck(String loginEmail ,int originNum ,int reg_seq){
		int result = 0;
		try{
			SQL = "select * from comment where email = ? and num = ? and reg_seq = ? " ;
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, loginEmail);
			pstmt.setInt(2, originNum);
			pstmt.setInt(3, reg_seq);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				result++;
			}
			
		}
		catch (Exception e){
			System.out.println("commentOwnCheck Method Error : " + e);
//			e.printStackTrace();
		}
		finally{
			resourceFree();
		}
		System.out.println(reg_seq);
		return result;
	}
//	DELETE FROM 테이블명 [WHERE 조건];
	public int commentDel(int originNum , int reg_seq){
		int result = 0;
		try{
			SQL = "delete from comment where num = ? and reg_seq = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, originNum);
			pstmt.setInt(2, reg_seq);
			
			result = pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("commentDel Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	
	
	
	
	
	
	
	
}
