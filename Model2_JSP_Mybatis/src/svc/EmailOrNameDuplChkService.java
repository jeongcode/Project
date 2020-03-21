package svc;

import dao.MemberDAO;
import dao.getMemberDAO;

public class EmailOrNameDuplChkService {

	public int NicknameDuplChk(String nickname){
		MemberDAO memberDAO = new getMemberDAO().getInstance();
		return memberDAO.nicknameDuplCheck(nickname);
	}
	public int EmailDuplChk(String email){
		MemberDAO memberDAO = new getMemberDAO().getInstance();
		return memberDAO.emailDuplCheck(email);
	}
}
