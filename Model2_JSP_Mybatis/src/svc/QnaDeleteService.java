package svc;

import dao.QnaDAO;
import dao.getQnaDAO;

public class QnaDeleteService {
	public int QnaDelete(int idx){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.qnaDelete(idx);
	}
}
