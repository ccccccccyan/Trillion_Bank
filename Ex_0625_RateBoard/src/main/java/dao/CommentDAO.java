package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.CommentVO;

public class CommentDAO {
	
	SqlSession sqlSession;

	public CommentDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 코멘트 등록
	public int comment_insert(CommentVO vo) {
		int res = sqlSession.insert("c.comment_insert", vo);
		return res;
	}

	// 코멘트 조회
	public List<CommentVO> selectList(Map<String, Object> map) {
		List<CommentVO> list = sqlSession.selectList("c.comment_list", map);
		return list;
	}

	// 페이지를 위한 전체 게시글 갯수
	public int getRowTotal(Map<String, Object> map) {
		int cnt = sqlSession.selectOne("c.comment_idx_count", map);
		return cnt;
	}

	// 코멘트 삭제
	public int comm_del(int c_board_idx) {
		int res = sqlSession.delete("c.comment_delete", c_board_idx);
		return res; // 결과가 1인지 0인지 보내줌.
	}
	// 게시글 삭제시 그 게시글 코멘트 삭제
	public int rbooard_comm_del(int r_board_idx) {
		int res = sqlSession.delete("c.deleteCommentsByBoardIdx", r_board_idx);
		return res;
	}
	
	//게시글 id로 댓글 삭제하기 (게시글 삭제할 때 댓글도 삭제하기)
	public int deleteCommentsByBoardIdx(int r_board_idx) {
		int res = sqlSession.delete("c.deleteCommentsByBoardIdx", r_board_idx);
		return res;
	}
	
}
