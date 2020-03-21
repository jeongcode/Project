package svc;

import java.util.List;

import dao.PaymentDAO;
import dao.getPaymentDAO;
import vo.PaymentBean;

public class PaymentSelectService {
	public List<PaymentBean> PaymentSelect(String email){
		PaymentDAO paymentDAO = new getPaymentDAO().getInstance();
		return paymentDAO.paymentSelect(email);
	}
}
