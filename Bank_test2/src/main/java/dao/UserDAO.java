package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.RateVO;
import vo.UserVO;

public class UserDAO {
	SqlSession sqlSession;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//비밀번호 일치 확인
	public UserVO check( String user_id ) {
		UserVO vo = sqlSession.selectOne("u.select_one", user_id);
		return vo;
	}

	public UserVO check_tel( String user_tel ) {
		UserVO vo = sqlSession.selectOne("u.select_one", user_tel);
		return vo;
	}
	
	public String check_sign( String user_id ) {
		String res = sqlSession.selectOne("u.select_sign", user_id);
		return res;
	}
	
	// 회원가입
	public int insert(UserVO vo) {
		int cnt = sqlSession.insert("u.user_ins", vo);
		return cnt;
	}
	
	public int insert_admin(UserVO vo) {
		System.out.println(vo.getUser_id());
		System.out.println(vo.getUser_name());
		System.out.println(vo.getUser_pwd());
		System.out.println(vo.getUser_tel());
		System.out.println(vo.getUser_addr());

		int cnt = sqlSession.insert("u.user_ins_admin" , vo);
		return cnt;
	}
 
}
