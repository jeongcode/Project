package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.QnaInfoService;
import svc.QnaReplyInfoService;
import vo.ActionForward;
import vo.QnaBean;
import vo.QnaReplyBean;

public class QnaInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		ActionForward forward = new ActionForward();
		QnaInfoService qnaSvc = new QnaInfoService();
		QnaReplyInfoService replySvc = new QnaReplyInfoService();
		
		String nickname = (String) session.getAttribute("nickname");
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		QnaBean qnaBean = qnaSvc.QnaInfo(idx , nickname);
		QnaReplyBean replyBean = replySvc.QnaReplyInfo(idx); 
		
		request.setAttribute("qnaBean", qnaBean);
		request.setAttribute("replyBean", replyBean);
		forward.setPath("./view/qna/qnaInfoForm.jsp");		
		
		return forward;
	}

}
