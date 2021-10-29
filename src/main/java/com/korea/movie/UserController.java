package com.korea.movie;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import common.Common;
import dao.TicketDAO;
import dao.UserDAO;
import vo.TicketVO;
import vo.UserVO;


@Controller
public class UserController {

	UserDAO user_dao;	// ==> @Repository에 있는 별칭과 똑같이 만들어줘야 한다.
	public void setUser_dao(UserDAO user_dao) {
		this.user_dao = user_dao;
	}
	TicketDAO ticket_dao;
	public void setTicket_dao(TicketDAO ticket_dao) {
		this.ticket_dao = ticket_dao;
	}
	
	@Autowired
	HttpServletRequest request;

	public UserController() {

	}

	// 회원가입 폼으로 이동
	@RequestMapping("/register_form.do")
	public String register_form() {
		return Common.User.VIEW_PATH + "register_form.jsp";
	}
	
	// 회원가입 (아이디 중복체크)
	@RequestMapping("/id_check.do")
	@ResponseBody
	public String id_check(String id) {
		
		int res = user_dao.id_check(id);
		
		String result = "";
		if(res != 0) {
			result = "have_id";
			return result;
		}
		
		result = "ok_id";
		return result;
	}
	
	// 회원가입 (이메일 인증)
	@RequestMapping("/email_auth.do")
	@ResponseBody
	public String email_auth(String email) {
		
		// 이메일 중복체크
		int res = user_dao.check_email(email);
		
		if(res == 1) {
	        return "";
		}
		
		// 인증키 생성
		int email_random_key = new Random().nextInt(999999) + 100000;
		
		String setfrom = "pwk2380@gmail.com";
        String tomail = request.getParameter("email");    //받는 사람의 이메일
        String title = "회원가입 이메일 인증 메일 입니다.";    //제목
        String content =
        		
        		System.getProperty("line.separator")+
                
                System.getProperty("line.separator")+
                        
                "안녕하세요! 저희 홈페이지를 찾아주셔서 감사합니다"
                
                +System.getProperty("line.separator")+
                
                System.getProperty("line.separator")+
        
                "이메일 인증번호는 " + email_random_key + " 입니다. "
                
                +System.getProperty("line.separator")+
                
                System.getProperty("line.separator")+
                
                "받으신 인증번호를 회원가입 페이지에 입력해 주세요."; // 내용
        
        try {

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

            messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
            messageHelper.setTo(tomail); // 받는사람 이메일
            messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
            messageHelper.setText(content); // 메일 내용
            
            mailSender.send(message);
    
        } catch (Exception e) {
            System.out.println(e);
        }
		
        String random_key = String.valueOf(email_random_key);
        System.out.println(random_key);
        return random_key;
        
		
	}
	
	// 회원가입
	@RequestMapping("/register.do")
	public String register_member( UserVO vo, HttpServletResponse response) throws IOException {
		
		int res = user_dao.register_member(vo); 
		
		if(res != 1) {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out_equals = response.getWriter();
            out_equals.println("<script>alert('회원가입 실패!');</script>");
            out_equals.flush();
			
			return Common.User.VIEW_PATH + "register_form.jsp";
		}
		
		response.setContentType("text/html; charset=UTF-8");
        PrintWriter out_equals = response.getWriter();
        out_equals.println("<script>alert('회원가입이 완료되었습니다!');</script>");
        out_equals.flush();
		
		return Common.User.VIEW_PATH + "login_form.jsp";
	}
	
	// 로그인 폼으로 이동
	@RequestMapping("/login_form.do")
	public String login_form(int seat) {
		if(seat==1) {
			return "WEB-INF/views/ticket/login_form1.jsp";
		} else if( seat==2 ){
			return Common.Movie.VIEW_PATH + "login_form3.jsp";
		}
		else {
			return Common.User.VIEW_PATH + "login_form.jsp";
		}
	}
	/*
	 * public String login_form() { return Common.User.VIEW_PATH + "login_form.jsp";
	 * }
	 */
	
	// 로그인할 id 검색
	@RequestMapping("/login.do")
	@ResponseBody
	public UserVO login(String id, String pwd) {
		
		UserVO user = user_dao.selectOne(id, pwd);
		System.out.println(user.getId());
		
		if(user == null) {
			System.out.println("널");
			return user;
		}
		System.out.println("아이디 : " + user.getId());
//		if(!user.getPwd().equals(pwd)) {
//			return user;
//		}
		
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		
		return user;
		
	}
	
	
	// id찾기 페이지로 이동
	@RequestMapping("/find_id_form.do")
	public String find_id_form() {
		return Common.User.VIEW_PATH + "find_id_form.jsp";
	}
	
