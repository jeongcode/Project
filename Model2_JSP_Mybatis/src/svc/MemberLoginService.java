package svc;

import dao.MemberDAO;
import dao.getMemberDAO;
import vo.MemberBean;

public class MemberLoginService {
	
	public MemberBean MemberLogin(String email , String password) {
	
		MemberDAO memberDAO = new getMemberDAO().getInstance();
		return memberDAO.memberLogin(email , password);
	}
}
