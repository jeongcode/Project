package action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AdminMemberSearchService;
import svc.MemberJoinMailSendService;
import vo.ActionForward;
import vo.MemberBean;

public class AdminMemberSearchAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		AdminMemberSearchService svc = new AdminMemberSearchService();
		
		List<MemberBean> memberList = svc.MemberSearchList();
		
		request.setAttribute("memberList", memberList);
		
		forward.setPath("./view/admin/memberSearch.jsp");
		
		return forward;
	}
}
