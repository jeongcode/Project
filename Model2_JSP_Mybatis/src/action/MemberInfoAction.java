package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberInfoService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberInfoAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		ActionForward forward = new ActionForward();
		
		String nickname = (String) session.getAttribute("nickname");
		
		MemberInfoService svc = new MemberInfoService();
		MemberBean memberBean = svc.MemberInfo(nickname);
		request.setAttribute("memberBean", memberBean);
		
		forward.setPath("./view/member/memberInfoForm.jsp");
		
		return forward;
	}
}
