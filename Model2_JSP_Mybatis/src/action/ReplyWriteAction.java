package action;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.ReplyWriteService;
import vo.ActionForward;
import vo.QnaReplyBean;

public class ReplyWriteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		ActionForward forward = new ActionForward();
		ReplyWriteService svc = new ReplyWriteService();
		String contextPath = request.getContextPath();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

		String writer = (String) session.getAttribute("nickname");
		String content = request.getParameter("replyTextArea");
		String writedate = dateFormatter.format(new java.util.Date());
		int parentnum = Integer.parseInt(request.getParameter("idx"));
		
		QnaReplyBean bean = new QnaReplyBean(0,writer,content,writedate,parentnum);
		
		int result = svc.ReplyWrite(bean);
		if(result == 1){
			forward.setRedirect(true);
			forward.setPath(contextPath + "/adminQnaSearch.bo");
		}
		
		return forward;
	}
}
