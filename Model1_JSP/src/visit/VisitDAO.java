package visit;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

public class VisitDAO {
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
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void setTotalCount(String date){
		try{
			SQL = "insert into visit (v_date) value(?)";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, date);
			
			pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("setTotalCount Method Error : " + e);
		}
		finally{
			resourceFree();
		}
	}
	public int getTotalVisit(){
		int result = 0;
		try{
			SQL = "select count(*) from visit";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
		}
		catch (Exception e){
			System.out.println("getTotalVisit Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		System.out.println("total visit : " + result);
		return result;
	}
	public int getTodayVisit(String date){
		int result = 0;
		try{
			SQL = "select count(*) from visit where v_date = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, date);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
		}
		catch (Exception e){
			System.out.println("getTodayVisit Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		System.out.println(date);
		System.out.println("today visit : " + result);
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
