package svc;

import dao.MemberDAO;
import dao.getMemberDAO;

public class MemberTmpPasswordUpdateService {
	public int MemberTmpPasswordUpdate(String email,String tmpPassword){
		MemberDAO memberDAO = new getMemberDAO().getInstance();
		return memberDAO.memberPasswordUpdate(email,tmpPassword);
	}
}
