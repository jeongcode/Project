package vo;

public class QnaReplyBean {
	private String writer, content , writedate ;
	private int idx , parentnum;
	
	public QnaReplyBean(){};
	public QnaReplyBean(int idx, String writer, String content, String writedate, int parentnum) {
		this.writer = writer;
		this.content = content;
		this.writedate = writedate;
		this.idx = idx;
		this.parentnum = parentnum;
	}
	
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
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
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getParentnum() {
		return parentnum;
	}
	public void setParentnum(int parentnum) {
		this.parentnum = parentnum;
	}
	
	
}
