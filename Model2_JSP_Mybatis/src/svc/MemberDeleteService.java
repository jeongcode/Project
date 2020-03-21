package svc;


import dao.MemberDAO;
import dao.getMemberDAO;

public class MemberDeleteService {
	
	public int memberDel(String nickname){
		MemberDAO memberDAO = new getMemberDAO().getInstance();
		return memberDAO.memberDel(nickname);
	}
}
