package svc;

import java.util.List;

import dao.PaymentDAO;
import dao.getPaymentDAO;
import vo.PaymentBean;

public class PaymentAllSelectService {
	public List<PaymentBean> PaymentAllSelect(){
		PaymentDAO paymentDAO = new getPaymentDAO().getInstance();
		return paymentDAO.paymentAllSelect();
	}
}
