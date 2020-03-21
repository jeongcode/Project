package svc;

import dao.QnaDAO;
import dao.getQnaDAO;
import vo.QnaReplyBean;

public class ReplyWriteService {
	public int ReplyWrite(QnaReplyBean bean){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.replyWrite(bean);
	}
}
