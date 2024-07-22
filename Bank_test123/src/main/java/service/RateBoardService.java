package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import dao.CommentDAO;
import dao.RateBDAO;

public class RateBoardService {
	
	@Autowired
	private RateBDAO rateb_dao;
	
	@Autowired
	private CommentDAO comment_dao;
	
	//이건 잘 모르겠음... gpt가 알려준 거임.
	@Transactional
	public void deleteRateBoard(int r_board_idx) {
		//댓글 삭제 (코멘트들 모두 삭제하기)
		comment_dao.deleteCommentsByBoardIdx(r_board_idx);
		
		//게시글 삭제
		rateb_dao.delete(r_board_idx);
	}
	
}
