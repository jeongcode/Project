package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.mysql.jdbc.ConnectionProperties;

public class MemberDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	String SQL = "";
	
	public MemberDAO(){
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
	
	public MemberBean loginChkMember(String email , String passwd){
		MemberBean bean = new MemberBean();
		SQL= "select * from member where email = ? and passwd = ? ";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				bean.setNickname(rs.getString("nickname"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
			}
		} 
		catch (Exception e) {
			System.out.println("loginChkMember Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return bean;
	}
	
	public int addMember(MemberBean bean){
		int check = 0;
		SQL = "insert into member (email,passwd,name,nickname,reg_date,postcode,roadaddress,jibunaddress,detailaddress,extraaddress,tel)"
				+ " values(?,?,?,?,?,?,?,?,?,?,?)";
				try {
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, bean.getEmail());
					pstmt.setString(2, bean.getPasswd());
					pstmt.setString(3, bean.getName());
					pstmt.setString(4, bean.getNickname());
					pstmt.setTimestamp(5, bean.getReg_date());
					pstmt.setString(6, bean.getPostcode());
					pstmt.setString(7, bean.getRoadAddress());
					pstmt.setString(8, bean.getJibunAddress());
					pstmt.setString(9, bean.getDetailAddress());
					pstmt.setString(10, bean.getExtraAddress());
					pstmt.setString(11, bean.getTel());
					
					pstmt.executeUpdate();
					
					check = 1;
					
				} 
				catch (Exception e) {
					System.out.println("addMember Method Error : " + e);
				} 
				finally{
					resourceFree();
				}
		return check;
	}
	public boolean mypagePassChk(MemberBean bean) {
		boolean result = false;
		SQL = "select * from member"
				+ " where email = ? and passwd = ?";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, bean.getEmail());
				pstmt.setString(2, bean.getPasswd());
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					result = true;
				}
			}
			catch (Exception e){
				System.out.println("mypagePassChk Method Error : " + e);
			}
			finally {
				resourceFree();
			}
			
		return result;
	}
	public MemberBean mypageMemberInfo(MemberBean bean) {
		SQL = "select * from member where email = ? and passwd = ?";
			try {
				System.out.println(conn.isClosed());
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, bean.getEmail());
				pstmt.setString(2, bean.getPasswd());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setEmail(rs.getString("email"));
					bean.setPasswd(rs.getString("passwd"));
					bean.setName(rs.getString("name"));
					bean.setNickname(rs.getString("nickname"));
					bean.setPostcode(rs.getString("postcode"));
					bean.setRoadAddress(rs.getString("roadaddress"));
					bean.setJibunAddress(rs.getString("jibunaddress"));
					bean.setDetailAddress(rs.getString("detailaddress"));
					bean.setExtraAddress(rs.getString("extraaddress"));
					bean.setTel(rs.getString("tel"));
				}
			}
			catch(Exception e) {
				System.out.println("mypageMemberInfo Method Error : " + e);
			}
			finally {
				resourceFree();
			}
		return bean;
	}
	public int mypageMemberDel(String useremail) {
		int result = 0;
			try {
				SQL = "delete from comment where email = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, useremail);
				pstmt.executeUpdate();
				SQL = "delete from reply where email = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, useremail);
				pstmt.executeUpdate();
				SQL = "delete from board where email = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, useremail);
				pstmt.executeUpdate();
				SQL = "delete from chat where fromID = ? or toID = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, useremail);
				pstmt.setString(2, useremail);
				pstmt.executeUpdate();
				SQL = "delete from gallery where email = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, useremail);
				pstmt.executeUpdate();
				SQL = "delete from member where email = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, useremail);
				result = pstmt.executeUpdate();
				
			} 
			catch (Exception e) {
				System.out.println("mypageMemberDel Method Error : " + e);
			}
			finally{
				resourceFree();
			}
		
		
		return result;
	}
	public int mypageMemberMod(MemberBean bean) {
		int result = 0;
			try {
				SQL = "select * from member where email = ? ";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, bean.getEmail());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					SQL = "update member set passwd = ? , name = ? , nickname = ? , postcode = ? , roadaddress = ? , jibunaddress = ? "
							+ ", detailaddress = ? , extraaddress = ? , tel = ? where email = ?";
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, bean.getPasswd());
					pstmt.setString(2, bean.getName());
					pstmt.setString(3, bean.getNickname());
					pstmt.setString(4, bean.getPostcode());
					pstmt.setString(5, bean.getRoadAddress());
					pstmt.setString(6, bean.getJibunAddress());
					pstmt.setString(7, bean.getDetailAddress());
					pstmt.setString(8, bean.getExtraAddress());
					pstmt.setString(9, bean.getTel());
					pstmt.setString(10,bean.getEmail());
					result = pstmt.executeUpdate();
					
				}
				else {
					return result;
				}
			}
			catch (Exception e) {
				System.out.println("mypageMemberMod Method Error : " + e);
			}
			finally {
				resourceFree();
			}
		
		return result;
	}
	public int emailDuplCheck(String email){
		int result = 0;
			try{
				SQL = "select email from member where email = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, email);
				rs = pstmt.executeQuery();
				if(rs.next()){
					result = 1;
				}
			}
			catch (Exception e){
				System.out.println("emailDuplCheck Method Error : " + e);
			}
			finally{
				resourceFree();
			}
		return result;
	}
	public ArrayList<MemberBean> memberCheck(String email){
		ArrayList<MemberBean> arr = new ArrayList<MemberBean>();
		try{
			SQL = "select email , name , nickname from member where email <> ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				MemberBean mBean = new MemberBean();
				mBean.setEmail(rs.getString("email"));
				mBean.setName(rs.getString("name"));
				mBean.setNickname(rs.getString("nickname"));
				arr.add(mBean);
			}
		}
		catch (Exception e){
			System.out.println("memberCheck Method Error : " + e);
		}
		finally{
			resourceFree();
		}
		return arr;
	}

	
	
	
	
	
	
	
	
	
}
