package com.kh.bank;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CommentDAO;
import dao.RateBDAO;
import util.Common;
import util.Paging;
import vo.CommentVO;
import vo.RateVO;
import vo.RateboardVO;

@Controller
public class RateController {

	@Autowired
	ServletRequest request;

	@Autowired
	HttpSession session;

	RateBDAO rateb_dao;
	CommentDAO comment_dao;

//	public void setRate_dao(RateDAO rate_dao) {
//		this.rate_dao = rate_dao;
//	} //위에서 Spring이 @Autowired를 통해 주입할 것이기에 이렇게 하지 않아도 된다고 함. gpt가.

	public RateController(RateBDAO rateb_dao, CommentDAO comment_dao) {
		this.rateb_dao = rateb_dao;
		this.comment_dao = comment_dao;
	}
	
	// 전체 게시글 보기
	@RequestMapping("/r_list.do")
	public String list(Model model, String page, String search, String search_text) {
		int nowPage = 1; // 현재 페이지 1페이지부터 시작
		if (page != null && !page.isEmpty()) { // null 체크
			nowPage = Integer.parseInt(page);
		}

		// 한 페이지에 표시되는 게시물의 시작과 끝 번호를 계산
		// ?page=10 -> 끝 번호
		int start = (nowPage - 1) * Common.Rate.BLOCKLIST + 1;
		int end = start + Common.Rate.BLOCKLIST - 1;

		// start와 end변수를 Map에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start); // "start"라는 키값에 start를 저장. (시작 번호)
		map.put("end", end); // "end"라는 키값에 end를 저장. (끝 번호)

		// 검색어 관련 파라미터
		// list.do?search=name&search_text=abc&page=2

		// 검색할 내용이 있는 경우
		if (search != null && !search.equals("all")) {

			if (search.equals("name_subject_content")) {
				map.put("name", search_text);
				map.put("subject", search_text);
				map.put("content", search_text);

			} else if (search.equals("name")) {
				map.put("name", search_text);

			} else if (search.equals("subject")) {
				map.put("subject", search_text);

			} else if (search.equals("content")) {
				map.put("content", search_text);
			} // inner if

		} // if

		// 전체 목록 가져오기
		List<RateboardVO> list = rateb_dao.selectList(map);
		// 전체 게시글 수 가져오기
		int row_total = rateb_dao.getRowTotal(map); // 얘한테도 맵 주기

		// 이걸 페이징.자바에게 보냄.
		// 페이지 메뉴 생성
		String search_param = String.format("search=%s&search_text=%s", search, search_text);

		String pageMenu = Paging.getPaging("r_list.do", nowPage, row_total, search_param, 
				Common.Rate.BLOCKLIST,
				Common.Rate.BLOCKPAGE);
		
		// list객체 바인딩 및 포워딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu); // 리스트 보내는 김에 페이지 메뉴도 같이 보냄.

		return Common.Rate.VIEW_PATH + "rate_list.jsp";
	}

	// 공지사항 게시글 상세보기
	@RequestMapping("/r_view.do")
	public String view(Model model, int r_board_idx) {
		// view.do?r_board_idx=21 <- 21번 글을 상세보기
		// 상세보기를 위한 게시글 조회
		RateboardVO vo = rateb_dao.selectOne(r_board_idx);

		model.addAttribute("vo", vo);
		return Common.Rate.VIEW_PATH + "rate_view.jsp";
	}

	// 새 글 작성 폼
	@RequestMapping("/rate_write.do")
	public String insert_form() {
		return Common.Rate.VIEW_PATH + "rate_write.jsp";
	}

	// 새 글 등록
	@RequestMapping("/r_insert.do")
	public String insert(RateboardVO vo) {
		// 비밀번호 암호화를 위한 클래스 호출
		String encodenPwd = Common.Rate.encodePwd(vo.getPwd());
		vo.setPwd(encodenPwd); // 암호화된 비밀번호로 vo 객체 갱신
		
		rateb_dao.insert(vo);
		return "redirect:r_list.do";
	}

