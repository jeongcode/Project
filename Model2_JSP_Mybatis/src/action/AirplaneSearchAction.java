package action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.AirplaneSearchService;
import vo.ActionForward;

public class AirplaneSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String depAirport = request.getParameter("depAirportNm");
		String arrAirport = request.getParameter("arrAirportNm");
		String beforeDepPlandTime = request.getParameter("depPlandTime");
		String beforeDep2PlandTime = request.getParameter("dep2PlandTime");
		String depPlandTime = beforeDepPlandTime.replace("/", "");
		ActionForward forward = new ActionForward();
		AirplaneSearchService airplaneSearchService = new AirplaneSearchService();
		
		Map<String,Object> totalMap = new HashMap<String,Object>();
		
		List<Map<String,Object>> airlineList = airplaneSearchService.airplaneSearch(depAirport, arrAirport, depPlandTime);
		List<Map<String,Object>> parkList = airplaneSearchService.airportParkCheck(depAirport);
		
		totalMap.put("dep", airlineList);
		totalMap.put("parkList", parkList);
		
		if(beforeDep2PlandTime != null){
			String dep2PlandTime = beforeDep2PlandTime.replace("/", "");
			List<Map<String,Object>> airlineList2 = airplaneSearchService.airplaneSearch(arrAirport, depAirport, dep2PlandTime);
			List<Map<String,Object>> parkList2 = airplaneSearchService.airportParkCheck(arrAirport);

			totalMap.put("dep2", airlineList2);
			totalMap.put("parkList2", parkList2);
		}
		request.setAttribute("airlineInfo", totalMap);
		forward.setPath("./view/airplane/airplaneList.jsp");
		
		return forward;
	}
}
