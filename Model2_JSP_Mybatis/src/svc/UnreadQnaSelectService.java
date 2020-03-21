package svc;

import java.util.List;

import dao.QnaDAO;
import dao.getQnaDAO;
import vo.QnaBean;

public class UnreadQnaSelectService {
	public List<QnaBean> UnreadQnaSelect(String email){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.unreadQnaSelect(email);
	}
}
