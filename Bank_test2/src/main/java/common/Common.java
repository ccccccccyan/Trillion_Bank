package common;

import javax.servlet.jsp.tagext.TryCatchFinally;

import org.springframework.security.crypto.bcrypt.BCrypt;
//import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import dao.UserDAO;
import vo.UserVO;



public class Common {

	public static class Bank {
		public static final String VIEW_PATH = "/WEB-INF/views/bank/";
	}

	public static class SecurePwd {
		// 비밀번호 암호화 메서드
		public static String encodePwd(String user_pwd) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String encodePwd = encoder.encode(user_pwd); // 비밀번호 암호화
			return encodePwd;
		}

		// 비밀번호 복호화 메서드
		public static boolean decodePwd(UserVO vo, UserDAO user_dao) {
			boolean isValid = false; // 암호 일치 여부 확인

			UserVO resultVO = user_dao.check(vo.getUser_id());
			

			
			if (resultVO != null) {
				// 입력한 비밀번호와 DB의 암호화된 비밀번호가 일치하면
				// isValid가 true가 된다.
				System.out.println("1:"+vo.getUser_pwd());
				System.out.println("2:"+resultVO.getUser_pwd());
				
				try {
				isValid = BCrypt.checkpw(vo.getUser_pwd(), resultVO.getUser_pwd());
				}catch (Exception e) {
					//le exception
					System.out.println("err:");
					e.printStackTrace();
				}
			}

			return isValid;
		}
	}
}
