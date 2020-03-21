package svc;

import java.util.List;

import dao.MemberDAO;
import dao.getMemberDAO;
import vo.MemberBean;

public class AdminMemberSearchService {
	public List<MemberBean> MemberSearchList(){
		MemberDAO memberDAO = new getMemberDAO().getInstance();
		return memberDAO.memberAllSearch();
	}
}
