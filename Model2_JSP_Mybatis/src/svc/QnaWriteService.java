package svc;

import dao.QnaDAO;
import dao.getQnaDAO;
import vo.QnaBean;

public class QnaWriteService {
	public int QnaWrite(QnaBean bean){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.qnaWrite(bean);
	}
}