	// name과 email에 맞는 id 찾기
	@RequestMapping("/find_id.do")
	@ResponseBody
	public String find_id(String name, String email) {
		
		UserVO user = user_dao.find_id(name, email);
		
		String result = "";
		if(user == null) {
			result = "no_id";
			return result;
		}
		
		result = user.getId();
		return result;
		
	}
	
	// pwd찾기 페이지로 이동
//		@RequestMapping("/find_pwd_form.do")
//		public String find_pwd_form() {
//			return Common.User.VIEW_PATH + "find_pwd_form.jsp";
//		}
	
	// 패스워드 찾기 위한 아이디 확인
		@RequestMapping("/check_id.do")
		@ResponseBody
		public UserVO check_id(String id, String email) {
			
			UserVO user = user_dao.check_id(id, email);
			return user;
			
		}
		
		@Inject    //서비스를 호출하기 위해서 의존성을 주입
	    JavaMailSender mailSender;     //메일 서비스를 사용하기 위해 의존성을 주입함.
	    //MemberService memberservice; //서비스를 호출하기 위해 의존성을 주입	
		public void setMailSender(JavaMailSender mailSender) {
			this.mailSender = mailSender;
		}
		
		
	// 비밀번호 찾기 (이메일 발송)
		@RequestMapping("/find_pwd_email.do")
		public ModelAndView find_pwd_email(@RequestParam String id, @RequestParam String email, @RequestParam int l_idx, HttpServletResponse response) throws IOException {
			
			System.out.println("id : " + id);
			System.out.println("email : " + email);
			System.out.println("l_idx : " + l_idx);
			
			int random_key = new Random().nextInt(999999) + 100000;
			
			String setfrom = "pwk2380@gmail.com";
            String tomail = request.getParameter("email");    //받는 사람의 이메일
            String title = "비밀번호 찾기 인증 이메일 입니다.";    //제목
            String content =
            		
            		System.getProperty("line.separator")+
                    
                    System.getProperty("line.separator")+
                            
                    "회원님 안녕하세요! 저희 홈페이지를 찾아주셔서 감사합니다"
                    
                    +System.getProperty("line.separator")+
                    
                    System.getProperty("line.separator")+
            
                    "비밀번호 찾기 인증번호는 " + random_key + " 입니다. "
                    
                    +System.getProperty("line.separator")+
                    
                    System.getProperty("line.separator")+
                    
                    "받으신 인증번호를 홈페이지에 입력해 주시면 다음으로 넘어갑니다."; // 내용
            
            try {
 
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
 
                messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
                messageHelper.setTo(tomail); // 받는사람 이메일
                messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
                messageHelper.setText(content); // 메일 내용
                
                mailSender.send(message);
        
            } catch (Exception e) {
                System.out.println(e);
            }
			

            ModelAndView mv = new ModelAndView();    //ModelAndView로 보낼 페이지를 지정하고, 보낼 값을 지정한다.
            mv.setViewName("/WEB-INF/views/user/pwd_auth.jsp");     //뷰의이름
            mv.addObject("random_key", random_key);
            mv.addObject("email", email);
            mv.addObject("l_idx", l_idx);
            
            System.out.println("mv : " + mv);
 
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out_email = response.getWriter();
            out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
            out_email.flush();
            
            
            return mv;
		}
		
	// 비밀번호 찾기 (인증번호 입력 후 넘어오는 controller)
		@RequestMapping("/pwd_auth.do")
		public ModelAndView pwd_auth(String input_key, @RequestParam String random_key, @RequestParam String email, @RequestParam int l_idx, HttpServletResponse response) throws IOException{
        
        System.out.println("마지막 input_key : " + input_key);
        
        System.out.println("마지막 random_key  : " + random_key);
        
        ModelAndView mv = new ModelAndView();
        
        //mv.setViewName("/WEB-INF/views/user/change_pwd.jsp");
        //mv.addObject("email", email);
        
        if (input_key.equals(random_key)) {
            
            //인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 비밀번호 변경창으로 이동시킨다
        
            mv.setViewName("/WEB-INF/views/user/change_pwd.jsp");
            
            mv.addObject("email", email);
            mv.addObject("l_idx", l_idx);
            
            //만약 인증번호가 같다면 이메일을 비밀번호 변경 페이지로 넘기고, 활용할 수 있도록 한다.
            
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out_equals = response.getWriter();
            out_equals.println("<script>alert('인증번호가 일치하였습니다. 비밀번호 변경창으로 이동합니다.');</script>");
            out_equals.flush();
    
            return mv;
            
            
        }
//        else if (input_key != random_key) {
//            
//            
//            ModelAndView mv2 = new ModelAndView(); 
//            
//            mv2.setViewName("/WEB-INF/views/user/find_pwd_form.jsp");
//            
//            response.setContentType("text/html; charset=UTF-8");
//            PrintWriter out_equals = response.getWriter();
//            out_equals.println("<script>alert('인증번호가 일치하지않습니다. 인증번호를 다시 입력해주세요.'); history.go(-1);</script>");
//            out_equals.flush();
//            
//            return mv2;
//            
//        }    
    
        return mv;
        
    }
		
