package dao;

public class getPaymentDAO {
	private PaymentDAO paymentDAO = null;
	
	public PaymentDAO getInstance(){
		if(paymentDAO == null){
			paymentDAO = new PaymentDAO();
		}
		return paymentDAO;
	}
}
