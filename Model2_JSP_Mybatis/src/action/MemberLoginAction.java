package action;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberLoginService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberLoginAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(60 * 60);
		
		ActionForward forward = new ActionForward();
		MemberLoginService svc = new MemberLoginService();
		MemberBean result = null;
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String rememberID = request.getParameter("rememberID");
		result = svc.MemberLogin(email, password);

		if(result == null){
			request.setAttribute("msg", "이메일과 비밀번호를 확인하세요");
			forward.setPath("./view/member/memberLoginForm.jsp");	
		}
		else{
			if(rememberID != null){
				Cookie c = new Cookie("userEmail" , email);
				c.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(c);
			}
			else{
				Cookie c = new Cookie("userEmail" , email);
				c.setMaxAge(0);
				response.addCookie(c);
			}
			session.setAttribute("email", result.getEmail());
			session.setAttribute("nickname", result.getNickname());
			forward.setPath("./view/main/index.jsp");
			forward.setRedirect(true);
		}
		return forward;
	}
}
