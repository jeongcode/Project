package svc;

import dao.PaymentDAO;
import dao.getPaymentDAO;
import vo.PaymentBean;

public class PaymentInsertService {
	public int PaymentInsert(PaymentBean bean){
		PaymentDAO paymentDAO = new getPaymentDAO().getInstance();
		return paymentDAO.paymentInsert(bean);
	}
}
