package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import member.DBConnection;

public class BoardDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	String SQL = "";
	
	public BoardDAO() {
		DBConnection DBC = new DBConnection();
		conn = DBC.getConnection();
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
	
	public int boardWrite(BoardBean bean) {
		int result = 0;
		try {
			SQL = "insert into board (email, nickname, passwd, subject ,content, file, readcount, date ,ip)  "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bean.getEmail());
			pstmt.setString(2, bean.getNickname());
			pstmt.setString(3, bean.getPasswd());
			pstmt.setString(4, bean.getSubject());
			pstmt.setString(5, bean.getContent());
			pstmt.setString(6, bean.getFile());
			pstmt.setInt(7, 0);
			pstmt.setTimestamp(8, bean.getDate());
			pstmt.setString(9, bean.getIp());
			
			result = pstmt.executeUpdate();
		} 
		catch (Exception e) {
			System.out.println("boardWriter Method Error : " + e);
		} 
		finally {
			resourceFree();
		}
		return result;
	}
	public int boardSizeCheck() {
		int result = 0;
			try {
				SQL = "select (select count(*) from board ) + (select count(*) from reply) as total";
				pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			} 
			catch (Exception e) {
				System.out.println("boardSizeCheck Method Error : " + e);
				e.printStackTrace();
			}
/*			finally{
				resourceFree();
			}*/
		return result;
	}
	public ArrayList<BoardBean> boardListCheck(int currentPage, int size) {
		ArrayList<BoardBean> arr = new ArrayList<BoardBean>();
//		SQL = "select * from board order by num desc limit ?, ?";
				SQL = "select * from board " +
				"union all " +
				"select * from reply order by num desc limit ?,?";
		
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, currentPage);
				pstmt.setInt(2, size);
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					BoardBean bean = new BoardBean();
					bean.setNum(rs.getInt("num"));
					bean.setSubject(rs.getString("subject"));
					bean.setNickname(rs.getString("nickname"));
					bean.setDate(rs.getTimestamp("date"));
					bean.setReadcount(rs.getInt("readcount"));
					bean.setReg_lev(rs.getInt("reg_lev"));
					
					arr.add(bean);
				}
				
			} 
			catch (Exception e) {
				System.out.println("boardListCheck Method Error : " + e);
				e.printStackTrace();
			} 
			finally {
				resourceFree();
			}
		
		return arr;
	}
	public int boardIncreaseReadcount(int num) {
		int check = 0;
		int result = 0;
		try {
			System.out.println("conn.isCloesd ? " + conn.isClosed());
			SQL="update board set readcount = readcount + 1 where num = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			check = pstmt.executeUpdate();
			if(check == 1) {
				result = 1;
			}
		} 
		catch (Exception e) {
			System.out.println("boardIntoReadcount Method Error : " + e);
		}
		return result;
	}
	
	public BoardBean boardInto(int num){
		BoardBean bBean = new BoardBean();
		try {
			System.out.println("conn.isCloesd ? " + conn.isClosed());
			SQL="select * from board where num = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bBean.setNum(rs.getInt("num"));
				bBean.setEmail(rs.getString("email"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setNickname(rs.getString("nickname"));
				bBean.setSubject(rs.getString("subject"));
				bBean.setContent(rs.getString("content"));
			}
			
		} 
		catch (Exception e) {
			System.out.println("boardInto Method Error : " + e);
		} 
		finally{
			resourceFree();
		}
		
		return bBean;
	}
//	UPDATE 테이블명 SET 컬럼1 = 수정값1 [, 컬럼2 = 수정값2 ...] [WHERE 조건];
	public int boardReWrite(BoardBean bBean){
		int result = 0;
		try {
			SQL = "update board set email = ? , nickname = ? , passwd = ? , subject = ? ,"
					+ " content = ? , ip = ? , date = ? where num = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bBean.getEmail());
			pstmt.setString(2, bBean.getNickname());
			pstmt.setString(3, bBean.getPasswd());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			pstmt.setString(6, bBean.getIp());
			pstmt.setTimestamp(7, bBean.getDate());
			pstmt.setInt(8, bBean.getNum());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("boardReWrite Method Error : " + e);
		} 
		finally{
			resourceFree();
		}
		return result;
	}
//	DELETE FROM 테이블명 [WHERE 조건];
	public int boardDelete(int num){
		int result = 0;
		try {
			SQL="delete from comment where num = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			SQL="delete from reply where num = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			SQL="delete from board where num = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("boardDelete Method Error : " + e);
		} finally{
			resourceFree();
		}
		return result;
	}
	public int boardSearchSizeCheck(String selectVal , String searchVal){
		int result = 0;
		try{
			if("subject".equals(selectVal)){
				SQL = "select count(*) from board where subject like ?";
			}
			else{
				SQL = "select count(*) from board where nickname like ?";
			}
			pstmt = conn.prepareStatement(SQL);
			String realSearchVal = "%" + searchVal + "%";
	//		pstmt.setString(1, selectVal);
			pstmt.setString(1, realSearchVal);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = rs.getInt(1);
				System.out.println("boardSearchSizeCheck result = " + result);
			}
		}
		catch (Exception e){
			System.out.println("boardSearchSizeCheck Method Error : " + e);
			e.printStackTrace();
		}
/*		finally{
			resourceFree();
		}*/
		return result;
	}
	public ArrayList<BoardBean> boardSearch(String searchVal , String selectVal,int currentPage, int size){
		ArrayList<BoardBean> arr = new ArrayList<BoardBean>();
		try{
			if("subject".equals(selectVal)){
				SQL = "select * from board where subject like ? order by num desc limit ?,?";
			}
			else{
				SQL = "select * from board where nickname like ? order by num desc limit ?,?";
			}
			pstmt=conn.prepareStatement(SQL);
	//		pstmt.setString(1, selectVal);
			pstmt.setString(1, "%" +searchVal+ "%");
			pstmt.setInt(2, currentPage);
			pstmt.setInt(3, size);
			rs = pstmt.executeQuery();
			while(rs.next()){
				BoardBean bBean = new BoardBean();
				bBean.setNum(rs.getInt("num"));
				bBean.setSubject(rs.getString("subject"));
				bBean.setNickname(rs.getString("nickname"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setReg_lev(rs.getInt("reg_lev"));

				arr.add(bBean);
			}
		}
		catch(Exception e){
			System.out.println("boardSearch Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return arr;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
