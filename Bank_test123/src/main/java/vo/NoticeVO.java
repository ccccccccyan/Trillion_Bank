package vo;

public class NoticeVO {
	private int r_notice_idx;
	private String subject, name, content, regdate;
	
	public int getR_notice_idx() {
		return r_notice_idx; //공지사항의 일련 번호
	}
	public void setR_notice_idx(int r_notice_idx) {
		this.r_notice_idx = r_notice_idx;
	}
	public String getSubject() {
		return subject; //공지사항 제목
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getName() {
		return name; //공지사항을 적은 관리자의 이름
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content; //공지사항 내용
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate; //공지사항이 올라간 날짜 및 시간
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
