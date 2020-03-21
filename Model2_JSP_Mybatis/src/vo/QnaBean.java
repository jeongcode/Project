package vo;

public class QnaBean {
	private String nickname , email , title , content , writedate ;
	private int idx , admincheck , readcheck;
	
	public QnaBean(){};
	public QnaBean(String nickname, String email, String title, String content, String writedate, int admincheck,
			int readcheck) {
		this.nickname = nickname;
		this.email = email;
		this.title = title;
		this.content = content;
		this.writedate = writedate;
		this.admincheck = admincheck;
		this.readcheck = readcheck;
	}
	
	@Override
	public String toString() {
		return "QnaBean [nickname=" + nickname + ", email=" + email + ", title=" + title + ", content=" + content
				+ ", writedate=" + writedate + ", admincheck=" + admincheck + ", readcheck=" + readcheck + "]";
	}
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public int getAdmincheck() {
		return admincheck;
	}
	public void setAdmincheck(int admincheck) {
		this.admincheck = admincheck;
	}
	public int getReadcheck() {
		return readcheck;
	}
	public void setReadcheck(int readcheck) {
		this.readcheck = readcheck;
	}
	
	
}
