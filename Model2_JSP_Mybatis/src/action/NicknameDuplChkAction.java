package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.EmailOrNameDuplChkService;
import svc.MemberJoinMailSendService;
import vo.ActionForward;

public class NicknameDuplChkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");

		EmailOrNameDuplChkService svc = new EmailOrNameDuplChkService();
		
		String nickname = request.getParameter("nickname");
		
		int result = svc.NicknameDuplChk(nickname);
		
		response.getWriter().write(result + "");
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}

}
