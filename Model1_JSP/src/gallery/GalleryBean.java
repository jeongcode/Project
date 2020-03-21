package gallery;

import java.sql.Timestamp;

public class GalleryBean {
	private int num , readcount;
	private String email, passwd, nickname, subject, content, file , originFile;
	private Timestamp date;
	
	@Override
	public String toString() {
		return "num : " + num +
				" email : " + email +
				" passwd : " + passwd +
				" nickname : " + nickname +
				" subject : " + subject +
				" file : " + file;
	}
/*	num	int(11)
	email	varchar(30)
	nickname	varchar(15)
	subject	varchar(50)
	content	varchar(2000)
	file	varchar(50)
	readcount	int(11)
	date	datetime*/
	
	public String getOriginFile() {
		return originFile;
	}
	
	public void setOriginFile(String originFile) {
		this.originFile = originFile;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	
}
