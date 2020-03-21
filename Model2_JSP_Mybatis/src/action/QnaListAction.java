package action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.QnaListService;
import vo.ActionForward;
import vo.QnaBean;

public class QnaListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		QnaListService svc = new QnaListService();

		List<QnaBean> qnaList = null;
		String nickname = (String) session.getAttribute("nickname");
		if(nickname.equals("관리자")){
			qnaList = svc.QnaList();
			forward.setPath("./view/admin/qnaSearch.jsp");
		}
		else{
			qnaList = svc.QnaList(nickname);
			forward.setPath("./view/qna/qnaSearch.jsp");
		}
		
		request.setAttribute("qnaList", qnaList);
		

		return forward;
	}
}
