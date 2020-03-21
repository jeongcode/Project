package dao;

public class getQnaDAO {
	private QnaDAO qnaDAO = null;
	
	public QnaDAO getInstance(){
		if(qnaDAO == null){
			qnaDAO = new QnaDAO();
		}
		return qnaDAO;
	}
}
