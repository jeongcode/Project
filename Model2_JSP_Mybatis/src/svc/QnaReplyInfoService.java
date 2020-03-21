package svc;

import dao.QnaDAO;
import dao.getQnaDAO;
import vo.QnaReplyBean;

public class QnaReplyInfoService {
	public QnaReplyBean QnaReplyInfo(int idx){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.replyInfo(idx);
	}
}
