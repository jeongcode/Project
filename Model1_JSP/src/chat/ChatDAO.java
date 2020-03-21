package chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class ChatDAO {
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
		
		} catch (ClassNotFoundException e) {
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
	public int chatSetRead(String fromID, String toID){
		int check = 0;
		int result = 0;
		try{
			SQL = "update chat set chatread = 1 where fromID =  ? and toID = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toID);
			pstmt.setString(2, fromID);
			check = pstmt.executeUpdate();
			if(check > 0){
				result = 10;
			}
		}
		catch (Exception e){
			System.out.println("chatSetRead Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	// 채팅 리스트를 가져올 때 fromID에 해당하는 read열을 모두 1로 세팅 (읽음 처리)
	public ArrayList<ChatBean> getChatListByID(int num , String fromID , String toID){
		ArrayList<ChatBean> arr = new ArrayList<ChatBean>();
		try{
			SQL = "select * from chat where ((fromID = ? and toID = ?) or (toID = ? and fromID = ?)) and num > ? order by time";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, fromID);
			pstmt.setString(4, toID);
			pstmt.setInt(5, num);
			rs = pstmt.executeQuery();
				while(rs.next()){
					ChatBean cBean = new ChatBean();
					cBean.setNum(rs.getInt("num"));
					cBean.setFromID(rs.getString("fromID").replaceAll(" " , "&nbsp;").replaceAll("<" , "&lt;").replaceAll(">" , "&gt;").replaceAll("\n" , "<br>"));
					cBean.setToID(rs.getString("toID").replaceAll(" " , "&nbsp;").replaceAll("<" , "&lt;").replaceAll(">" , "&gt;").replaceAll("\n" , "<br>"));
					cBean.setContent(rs.getString("content").replaceAll(" " , "&nbsp;").replaceAll("<" , "&lt;").replaceAll(">" , "&gt;").replaceAll("\n" , "<br>"));
					int time = Integer.parseInt(rs.getString("time").substring(11,13));
					String timeType = "오전";
					if(time > 12){
						timeType = "오후";
						time -= 12;
					}
					//2020-01-09 17:36:10
					cBean.setTime(rs.getString("time").substring(0,11) + " "  + timeType + " " + time + ":" + rs.getString("time").substring(14,16) + " " );
					arr.add(cBean);
				}
		}
		catch (Exception e){
			System.out.println("getChatListByID Method Error : " + e);
			e.printStackTrace();
		}
		finally{
			resourceFree();
		}
		return arr;
	}
	public ArrayList<ChatBean> getChatListByRecent(int num , String fromID , String toID){
		ArrayList<ChatBean> arr = new ArrayList<ChatBean>();
		try{
			SQL = "select * from chat where ((fromID = ? and toID = ?) or (toID = ? and fromID = ?)) and num > (select max(num) - ? from chat ) order by time";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, num);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ChatBean cBean = new ChatBean();
				cBean.setNum(rs.getInt("num"));
				cBean.setFromID(rs.getString("fromID").replaceAll(" " , "&nbsp;").replaceAll("<" , "&lt;").replaceAll(">" , "&gt;").replaceAll("\n" , "<br>"));
				cBean.setToID(rs.getString("toID").replaceAll(" " , "&nbsp;").replaceAll("<" , "&lt;").replaceAll(">" , "&gt;").replaceAll("\n" , "<br>"));
				cBean.setContent(rs.getString("content").replaceAll(" " , "&nbsp;").replaceAll("<" , "&lt;").replaceAll(">" , "&gt;").replaceAll("\n" , "<br>"));
				int time = Integer.parseInt(rs.getString("time").substring(11,13));
				String timeType = "오전";
				if(time > 12){
					timeType = "오후";
					time -= 12;
				}
				cBean.setTime(rs.getString("chatTime").substring(0,11) + " "  + timeType + " " + rs.getString("time").substring(14,16) + " " );
				arr.add(cBean);
			}
		}
		catch (Exception e){
			System.out.println("getChatListByID Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return arr;
	}
	
	// 채팅 전송 시 read 컬럼은 0으로 세팅
	// 읽었을 시 1로 업데이트
	public int chatSubmit(String content , String fromID , String toID){
		int result = 0;
		try{
			SQL = "insert into chat values(null,?,?,?,NOW(),?) ";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, content);
			pstmt.setInt(4, 0);
			
			result =  pstmt.executeUpdate();
		}
		catch (Exception e){
			System.out.println("getChatListByID Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	public int chatSizeCheck(String email , String otherEmail){
		int result = 0;
		try{
			SQL = "select count(*) from chat where ((fromID = ? and toID = ?) or (fromID = ? and toID = ?))";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			pstmt.setString(2, otherEmail);
			pstmt.setString(3, otherEmail);
			pstmt.setString(4, email);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getInt(1) != 0) {
					result = rs.getInt(1);
				}
			}
		}
		catch (Exception e){
			System.out.println("chatSizeCheck Method Error : " + e);
			e.printStackTrace();
		}
		finally{
			resourceFree();
		}
		
		return result;
	}
	public int chatReadCheck(String toID){
		int result = 0;
		try{
			SQL = "select count(chatread) from chat where toID = ? and chatread = 0";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toID);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
			}
		}
		catch (Exception e){
			System.out.println("chatReadCheck Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	public int chatUserReadCheck(String toID , String fromID){
		int result = 0;
		try{
			SQL = "select * from chat where toID = ? and fromID = ? and  chatread = 0";
			conn = getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toID);
			pstmt.setString(2, fromID);
			rs = pstmt.executeQuery();
			while(rs.next()){
				result++;
			}
		}
		catch (Exception e){
			System.out.println("chatUserReadCheck Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
