package action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.PaymentSelectService;
import vo.ActionForward;
import vo.PaymentBean;

public class PaymentSelectAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		PaymentSelectService svc = new PaymentSelectService();
		HttpSession session = request.getSession();
		
		String email = (String) session.getAttribute("email");
		
		List<PaymentBean> list = svc.PaymentSelect(email);
		int listSize = list.size();
		
		request.setAttribute("paymentList", list);
		request.setAttribute("paymentListSize", listSize);
		
		
		forward.setPath("./view/payment/paymentSearch.jsp");
		
		return forward;
	}
}
