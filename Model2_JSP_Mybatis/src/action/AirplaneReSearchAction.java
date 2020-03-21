package action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import svc.AirplaneSearchService;
import vo.ActionForward;

public class AirplaneReSearchAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String depAirport = request.getParameter("depAirportNm");
		String arrAirport = request.getParameter("arrAirportNm");
		String depPlandTime = request.getParameter("depPlandTime");
		
		AirplaneSearchService airplaneSearchService = new AirplaneSearchService();
		JSONArray airlineList = airplaneSearchService.airplaneReSearch(depAirport, arrAirport, depPlandTime);
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().print(airlineList);
		response.getWriter().flush();
		response.getWriter().close();
		
		return null;
	}

	
}
