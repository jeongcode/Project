package dao;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import vo.MemberBean;

public class MemberDAO {
	
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
				System.out.println("MemberDAO geInstance Method Error : " + e);
			}
		}
		return sqlMapper;
	}
	
	public int emailDuplCheck(String email){
		int result = 0;
		sqlMapper = getInstance();
		
		SqlSession session = sqlMapper.openSession();

		Map<String,Object> param = new HashMap<>();
		param.put("email", email);

		result = session.selectOne("mapper.member.selectDuplChkResult" , param);
		session.close();
		return result;
	}
	
	public int nicknameDuplCheck(String nickname){
		int result = 0;
		sqlMapper = getInstance();
		
		SqlSession session = sqlMapper.openSession();

		Map<String,Object> param = new HashMap<>();
		param.put("nickname", nickname);
	
		result = session.selectOne("mapper.member.selectDuplChkResult" , param);
		session.close();
		return result;
	}

	public int memberJoin(MemberBean memberBean) {
		int result = 0;
		sqlMapper = getInstance();

		SqlSession session = sqlMapper.openSession();
		
		result = session.insert("mapper.member.insertMember", memberBean);
		if(result == 1){
			session.commit();
		}
		session.close();
		return result;
	}

	public MemberBean memberLogin(String email, String password) {
		sqlMapper = getInstance();

		SqlSession session = sqlMapper.openSession();
		Map<String,Object> param = new HashMap<>();
		param.put("email", email);
		param.put("password", password);
		
		MemberBean loginResult = session.selectOne("mapper.member.selectLoginResult",param);
		session.close();
		return loginResult;
	}

	public List<MemberBean> memberAllSearch() {
		sqlMapper = getInstance();
		
		SqlSession session = sqlMapper.openSession();
		List<MemberBean> list = session.selectList("mapper.member.selectAllMember");
		session.close();
		return list;
	}
	
	public int memberDel(String nickname){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		Map<String,String> param = new HashMap<>();
		param.put("nickname", nickname);
		session.delete("mapper.qna.deleteQna_memberDel",nickname);
		session.delete("mapper.payment.deletePayment_memberDel",nickname);
		
		int result = session.delete("mapper.member.deleteMember", param);
		if(result == 1){
			session.commit();
		}
		session.close();
		return result; 
	}
	public MemberBean memberSearch(String nickname){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		Map<String,String> param = new HashMap<>();
		param.put("nickname", nickname);
		
		MemberBean bean = session.selectOne("mapper.member.selectMember",param);
		session.close();
		return bean;
	}
	public int memberPasswordUpdate(String email , String tmpPassword){
		int  result = 0 ;
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		Map<String,String> param = new HashMap<>();
		param.put("email", email);
		param.put("tmpPassword", tmpPassword);
		
		result = session.update("mapper.member.updateMemberPassword", param);
		if(result == 1){
			session.commit();
		}
		session.close();
		return result;
	}
}
