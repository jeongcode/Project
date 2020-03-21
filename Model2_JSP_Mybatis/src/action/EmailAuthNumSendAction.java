package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberJoinMailSendService;
import vo.ActionForward;

public class EmailAuthNumSendAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");;

		String email = request.getParameter("email");
		System.out.println(email);
		MemberJoinMailSendService relatedMemberService = new MemberJoinMailSendService();
		
		String adminAuthNum = relatedMemberService.MailSending(email);
		
		response.getWriter().write(adminAuthNum);
		response.getWriter().flush();
		response.getWriter().close();
		
		return null;
	}

}
