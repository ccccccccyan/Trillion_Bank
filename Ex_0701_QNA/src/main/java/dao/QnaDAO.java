package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.QnaVO;

public class QnaDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	} // 생성자가 아니라 set으로 만들어주기

	// 전체 게시글 조회
	public List<QnaVO> selectList(Map<String, Object> map) {
		List<QnaVO> list = sqlSession.selectList("q.qna_list", map);
		return list;
	}

	// 전체 게시글 수
	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("q.qna_count", map);
		return count;
	}

	// 상세보기를 위한 게시글 조회
	public QnaVO selectOne(int q_board_idx) { // 조회하고 싶은 게시글의 번호
		QnaVO vo = sqlSession.selectOne("q.qna_one", q_board_idx);
		return vo;
	}

	// 새 글 추가
	public int insert(QnaVO vo) {
		int res = sqlSession.insert("q.qna_insert2", vo);
		return res;
	}

	// 게시글 삭제
	public int del_update(int q_board_idx) {
		int res = sqlSession.delete("q.qna_del_upd", q_board_idx);
		return res;
	}

	// 답변 작성을 위한 자리 확보
	public int update_step(QnaVO qna_dao) {
		int res = sqlSession.update("q.board_update_step", qna_dao);
		return res;
	}

	// 부모 글의 depth 값을 가져오는 메서드
	private int getParentDepth(int q_board_ref) {
		int res = sqlSession.selectOne("q.getParentDepth", q_board_ref);
		return res; // 기본 값으로 0을 반환
	}
	
	// 답변 작성
	public int reply(QnaVO qna_vo) {
		//부모 글의 depth 값을 가져와서 증가시키기
		//int parentDepth = getParentDepth(qna_vo.getQ_board_ref());
		//qna_vo.setDepth(parentDepth + 1);
		
		int res = sqlSession.insert("q.board_reply", qna_vo);
		return res;
	}

}
