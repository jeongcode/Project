package svc;

import dao.PaymentDAO;
import dao.getPaymentDAO;

public class UnreadPaymentCountService {
	public int UnreadPaymentCount(String email){
		PaymentDAO paymentDAO = new getPaymentDAO().getInstance();
		return paymentDAO.unreadPaymentCount(email);
	}
}