	// 비밀번호 찾기 (비밀번호 재설정) & 회원정보
		@RequestMapping("/change_pwd.do")
		public String change_pwd(UserVO vo, HttpServletResponse response) throws IOException {
			
			System.out.println(vo.getL_idx());
			
			int res = user_dao.change_pwd(vo);
			
			if(res == 0) {
				response.setContentType("text/html; charset=UTF-8");
		        PrintWriter out_equals = response.getWriter();
		        out_equals.println("<script>alert('비밀번호가 변경이 실패했습니다.');</script>");
		        out_equals.flush();
				
				return Common.User.VIEW_PATH + "login_form.jsp";
			}else {
				response.setContentType("text/html; charset=UTF-8");
		        PrintWriter out_equals = response.getWriter();
		        out_equals.println("<script>alert('비밀번호가 성공적으로 변경 되었습니다.');</script>");
		        out_equals.flush();
				
		        HttpSession session = request.getSession();
				session.setAttribute("user", vo);
		        
				return Common.User.VIEW_PATH + "login_form.jsp";
			}
			
		}
	
	
	// 마이페이지로 이동
		@RequestMapping("/mypage.do")
		public String myPage(Model model, int l_idx) {
			
			UserVO user = user_dao.selectOne(l_idx);
			System.out.println(user.getId());
			System.out.println(user.getL_idx());
			
			model.addAttribute("user", user);
			
			return Common.User.VIEW_PATH + "mypage.jsp";
		}
		
	// 로그아웃
		@RequestMapping("/logout.do")
		public String logout() {
			HttpSession session = request.getSession();
			session.removeAttribute("user");
			
			return "redirect:home.do";
			
		}
		
	// 수정하려는 회원정보 가져오기 
		@RequestMapping("/change_info_form.do")
		public String change_info_form(Model model, UserVO vo) {	

			model.addAttribute("user", vo);
			
			return Common.User.VIEW_PATH + "change_info_form.jsp";
			
		}
		
	// 회원정보 수정하기
		@RequestMapping("/change_user_info.do")
		@ResponseBody
		public UserVO change_user_info(UserVO vo) throws IOException {
			
			System.out.println(vo.getAddr());
			
			System.out.println("addr : " + vo.getAddr());
			
			int res = user_dao.change_user_info(vo);
			if(res == 0) {
				return null;
			}
			
			vo = user_dao.call_changed_info(vo.getL_idx());
			System.out.println("컨트롤러");
			System.out.println(vo.getId());
			System.out.println(vo.getName());
			System.out.println(vo.getPostcode());
			System.out.println(vo.getAddr());
			System.out.println(vo.getD_addr());
			
			HttpSession session = request.getSession();
			session.setAttribute("user", vo);
			
//			response.setContentType("text/html; charset=UTF-8");
//	        PrintWriter out_equals = response.getWriter();
//	        out_equals.println("<script>alert('회원 정보가 성공적으로 변경되었습니다.');</script>");
//	        out_equals.flush();
			System.out.println();
			System.out.println("컨트롤러2");
			System.out.println(vo.getId());
			System.out.println(vo.getName());
			System.out.println(vo.getPostcode());
			System.out.println(vo.getAddr());
			System.out.println(vo.getD_addr());
			return vo;
			
		}
		
	// 회원 탈퇴 (비밀번호 확인)
		@RequestMapping("/confirm_pwd.do")
		public String confirm_pwd(UserVO vo) {
			
			System.out.println(vo.getId());
			System.out.println(vo.getL_idx());
			System.out.println(vo.getPwd());
			return Common.User.VIEW_PATH + "confirm_pwd.jsp";
		}
	
	// 회원 탈퇴 (회원정보 삭제)
		@RequestMapping("/delete_user.do")
		@ResponseBody
		public String delete(int l_idx, String input_pwd) {
			
			int res = user_dao.delete(l_idx, input_pwd);

			String result = "fail";
			if(res == 0) {
				return result;				
			}
			
			result = "success";
	
			HttpSession session = request.getSession();
			session.removeAttribute("user");
			return result;
		}
	
		//회원 예약 정보 조회 
		   @RequestMapping("/selectticket.do")
		   @ResponseBody
		   public List<TicketVO> selectTicket(String id){
		      List<TicketVO> list= null;
		      list = ticket_dao.selectTicket(id);
		      return list;
		   }
	
	// 홈
		   @RequestMapping(value = {"/", "/home.do"})
		   public String home() {
			   
			   return Common.VIEW_PATH + "home.jsp";
		   }
		   
	
	
	

}