package com.yi.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yi.domain.MemberVO;
import com.yi.service.MemberService;

@Controller
public class LoginController {

	@Autowired
	private MemberService service;
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginGet() {
		System.out.println("---------------login Controller get");
		return "loginForm";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginPost(MemberVO vo, Model model, HttpSession session) throws Exception {
		
		//db에 member와 일치하는지 여부 확인
		MemberVO dbVO = service.readMember(vo.getUserid());
		if(dbVO == null) { // id에 해당하는 member가 없다.
			model.addAttribute("error", "id가 없습니다.");
			return "loginForm";
		} else if(dbVO.getUserpw().equals(vo.getUserpw()) == false) {// 비밀번호가 일치하지 않음
			model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
			return "loginForm";
		}
		
		session.setAttribute("Auth", vo.getUserid());
		return "redirect:/"; //home controller를 거쳐서 이동
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.GET) //a태그로 올때는 get
	public String logout(HttpSession session) {
		session.invalidate(); //session안의 모든 key를 제거
		//session.removeAttribute("Auth"); 특정 키만 삭제
		
		return "redirect:/";
	}
	
}
