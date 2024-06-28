package com.kh.bank;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.RateDAO;
import dao.UserDAO;
import service.BankService;
import vo.RateVO;
import vo.UserVO;

@Controller
public class BankController {

    @Autowired
    ServletContext app;

    @Autowired
    HttpServletRequest request;

    @Autowired
    RateDAO rate_dao;

    @Autowired
    UserDAO user_dao;

    public BankController() {
        // TODO Auto-generated constructor stub
    }

    public BankController(RateDAO rate_dao) {
        this.rate_dao = rate_dao;
    }

    @RequestMapping("list.do")
    public String list(Model model) throws IOException {
        LocalDate date = LocalDate.now();
        DateTimeFormatter fommat_date = DateTimeFormatter.ofPattern("yyyyMMdd");
        String formattedDate = date.format(fommat_date);
        List<RateVO> list_ok = rate_dao.selectList_ok(formattedDate);

        if (list_ok.size() == 0) {
            BankService bank = new BankService();
            List<RateVO> list = bank.bank_serv(formattedDate);

            if (list.get(0).getCur_nm() == null || list.get(0).getCur_nm().isEmpty()) {
                int res = rate_dao.no_insert(list.get(0));
            } else {
                for (int j = 0; j < list.size(); j++) {
                    int res = rate_dao.data_insert(list.get(j));
                }
            }
        }

        List<RateVO> selectlist = rate_dao.selectList();
        model.addAttribute("list", selectlist);
        return Common.Bank.VIEW_PATH + "bank_list.jsp";
    }

    @RequestMapping(value = { "/", "/home.do" })
    public String Home() {
        return Common.Bank.VIEW_PATH + "home.jsp";
    }

    @RequestMapping("/login.do")
    public String login() {
        return Common.Bank.VIEW_PATH + "login.jsp";
    }

    @RequestMapping(value = "/signup.do", produces = "application/json;charset=UTF-8")
    public String signup() {
        return Common.Bank.VIEW_PATH + "signup.jsp";
    }

    @RequestMapping("/login_check.do")
    @ResponseBody
    public String login_check(UserVO vo) {
        boolean isPwd = Common.SecurePwd.decodePwd(vo, user_dao);

        System.out.println("isPwd : " + isPwd);

        if (isPwd) {
            String res = String.format("[{'result':'clear', 'User_id':'%s'}]", vo.getUser_id());
            return res;
        } else {
            return "[{'result':'no'}]";
        }
    }

    @RequestMapping(value = "/signup_ins.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String signup_ins(UserVO vo) {
        // 중복된 user_id 확인
        UserVO existingUser = user_dao.check(vo.getUser_id());
        if (existingUser != null) {
            return "[{'result':'duplicate'}]";
        }

        if (vo.getUser_id().toLowerCase().contains("admin")) {
            vo.setManager("Y");
        } else {
            vo.setManager("N");
        }

        String encode_pwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
        vo.setUser_pwd(encode_pwd);

        try {
            String res = String.format(
                "[{'result':'clear', 'User_id':'%s','User_name':'%s','User_pwd':'%s' ,'User_tel':'%s','User_addr':'%s','Manager':'%s'}]",
                vo.getUser_id(), vo.getUser_name(), vo.getUser_pwd(), vo.getUser_tel(), vo.getUser_addr(),
                vo.getManager());
            return res;
        } catch (Exception e) {
            e.printStackTrace();
            return "[{'result':'error'}]";
        }
    }
    
    @RequestMapping(value = "/signup_ins_id.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String signup_ins_id(UserVO vo) {
        UserVO existingUser = user_dao.check_id(vo.getUser_id());
        if (existingUser != null) {
            return "[{'result':'duplicate'}]";
        }

        try {
            String res = String.format(
                "[{'result':'clear', 'User_id':'%s'}]", vo.getUser_id());   
            return res;
        } catch (Exception e) {
            e.printStackTrace();
            return "[{'result':'error'}]";
        }
    }
    
    @RequestMapping(value = "/signup_ins_tel.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String signup_ins_tel(UserVO vo) {
        // 중복된 user_id 확인
        UserVO existingUser = user_dao.check_tel(vo.getUser_tel());	
        if (existingUser != null) {
            return "[{'result':'duplicate'}]";
        }

        try {
            String res = String.format(
                "[{'result':'clear', 'User_tel':'%s'}]", vo.getUser_tel());   
            return res;
        } catch (Exception e) {
            e.printStackTrace();
            return "[{'result':'error'}]";
        }
    }


    @RequestMapping("/signup_final.do")
    public String signup_final(UserVO vo) {
        String encode_pwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
        vo.setUser_pwd(encode_pwd);
        System.out.println(encode_pwd);
        user_dao.insert(vo);
        return Common.Bank.VIEW_PATH + "login.jsp";
    }
    
    @RequestMapping("/search_id.do")
    public String search_id() {
    	return Common.Bank.VIEW_PATH + "search_id.jsp";
    }

    @RequestMapping("/search_pwd.do")
    public String search_pwd() {
    	return Common.Bank.VIEW_PATH + "search_pwd.jsp";
    }

    @RequestMapping(value = "/search_id2.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String search_id2(UserVO vo) {
        // 중복된 user_id 확인
        UserVO existingUser = user_dao.check_tel(vo.getUser_tel());
        if (existingUser == null) {
            return "[{'result':'duplicate'}]";
        }

        try {
            String res = String.format(
                "[{'result':'clear', 'User_id':'%s'}]", existingUser.getUser_id());   
            return res;
        } catch (Exception e) {
            e.printStackTrace();
            return "[{'result':'error'}]";
        }
    }
    
    @RequestMapping(value = "/search_pwd2.do", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String search_pwd2(UserVO vo) {
        
        UserVO existingUser = user_dao.check_id(vo.getUser_id());
        if (existingUser == null) {
            return "[{'result':'duplicate'}]";
        }
        
        try {
            String res = String.format(
                "[{'result':'clear', 'User_id':'%s' , 'User_pwd':'%s'}]",existingUser.getUser_id(), existingUser.getUser_pwd());   
            return res;
        } catch (Exception e) {
            e.printStackTrace();
            return "[{'result':'error'}]";
        }
    }
    
    @RequestMapping("/change_pwd.do")
    public String change_pwd(@RequestParam("user_id") String user_id, Model model) {
        System.out.println(user_id);
    	model.addAttribute("user_id", user_id);
        return Common.Bank.VIEW_PATH + "change_pwd.jsp";
    }
   
    @RequestMapping("/change_pwd_final.do")
    public String change_pwd_final(UserVO vo) {
        String encode_pwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
        vo.setUser_pwd(encode_pwd);
        System.out.println(encode_pwd);
        user_dao.update(vo);
        return "redirect:/login.do";
    }

}


























