package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberTmpPasswordMailSendService;
import svc.MemberTmpPasswordUpdateService;
import vo.ActionForward;

public class MemberTmpPasswordAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		String email = request.getParameter("email");
		
		MemberTmpPasswordMailSendService mailSvc = new MemberTmpPasswordMailSendService();
		MemberTmpPasswordUpdateService updateSvc = new MemberTmpPasswordUpdateService(); 
		
		String tmpPassword = mailSvc.MailSending(email);
		int result = updateSvc.MemberTmpPasswordUpdate(email, tmpPassword);
		
		if(result == 1){
			request.setAttribute("msg", "임시 비밀번호 발송 완료");
		}
		else{
			request.setAttribute("msg", "임시 비밀번호 발급 중 오류 발생 \n 재시도하여 주세요");
		}
		
		forward.setPath("./view/member/memberLoginForm.jsp");
		
		return forward;
	}
}
