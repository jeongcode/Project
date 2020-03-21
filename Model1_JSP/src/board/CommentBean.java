package board;

import java.sql.Timestamp;

public class CommentBean {
	
	private int num;
	private String email;
	private String nickname;
	private String content;
	private Timestamp date;
	private int reg_seq;
	/*	num int(11) 
	email varchar(30) 
	nickname varchar(15) 
	reg_date datetim*/
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getReg_seq() {
		return reg_seq;
	}
	public void setReg_seq(int reg_seq) {
		this.reg_seq = reg_seq;
	}

}
