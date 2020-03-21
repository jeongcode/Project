package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReplyDeleteService;
import vo.ActionForward;

public class ReplyDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		ReplyDeleteService svc = new ReplyDeleteService();
		String contextPath = request.getContextPath();
		
		int parentNum = Integer.parseInt(request.getParameter("idx"));
		
		int result = svc.ReplyDelete(parentNum);
		
		forward.setRedirect(true);
		forward.setPath(contextPath + "/adminQnaSearch.bo");
		
		return forward;
	}
}
