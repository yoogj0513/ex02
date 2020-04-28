package com.yi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.yi.domain.MemberVO;
import com.yi.service.MemberService;

@RestController
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private MemberService service;
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> createMember(@RequestBody MemberVO vo){
		ResponseEntity<String> entity = null;
		try {
			service.createMember(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("FAIL", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
