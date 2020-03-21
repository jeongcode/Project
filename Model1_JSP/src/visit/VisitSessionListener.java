package visit;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class VisitSessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent sessionEve) {
		HttpSession session = sessionEve.getSession();
		String email = sessionEve.getSession().getId();
		System.out.println("------------------" + email);
		if(sessionEve.getSession().isNew() && email != null){
			execute(sessionEve);
		}
	}
	public void execute(HttpSessionEvent sessionEve){
		VisitDAO vDao = new VisitDAO();
		try{
		//	Timestamp date = new Timestamp(System.currentTimeMillis());
			SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-DD");
			String date = formatter.format(new java.util.Date());
			vDao.setTotalCount(date);
		}
		catch (Exception e){
			System.out.println("VisitSessionListener execute() Method Error : " + e);
		}
	}
	
	
	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {}
	
}
