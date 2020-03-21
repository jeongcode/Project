package vo;

public class MemberBean {
	
	private String nickname;
	private String pwd;
	private String email;
	private int point;
	private String tel;
	private String joindate;
	
	public MemberBean() {}
	public MemberBean(String nickname, String pwd, String email, String tel , String joindate , int point) {
		this.nickname = nickname;
		this.pwd = pwd;
		this.email = email;
		this.tel = tel;
		this.joindate = joindate;
		this.point = point;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	
}
