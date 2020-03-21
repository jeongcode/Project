package svc;

import dao.QnaDAO;
import dao.getQnaDAO;
import vo.QnaBean;

public class QnaRewriteService {
	public int QnaRewrite(QnaBean bean){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.qnaRewrite(bean);
	}
}
