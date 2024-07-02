package util;

public class Common {
	
	//댓글 페이징 관련
//	public static class Comment{
//		public static final String VIEW_PATH = "/WEB-INF/views/comment/";
//		public final static int BLOCKLIST = 5; //댓글 5개씩 보이도록 함.
//		public final static int BLOCKPAGE = 3;
//	} //댓글을 쓰지 않고 답변만 필요하므로 이건 쓰지 않음.
	
	//객체 관리를 편하게 하기 위한 클래스
	//게시판 별로 한 페이지에 보여질 게시글 수가 상이할(다를) 수 있으므로
	//관리를 편리하게 할 수 있도록 내부 클래스를 활용
	
	public static class Qna{ //클래스 안의 클래스. 내부 클래스
		
		public static final String VIEW_PATH = "/WEB-INF/views/qna/";
		//qna가 board였음.
		
		//한 페이지당 보여줄 게시글의 수
		public final static int BLOCKLIST = 5;
		
		//한 화면에 보여지는 페이지 메뉴의 수
		//< 1 2 3 > 이렇게 만들어져 있음. 여기서 이 숫자를 몇개까지 잡고 싶냐? 라는 말.
		public final static int BLOCKPAGE = 5;
	}

}
