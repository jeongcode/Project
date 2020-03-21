package svc;

import dao.QnaDAO;
import dao.getQnaDAO;
import vo.QnaBean;

public class QnaInfoService {
	public QnaBean QnaInfo(int idx , String nickname){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.qnaInfo(idx , nickname);
	}
}
