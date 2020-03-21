package web.mail;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSend {
	
	public String MailSending(String useremail){
		String adminAuthNum = "";
		for(int i = 0 ; i < 6 ; i++){
			adminAuthNum += (int)(Math.random() * 10) ;
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
			msg.setSubject("JspProject 인증 번호 ","UTF-8");
			msg.setText("인증 번호 : [" + adminAuthNum + "]","UTF-8");
			Transport.send(msg);
			System.out.println("이메일 전송 완료");
		} catch (AddressException e){
			System.out.println("AddressException Error : " + e);
		} catch (MessagingException e) {
			System.out.println("MessagingException Error : " + e);
		} catch (UnsupportedEncodingException e) {
			System.out.println("UnsupportedEncodingException : " + e);
		}
		return adminAuthNum;
	}
}
