package action;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.PaymentInsertService;
import vo.ActionForward;
import vo.PaymentBean;

public class PaymentInsertAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PaymentInsertService svc = new PaymentInsertService();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
		HttpSession session = request.getSession();
		
		String nickname = (String) session.getAttribute("nickname");
		String email 	= (String) session.getAttribute("email");
		
		String oneway_airlinenm 			= request.getParameter("airlineNm_1");
		String oneway_depairportnm 			= request.getParameter("depAirportNm_1");
		String oneway_arrairportnm			= request.getParameter("arrAirportNm_1");
		String oneway_depdatetime			= request.getParameter("depDateTime_1");
		int    oneway_charge				= Integer.parseInt(request.getParameter("economyCharge_1"));
		
		String roundtrip_airlinenm 			= request.getParameter("airlineNm_2");
		String roundtrip_depairportnm 		= request.getParameter("depAirportNm_2");
		String roundtrip_arrairportnm		= request.getParameter("arrAirportNm_2");
		String roundtrip_arrdatetime		= request.getParameter("depDateTime_2");
		String roundtrip_charge_str			= request.getParameter("economyCharge_2");
		
		String paymentdate = dateFormatter.format(new java.util.Date());
		int readcheck = 0;
		
		
		int result = 0;
		if(roundtrip_airlinenm != null || roundtrip_depairportnm != null || roundtrip_arrairportnm != null || roundtrip_arrdatetime != null || roundtrip_charge_str != null){
			String tripkind = "round_trip";
			int roundtrip_charge = Integer.parseInt(roundtrip_charge_str);
			int totalCharge = oneway_charge + roundtrip_charge;
			double paymentPoint = totalCharge * 0.05;
			PaymentBean bean = new PaymentBean(nickname ,email ,tripkind ,oneway_airlinenm, 
											   oneway_depairportnm ,oneway_arrairportnm ,oneway_depdatetime,
											   oneway_charge ,roundtrip_airlinenm ,roundtrip_depairportnm ,roundtrip_arrairportnm,
											   roundtrip_arrdatetime , roundtrip_charge , totalCharge , paymentdate , paymentPoint , readcheck);
			result = svc.PaymentInsert(bean);
			System.out.println("왕복 결제 실행 완료");
		}
		else{
			String tripkind = "one_way";
			int totalCharge = oneway_charge;
			double paymentPoint = totalCharge * 0.05;

			PaymentBean bean = new PaymentBean(nickname ,email ,tripkind ,oneway_airlinenm, 
					   oneway_depairportnm ,oneway_arrairportnm ,oneway_depdatetime,
					   oneway_charge, totalCharge , paymentdate , paymentPoint , readcheck);
			
			result = svc.PaymentInsert(bean);
			System.out.println("편도 결제 실행 완료");
		}
		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();
		return null;
	}
}
