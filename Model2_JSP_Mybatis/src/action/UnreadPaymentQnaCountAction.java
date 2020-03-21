package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.UnreadPaymentCountService;
import svc.UnreadQnaCountService;
import vo.ActionForward;

public class UnreadPaymentQnaCountAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		String email = request.getParameter("email");
		
		UnreadPaymentCountService paymentSvc = new UnreadPaymentCountService();
		UnreadQnaCountService qnaSvc = new UnreadQnaCountService();
		
		int paymentResult = paymentSvc.UnreadPaymentCount(email);
		int qnaResult = qnaSvc.UnreadQnaCount(email);
		
		int result = paymentResult + qnaResult;
		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();
		
		return null;
	}
}
