package action;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.QnaWriteService;
import vo.ActionForward;
import vo.QnaBean;

public class QnaWriteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		ActionForward forward = new ActionForward();
		QnaWriteService svc = new QnaWriteService();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
		
		String nickname = (String) session.getAttribute("nickname");
		String email = (String) session.getAttribute("email");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String writedate = dateFormatter.format(new java.util.Date());
		
		QnaBean bean = new QnaBean(nickname , email , title , content , writedate , 0 , 0);
		System.out.println(bean.toString());
		int result = svc.QnaWrite(bean);;
		if(result == 1){
			request.setAttribute("msg", "글 작성 완료");
			forward.setPath("./view/main/index.jsp");
		}
		return forward;
	}
}
