package svc;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;



public class MemberJoinMailSendService {
	
	public String MailSending(String useremail){
			String adminAuthNum = "";
			for(int i = 0 ; i < 6 ; i++){
				adminAuthNum += ((int)(Math.random() * 10) + 1);
			}
			InternetAddress to = null;
			Properties prop = new Properties();
			// TLS : Transport Layer Security
			prop.put("mail.smtp.host", "smtp.naver.com");
			prop.put("mail.smtp.port", "465");
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.ssl.enable", "true");
			
			Authenticator auth = new MailAuth();
			
			Session session = Session.getDefaultInstance(prop , auth);
			
			MimeMessage msg = new MimeMessage(session);
			try {
				msg.setSentDate(new Date());
				
				msg.setFrom(new InternetAddress("jeongcode@naver.com" ,"Project"));
			
				to = new InternetAddress(useremail);
				msg.setRecipient(Message.RecipientType.TO, to);
				msg.setSubject("odeTour 인증번호 ","UTF-8");
				msg.setText("인증번호 : [" + adminAuthNum + "]","UTF-8");
				Transport.send(msg);
			} catch (Exception e){
				System.out.println("EmailAuthNumSendService MailSending Error : " + e);
			} 
			return adminAuthNum;
	}
		
	private class MailAuth extends Authenticator{
		PasswordAuthentication pa;
		
		public MailAuth(){
			String mail_id = "jeongcode@naver.com";
			String mail_pw = "ham1194!@";
			
			pa = new PasswordAuthentication(mail_id, mail_pw);
		}
		public PasswordAuthentication getPasswordAuthentication(){
			return pa;
		}
	}

}
