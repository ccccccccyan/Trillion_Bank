package vo;

public class QnaVO {
	private int q_board_idx, depth, q_board_ref;
	private String subject, content, user_id, regdate;
	
	public int getQ_board_idx() {
		return q_board_idx;
	}
	public void setQ_board_idx(int q_board_idx) {
		this.q_board_idx = q_board_idx;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getQ_board_ref() {
		return q_board_ref;
	}
	public void setQ_board_ref(int q_board_ref) {
		this.q_board_ref = q_board_ref;
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
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
