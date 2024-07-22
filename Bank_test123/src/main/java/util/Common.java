package util;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import dao.RateBDAO;
import vo.RateboardVO;

public class Common {
	
	//객체 관리를 편하게 하기 위한 클래스
	//게시판 별로 한 페이지에 보여질 게시글 수가 상이할(다를) 수 있으므로
	//관리를 편리하게 할 수 있도록 내부 클래스를 활용
	
	public static class Notice{ //클래스 안의 클래스. 내부 클래스
		
		public static final String VIEW_PATH = "/WEB-INF/views/notice/";
		//notice가 board였음.
		
		//한 페이지당 보여줄 게시글의 수
		public final static int BLOCKLIST = 5;
		
		//한 화면에 보여지는 페이지 메뉴의 수
		//< 1 2 3 > 이렇게 만들어져 있음. 여기서 이 숫자를 몇개까지 잡고 싶냐? 라는 말.
		public final static int BLOCKPAGE = 5;
	}
	
	public static class Qna{ //클래스 안의 클래스. 내부 클래스
		
		public static final String VIEW_PATH = "/WEB-INF/views/qna/";
		//qna가 board였음.
		
		//한 페이지당 보여줄 게시글의 수
		public final static int BLOCKLIST = 5;
		
		//한 화면에 보여지는 페이지 메뉴의 수
		//< 1 2 3 > 이렇게 만들어져 있음. 여기서 이 숫자를 몇개까지 잡고 싶냐? 라는 말.
		public final static int BLOCKPAGE = 5;
	}
	
	//댓글 페이징 관련
		public static class Comment{
			public static final String VIEW_PATH = "/WEB-INF/views/comment/";
			public final static int BLOCKLIST = 5; //댓글 5개씩 보이도록 함.
			public final static int BLOCKPAGE = 3;
		} //댓글을 쓰지 않고 답변만 필요하므로 이건 쓰지 않음.
		
		//객체 관리를 편하게 하기 위한 클래스
		//게시판 별로 한 페이지에 보여질 게시글 수가 상이할(다를) 수 있으므로
		//관리를 편리하게 할 수 있도록 내부 클래스를 활용
		
		public static class Rate{ //클래스 안의 클래스. 내부 클래스
			
			public static final String VIEW_PATH = "/WEB-INF/views/rate/";
			//rate가 board였음.
			
			//한 페이지당 보여줄 게시글의 수
			public final static int BLOCKLIST = 5;
			
			//한 화면에 보여지는 페이지 메뉴의 수
			//< 1 2 3 > 이렇게 만들어져 있음. 여기서 이 숫자를 몇개까지 잡고 싶냐? 라는 말.
			public final static int BLOCKPAGE = 5;
			
			// 비밀번호 암호화 메서드
			public static String encodePwd(String pwd) {
				BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
				String encodePwd = encoder.encode(pwd); // 비밀번호 암호화
				return encodePwd;
			}
			
			// 비밀번호 검증 메서드
			public static boolean decodePwd(RateboardVO vo, RateBDAO rateb_dao) {
				boolean isValid = false;
				RateboardVO resultVO = rateb_dao.Check(vo.getR_board_idx());
				
				if (resultVO != null) {
					// 입력한 비밀번호와, DB의 암호환된 비밀번호가 일치하면
					// isValid가 true가 된다.
					isValid = BCrypt.checkpw(vo.getPwd(), resultVO.getPwd());
				}
				return isValid;

			}
			
		}
	
}
