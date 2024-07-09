package common;

import javax.servlet.jsp.tagext.TryCatchFinally;

import org.springframework.security.crypto.bcrypt.BCrypt;
//import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import dao.AccountDAO;
import dao.UserDAO;
import vo.AccountVO;
import vo.UserVO;

public class Common {

	public static class Bank {
		public static final String VIEW_PATH = "/WEB-INF/views/bank/";
	}

	public static class Account {
		public static final String VIEW_PATH_AC = "/WEB-INF/views/account/";
	}
	
	public static class Header {
		public static final String VIEW_PATH_HD = "/WEB-INF/views/header/";
	}
	
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
		}
	
	public static class SecurePwd {
		// 계좌 비밀번호 암호화 메서드
		public static String encodePwd(String pwd) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String encodePwd = encoder.encode(pwd); // 비밀번호 암호화
			return encodePwd;
		}

		// 비밀번호 복호화 메서드
		public static boolean decodePwd(AccountVO vo, AccountDAO account_dao) {
			boolean isValid = false; // 암호 일치 여부 확인

			AccountVO resultVO = account_dao.check(vo.getAccount_number());

			if (resultVO != null) {
				// 입력한 비밀번호와 DB의 암호화된 비밀번호가 일치하면
				// isValid가 true가 된다.
				isValid = BCrypt.checkpw(vo.getAccount_pwd(), resultVO.getAccount_pwd());
			}

			return isValid;
		}
	}

	public static class Secure_userPwd {
		// 비밀번호 비교 메서드
		public static boolean decodePwd(UserVO vo, UserDAO user_dao) {
			boolean isValid = false; // 암호 일치 여부 확인

			UserVO resultVO = user_dao.check(vo.getUser_id());

			if (resultVO != null) {
				// 입력한 비밀번호와 DB의 암호화된 비밀번호가 일치하면 isValid가 true가 된다.
				try {
					System.out.println("입력된 비밀번호: " + vo.getUser_pwd());
					System.out.println("DB의 암호화된 비밀번호: " + resultVO.getUser_pwd());
					isValid = BCrypt.checkpw(vo.getUser_pwd(), resultVO.getUser_pwd());
				} catch (Exception e) {
					// 예외 처리
					System.out.println("오류 발생:");
					e.printStackTrace();
				}
			}

			System.out.println("isValid : " + isValid);
			return isValid;
		}

	}
}
