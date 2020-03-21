package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.EmailOrNameDuplChkService;
import vo.ActionForward;

public class EmailDuplChkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");

		String email = request.getParameter("email");
		EmailOrNameDuplChkService svc = new EmailOrNameDuplChkService();
		
		int result = svc.EmailDuplChk(email);

		response.getWriter().write(result + "");
		response.getWriter().flush();
		response.getWriter().close();
		
		return null;
	}

}
