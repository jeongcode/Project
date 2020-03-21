package svc;

import dao.MemberDAO;
import dao.getMemberDAO;

public class MemberPasswordUpdateService {
	public int MemberPasswordUpdate(String email , String password){
		MemberDAO memberDAO = new getMemberDAO().getInstance();
		return memberDAO.memberPasswordUpdate(email , password);
	}
}
