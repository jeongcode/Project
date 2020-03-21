package svc;

import dao.QnaDAO;
import dao.getQnaDAO;

public class ReplyDeleteService {
	public int ReplyDelete(int parentNum){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.replyDelete(parentNum);
	}
}
