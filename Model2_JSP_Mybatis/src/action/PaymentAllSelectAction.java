package action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.PaymentAllSelectService;
import vo.ActionForward;
import vo.PaymentBean;

public class PaymentAllSelectAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		PaymentAllSelectService svc = new PaymentAllSelectService();
		List<PaymentBean> paymentList = svc.PaymentAllSelect();
		int paymentListSize = paymentList.size();
		
		request.setAttribute("paymentList", paymentList);
		request.setAttribute("paymentListSize", paymentListSize);
		
		forward.setPath("./view/admin/paymentSearch.jsp");
		
		return forward;
	}
}
