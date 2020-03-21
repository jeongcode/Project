package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberPasswordUpdateService;
import vo.ActionForward;

public class MemberPasswordUpdateAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		String password = request.getParameter("password1");
		
		MemberPasswordUpdateService svc = new MemberPasswordUpdateService();
		int result = svc.MemberPasswordUpdate(email, password);
		if(result == 1){
			request.setAttribute("msg", "비밀번호 변경 완료");
		}
		else{
			request.setAttribute("msg", "비밀번호 변경 실패 \n 재시도 하여 주세요");
		}
		forward.setPath("./view/main/index.jsp");
		
		return forward;
	}
}
