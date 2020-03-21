package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.MemberDeleteService;
import vo.ActionForward;

public class MemberDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		ActionForward forward = new ActionForward();
		MemberDeleteService svc = new MemberDeleteService();
		
		
		String nickname = (String) session.getAttribute("nickname");
		int result = svc.memberDel(nickname);
		if(result == 1){
			session.invalidate();
		}
		forward.setPath("./view/main/index.jsp");
		return forward;
	}
}
