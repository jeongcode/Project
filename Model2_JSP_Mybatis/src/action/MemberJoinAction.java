package action;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import svc.MemberJoinService;
import svc.MemberLoginService;
import svc.MemberJoinMailSendService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberJoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		
		ActionForward forward = new ActionForward();
		MemberJoinMailSendService memberService = new MemberJoinMailSendService();
		
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
		String joinDate = dateFormatter.format(new java.util.Date());
		
		MemberJoinService joinSvc = new MemberJoinService();
		MemberLoginService loginSvc = new MemberLoginService();

		MemberBean memberBean = new MemberBean(	request.getParameter("nickname"),
												request.getParameter("password"),
												request.getParameter("email"),
												request.getParameter("mobile"),
												joinDate,
												0);
		
		joinSvc.MemberJoin(memberBean);
		MemberBean loginResult = loginSvc.MemberLogin(request.getParameter("email") , request.getParameter("password"));
		if(loginResult != null && loginResult.getEmail() != null){
			request.setAttribute("msg", "회원가입 완료");
			HttpSession session = request.getSession();
			session.setAttribute("email", loginResult.getEmail());
			session.setAttribute("nickname", loginResult.getNickname());
		}
		
		forward.setPath("./view/main/index.jsp");
		
		return forward;
	}
}
