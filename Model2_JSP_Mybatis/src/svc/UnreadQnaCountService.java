package svc;

import dao.QnaDAO;
import dao.getQnaDAO;

public class UnreadQnaCountService {
	public int UnreadQnaCount(String email){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.unreadQnaCount(email);
	}
}
