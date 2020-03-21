package dao;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import vo.PaymentBean;

public class PaymentDAO {
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
				System.out.println("PaymentDAO geInstance Method Error : " + e);
			}
		}
		return sqlMapper;
	}
	public int paymentInsert(PaymentBean bean){
		int insertResult = 0;
		int pointUpdateResult = 0;
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		insertResult = session.insert("mapper.payment.insertPayment",bean);
		if(insertResult == 1){
			pointUpdateResult = session.insert("mapper.payment.updateMemberPoint",bean);
			if(pointUpdateResult == 1){
				session.commit();
			}
		}
		session.close();
		return insertResult;
	}
	public List<PaymentBean> paymentSelect(String email) {
		List<PaymentBean> list = null;
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		Map<String,String> param = new HashMap<>();
		param.put("email", email);
		
		list = session.selectList("mapper.payment.selectPayment",param);
		
		if(list.size() > 0){
			session.update("mapper.payment.updatePaymentReadcheck" , param);
			session.commit();
		}
		
		session.close();
		return list;
	}
	public List<PaymentBean> paymentAllSelect(){
		List<PaymentBean> list = null;
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		
		list = session.selectList("mapper.payment.selectPayment");
		session.close();
		return list;
	}
	public int unreadPaymentCount(String email){
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		
		return session.selectOne("mapper.payment.unreadPaymentCount",email);
	}
	public List<PaymentBean> unreadPaymentSelect(String email){
		List<PaymentBean> list = null;
		sqlMapper = getInstance();
		SqlSession session = sqlMapper.openSession();
		
		list = session.selectList("mapper.payment.unreadPaymentSelect",email);
		session.close();
		return list;
	}
}

