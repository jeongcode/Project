package svc;

import dao.MemberDAO;
import dao.getMemberDAO;
import vo.MemberBean;

public class MemberJoinService {
	
	public int MemberJoin(MemberBean memberBean){
		MemberDAO memberDAO = new getMemberDAO().getInstance();
		
		return memberDAO.memberJoin(memberBean);
	}
}
