package common;

import org.springframework.security.crypto.bcrypt.BCrypt;
//import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import dao.AccountDAO;
import vo.AccountVO;

//import dao.VisitDAO;
//import vo.VisitVO;

public class Common {
	
	public static class Bank{
		public static final String VIEW_PATH = "/WEB-INF/views/bank/";
	}

	public static class Account{
		public static final String VIEW_PATH_AC = "/WEB-INF/views/account/";
	}

	public static class SecurePwd{
		//비밀번호 암호화 메서드
		public static String encodePwd(String pwd) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String encodePwd = encoder.encode(pwd); //비밀번호 암호화
			return encodePwd;
		}
	
		//비밀번호 복호화 메서드
		public static boolean decodePwd(AccountVO vo, AccountDAO account_dao) {
			boolean isValid = false; // 암호 일치 여부 확인
			
			AccountVO resultVO = account_dao.check(vo.getAccount_number());
			
			if(resultVO != null ) {
				// 입력한 비밀번호와 DB의 암호화된 비밀번호가 일치하면 
				// isValid가 true가 된다.
				isValid = BCrypt.checkpw(vo.getAccount_pwd(), resultVO.getAccount_pwd());
			}
			
			return isValid;
		}
	}
}
