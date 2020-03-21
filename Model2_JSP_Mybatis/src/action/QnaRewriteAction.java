package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.QnaRewriteService;
import vo.ActionForward;
import vo.QnaBean;

public class QnaRewriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		
		QnaRewriteService svc = new QnaRewriteService();
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		QnaBean bean = new QnaBean();
		bean.setIdx(idx);
		bean.setTitle(title);
		bean.setContent(content);

		int result = svc.QnaRewrite(bean);
		
		response.getWriter().print(result);
		response.getWriter().flush();
		response.getWriter().close();
		
		return null;
	}
}
