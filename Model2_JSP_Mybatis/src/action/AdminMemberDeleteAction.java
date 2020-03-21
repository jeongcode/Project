package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberDeleteService;
import vo.ActionForward;

public class AdminMemberDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		MemberDeleteService svc = new MemberDeleteService();
		
		String nickname = request.getParameter("nickname");
		int result = svc.memberDel(nickname);
		
		response.getWriter().print(result + "");
		response.getWriter().flush();
		response.getWriter().close();
		
		
		return null;
	}
}
