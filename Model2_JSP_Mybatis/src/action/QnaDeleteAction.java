package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.QnaDeleteService;
import vo.ActionForward;

public class QnaDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		QnaDeleteService svc = new QnaDeleteService();
	
		String contextPath = request.getContextPath();
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		int result = svc.QnaDelete(idx);
		if(result == 1){
			forward.setPath("./view/main/index.jsp");
			request.setAttribute("msg", "문의내역 삭제 완료");
		}
		return forward;
	}
}
