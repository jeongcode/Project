package action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.QnaListService;
import svc.UnreadPaymentSelectService;
import svc.UnreadQnaSelectService;
import vo.ActionForward;
import vo.PaymentBean;
import vo.QnaBean;

public class UnreadPaymentQnaSelectAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		
		String email = (String) session.getAttribute("email");
		
		UnreadPaymentSelectService paymentSvc = new UnreadPaymentSelectService();
		UnreadQnaSelectService qnaSvc = new UnreadQnaSelectService();
		
		List<PaymentBean> paymentList = paymentSvc.UnreadPaymentSelect(email);
		int paymentListSize = paymentList.size();
		List<QnaBean> qnaList = qnaSvc.UnreadQnaSelect(email);
		
		request.setAttribute("paymentList",paymentList);
		request.setAttribute("paymentListSize", paymentListSize);
		request.setAttribute("qnaList", qnaList);
		
		forward.setPath("./view/member/memberUnreadList.jsp");
		
		return forward;
	}
}
