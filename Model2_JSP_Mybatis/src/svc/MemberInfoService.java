package svc;

import dao.MemberDAO;
import dao.getMemberDAO;
import vo.MemberBean;

public class MemberInfoService {
	public MemberBean MemberInfo (String nickname){
		MemberDAO memberDAO = new getMemberDAO().getInstance();
		return memberDAO.memberSearch(nickname);
	}
}
