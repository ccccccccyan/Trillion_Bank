package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.RateVO;
import vo.UserVO;

@Repository
public class UserDAO {
	SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 비밀번호 일치 확인
	public UserVO check(String user_id) {
		UserVO vo = sqlSession.selectOne("u.select_one", user_id);
		return vo;
	}

	// 아이디로 회원정보 찾기
	public UserVO check_id(String user_id) {
		UserVO vo = sqlSession.selectOne("u.select_one", user_id);
		return vo;
	}

	// 전화번호로 회원 정보 찾기
	public UserVO check_tel(String user_tel) {
		UserVO vo = sqlSession.selectOne("u.select_tel", user_tel);
		return vo;
	}

	// 왜 만들었는지 저도 모르겠어요
	public String check_sign(String user_id) {
		String res = sqlSession.selectOne("u.select_sign", user_id);
		return res;
	}

	// 회원가입
	public int insert(UserVO vo) {
		int cnt = sqlSession.insert("u.user_ins", vo);
		return cnt;
	}

	// 비밀번호 변경
	public int update(UserVO vo) {
		int cnt = sqlSession.insert("u.user_upd", vo);
		return cnt;
	}

	// 매니저 아이디 회원가입
	public int insert_admin(UserVO vo) {
		int cnt = sqlSession.insert("u.user_ins_admin", vo);
		return cnt;
	}
	
	public int delete_user(String user_id) {
		int res = sqlSession.delete("u.user_delete", user_id);
		return res;
	}

}
