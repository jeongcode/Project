package dao;

import java.io.Reader;
import java.io.WriteAbortedException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import vo.QnaBean;
import vo.QnaReplyBean;

public class QnaDAO {
	private static SqlSessionFactory sqlMapper = null;
	
	public static SqlSessionFactory getInstance(){
		if(sqlMapper == null){
			try{
				String resource = "mybatis/SqlMapConfig.xml";
				Reader reader = Resources.getResourceAsReader(resource);
				sqlMapper = new SqlSessionFactoryBuilder().build(reader);	
				reader.close();
			}
			catch(Exception e){
				System.out.println("QnaDAO geInstance Method Error : " + e);
			}
		}
		return sqlMapper;
	}
	public int qnaWrite(QnaBean bean) {
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		int result = session.insert("mapper.qna.insertQna",bean);
		if(result == 1){
			session.commit();
		}
		session.close();
		return result;
	}
	
	public List<QnaBean> qnaList(String nickname){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		Map<String,String> param = new HashMap<>();
		param.put("nickname", nickname);
		List<QnaBean> list = session.selectList("mapper.qna.selectQnaList", param);
		session.close();
		return list;
	}
	
	public List<QnaBean> qnaList(){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		List<QnaBean> list = session.selectList("mapper.qna.selectQnaList");
		session.close();
		return list;
	}
	
	public QnaBean qnaInfo(int idx , String nickname){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		
		QnaBean bean = session.selectOne("mapper.qna.selectQna",idx);
		
		if(!nickname.equals("관리자")){
			session.update("mapper.qna.updateQnaReadcheck",idx);
			session.commit();
		}
		session.close();
		return bean;
	}
	
	public int qnaDelete(int idx){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		int qnaDelResult = 0;
		
		int replyDelResult = session.delete("mapper.qna.deleteReply", idx);
		
		if(replyDelResult == 1){
			qnaDelResult = session.delete("mapper.qna.deleteQna", idx);
		}
		
		if(qnaDelResult == 1){
			session.commit();
		}
		session.close();
		return qnaDelResult;
	}
	public int qnaRewrite(QnaBean bean){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		
		int result = session.update("mapper.qna.updateQna", bean);
		if(result == 1){
			session.commit();
		}
		session.close();
		return result;
	}
	public QnaReplyBean replyInfo(int idx){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		QnaReplyBean bean = session.selectOne("mapper.qna.selectReply",idx);
		session.close();
		return bean;
	}
	public int replyWrite(QnaReplyBean bean){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		int writeResult = 0;
		int adminChkResult = session.update("mapper.qna.updateQnaAdminCheckUp", bean);
		if(adminChkResult == 1){
			writeResult = session.insert("mapper.qna.insertReply", bean);
		}
		if(adminChkResult == 1 && writeResult == 1){
			session.commit();
		}
		session.close();
		return writeResult;
	}
	public int replyDelete(int idx){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		int replyDelResult = 0;
		
		int qnaAdminChkResult = session.update("mapper.qna.updateQnaAdminCheckDown",idx);
		if(qnaAdminChkResult == 1){
			replyDelResult = session.delete("mapper.qna.deleteReply",idx);
		}
		if(replyDelResult == 1 && qnaAdminChkResult == 1){
			session.commit();
		}
		session.close();
		return replyDelResult;
	}
	public int unreadQnaCount(String email){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		
		return session.selectOne("mapper.qna.unreadQnaCount",email);
	}
	public List<QnaBean> unreadQnaSelect(String email){
		List<QnaBean> list = null;
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		
		list = session.selectList("mapper.qna.unreadQnaSelect",email);
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
