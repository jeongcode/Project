package svc;

import java.util.List;

import dao.PaymentDAO;
import dao.getPaymentDAO;
import vo.PaymentBean;

public class UnreadPaymentSelectService {
	public List<PaymentBean> UnreadPaymentSelect(String email){
		PaymentDAO paymentDAO = new getPaymentDAO().getInstance();
		return paymentDAO.unreadPaymentSelect(email);
	}
}
