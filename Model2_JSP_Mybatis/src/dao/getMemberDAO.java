package dao;

public class getMemberDAO {
	private MemberDAO memberDAO = null;
	
	public MemberDAO getInstance(){
		if(memberDAO == null){
			memberDAO = new MemberDAO();
		}
		return memberDAO;
	}
}
