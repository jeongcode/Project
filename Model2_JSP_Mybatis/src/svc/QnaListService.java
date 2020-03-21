package svc;

import java.util.List;

import dao.QnaDAO;
import dao.getQnaDAO;
import vo.QnaBean;

public class QnaListService {
	public List<QnaBean> QnaList(String nickname){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.qnaList(nickname);
	}
	public List<QnaBean> QnaList(){
		QnaDAO qnaDAO = new getQnaDAO().getInstance();
		return qnaDAO.qnaList();
	}
}