	//수정을 위한 비밀번호 확인
	@RequestMapping("/check_password.do")
	@ResponseBody
	public String modify_chk(RateboardVO vo) {

		//이걸로 입력한 비밀번호랑 원본 비밀번호랑 비교함.
		boolean isValid = Common.Rate.decodePwd(vo, rateb_dao);

		if( isValid ) {
			//비밀번호가 일치함. 수정하는 폼으로 이동. rate_modify.jsp로 이동?
			String resIdx = 
					String.format( "[{'result':'clear', 'r_board_idx':'%d'}]", vo.getR_board_idx() );
			return resIdx;
		}else {
			//비밀번호 불일치
			return "[{'result':'no'}]";
		}

	}
	
	// 수정
	@RequestMapping("/r_board_modify.do")
	public String board_modify(int r_board_idx, Model model) {
		RateboardVO vo = rateb_dao.selectOne(r_board_idx);
		model.addAttribute("vo", vo);

		return Common.Rate.VIEW_PATH + "rate_modify.jsp";
	}

	// 수정 제출
	@RequestMapping("/rate_update.do") // ("/modify_fin.do")<-였다.
	@ResponseBody
	public String modify_fin(RateboardVO vo) {

		//비밀번호 암호화
		String encodePwd = Common.Rate.encodePwd(vo.getPwd());
		vo.setPwd(encodePwd);
		int res = rateb_dao.update(vo);

		if(res > 0) {
			return "[{\"result\":\"clear\"}]";
		}else {
			return "[{\"result\":\"fail\"}]";
		}

	}

	// 글 삭제
	@RequestMapping("/r_del.do")
	@ResponseBody //이걸 넣어주어야 돌아간다.
	public String del(RateboardVO vo) {

		boolean isValid = Common.Rate.decodePwd(vo, rateb_dao);
		if( isValid ) {
			//실제 삭제
			int res_del = rateb_dao.delete(vo.getR_board_idx());

			if( res_del > 0 ) {
				//삭제 성공
				return "[{'result':'clear'}]";
			}else {
				//삭제 실패
				return "[{'result':'fail'}]";
			}

		}else {
			//비밀번호가 일치하지 않는다면
			return "[{'result':'no'}]";
		}

	}

	/* 위의 것들은 게시글 자체에 대한 것, 아래의 것들은 댓글에 대한 것 */

	// 댓글(코멘트) 추가
	@RequestMapping("/r_comment_insert.do")
	@ResponseBody
	public String comment_insert(CommentVO vo) {
		int res = comment_dao.comment_insert(vo);

		String result = "no";
		if (res > 0) {
			result = "yes";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);

		return resultStr;
	}

	// 코멘트 갱신 (현 화면에서 댓글이 갱신되도록 함.)
	@RequestMapping("/r_comment_list.do")
	public String comment_list(Model model, String page, int r_board_idx) {

		int nowPage = 1; //1페이지부터 시작함.

		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}

		int start = (nowPage - 1) * Common.Comment.BLOCKLIST + 1;
		int end = start + Common.Comment.BLOCKLIST - 1;

		// 메인 게시글 번호
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("r_board_idx", r_board_idx); //이 부분 다시 생각하기. idx가 맞나??
		map.put("start", start);
		map.put("end", end);

		List<CommentVO> list = comment_dao.selectList(map);
		int row_total = comment_dao.getRowTotal(map);
		
		// 페이지 메뉴
		String pageMenu = Paging.getPaging("r_comment_list.do", nowPage, row_total, 
				Common.Comment.BLOCKLIST,
				Common.Comment.BLOCKPAGE);

		//같이 바인딩 해줌.
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.Comment.VIEW_PATH + "comment_list.jsp";

	}
	
	//코멘트(댓글) 삭제
	@RequestMapping("/r_comment_del.do")
	@ResponseBody
	public String comment_delete(int c_board_idx) {

		//comment_del.do?c_board_idx=15
		//int c_board_idx = Integer.parseInt( request.getParameter("c_board_idx") );
		//얘는 위에서 파라미터로 받고 있으니까 윗줄이 없어도 괜찮음!
		
		int res = comment_dao.comm_del(c_board_idx);
		//c_board_idx를 보내줄거임. 잘지우면 1, 실패는 0

		String result = "no";
		if (res > 0) {
			result = "yes"; // 바로 콜백으로 보냄.
		}

		String resultStr = String.format("[{'result':'%s'}]", result);
		return resultStr;

	}

}
