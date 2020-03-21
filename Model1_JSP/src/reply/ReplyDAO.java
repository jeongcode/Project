package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class ReplyDAO {
	private final String url = "jdbc:mysql://localhost:3306/project1";
	private final String id = "root";
	private final String pwd = "1234";
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	String SQL = "";
	
	public Connection getConnection(){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pwd);
		
		} catch (ClassNotFoundException e){
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	return conn;
	}
	public void resourceFree(){
		try {
			if(rs != null)	rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	}
	
	public int replyRegLevCheck(int originNum){
		int result = 0;
		try{
			SQL = "select max(reg_lev) from reply where num = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, originNum);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1) + 1;
			}
		}
		catch (Exception e){
			System.out.println("replyRevLevCheck Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	
	public int replyWrite(ReplyBean rBean, int originNum , int level){
		int result = 0 ;
		try{
			SQL = "insert into reply (num,email,nickname,passwd,subject,content,file,date,reg_lev,ip,readcount) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?) ";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, originNum);
			pstmt.setString(2, rBean.getEmail());
			pstmt.setString(3, rBean.getNickname());
			pstmt.setString(4, rBean.getPasswd());
			pstmt.setString(5, rBean.getSubject());
			pstmt.setString(6, rBean.getContent());
			pstmt.setString(7, "0");
			pstmt.setTimestamp(8, rBean.getDate());
			pstmt.setInt(9, level);
			pstmt.setString(10, rBean.getIp());
			pstmt.setInt(11, 0);
			result = pstmt.executeUpdate();
			
		}
		catch (Exception e){
			System.out.println("replyWrite Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
//	UPDATE 테이블명 SET 컬럼1 = 수정값1 [, 컬럼2 = 수정값2 ...] [WHERE 조건];
	public int replyIncreaseReadcount(int num , int lev){
		int result = 0 ;
		try{
			SQL = "update reply set readcount = readcount + 1 where num = ? and reg_lev = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setInt(2, lev);
			
			result = pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("replyIncreaseReadcount Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		
		return result;
	}
	public ReplyBean replyInto(int num, int lev){
		ReplyBean rBean = new ReplyBean();
		try{
			SQL = "select * from reply where num = ? and reg_lev = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setInt(2, lev);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				rBean.setNum(rs.getInt("num"));
				rBean.setEmail(rs.getString("email"));
				rBean.setPasswd(rs.getString("passwd"));
				rBean.setNickname(rs.getString("nickname"));
				rBean.setSubject(rs.getString("subject"));
				rBean.setContent(rs.getString("content"));
				rBean.setReg_lev(rs.getInt("reg_lev"));
			}
		}
		catch (Exception e){
			System.out.println("replyInto Method Error : " + e);
		}
		finally {
			resourceFree();
		}
		return rBean;
	}
//	DELETE FROM 테이블명 [WHERE 조건];
	public int replyDel(int num , int lev){
		int check = 0 ;
		int result = 0 ;
		try{
			SQL = "delete from reply where num = ? and reg_lev = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.setInt(2, lev);
			
			check = pstmt.executeUpdate();
			if(check == 1){
				result = check;
			}
			else{
				return result;
			}
		}
		catch (Exception e){
			System.out.println("replyDel Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		System.out.println("replyDel check : " + check + " result : " + result);
		return result;
	}
//	UPDATE 테이블명 SET 컬럼1 = 수정값1 [, 컬럼2 = 수정값2 ...] [WHERE 조건];
	public int replyReWrite(int num,int lev, ReplyBean rBean){
		int result = 0;
		try{
			SQL = "update reply set passwd = ? , subject = ? , content = ? where num = ? and reg_lev = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,rBean.getPasswd());
			pstmt.setString(2,rBean.getSubject());
			pstmt.setString(3,rBean.getContent());
			pstmt.setInt(4,num);
			pstmt.setInt(5, lev);
			
			result = pstmt.executeUpdate();
						
		}
		catch (Exception e){
			System.out.println("replyReWrite Method Error : " + e);
		}
		finally {
			resourceFree();
		}
 		return result;
	}
	
	
	
	
	
	
	
	
}
