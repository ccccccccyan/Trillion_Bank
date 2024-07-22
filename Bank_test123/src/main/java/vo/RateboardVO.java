package vo;

public class RateboardVO {
	private int r_board_idx, comm_cnt;
	private String subject, name, content, pwd, regdate;
	
	public int getR_board_idx() {
		return r_board_idx;
	}
	public void setR_board_idx(int r_board_idx) {
		this.r_board_idx = r_board_idx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getComm_cnt() {
		return comm_cnt;
	}
	public void setComm_cnt(int comm_cnt) {
		this.comm_cnt = comm_cnt;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
