package vo;

public class CommentVO {
	/*c_board_idx는 댓글의 일련번호, r_board_idx는 기준글의 일련번호*/
	private int c_board_idx;
	private String name, content, comm_pwd;
	private int r_board_idx;
	
	public int getC_board_idx() {
		return c_board_idx;
	}
	public void setC_board_idx(int c_board_idx) {
		this.c_board_idx = c_board_idx;
	}
	public int getR_board_idx() {
		return r_board_idx;
	}
	public void setR_board_idx(int r_board_idx) {
		this.r_board_idx = r_board_idx;
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
	public String getComm_pwd() {
		return comm_pwd;
	}
	public void setComm_pwd(String comm_pwd) {
		this.comm_pwd = comm_pwd;
	}
	
}
