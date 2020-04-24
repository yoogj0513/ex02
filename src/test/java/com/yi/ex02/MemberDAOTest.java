package com.yi.ex02;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yi.domain.MemberVO;
import com.yi.persistence.MemberDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MemberDAOTest {
	
	@Autowired
	private MemberDAO dao;
	
	@Test
	public void testDao() {
		System.out.println(dao);
	}
	
	@Test
	public void testCreateMember() throws Exception {
		MemberVO vo = new MemberVO();
		vo.setUserid("yoogj0513");
		vo.setUserpw("123");
		vo.setUsername("경진");
		vo.setEmail("yoogj0513@naver.com");
		dao.createMember(vo);
		System.out.println("create : " + vo);
	}
	
	//@Test
	public void testReadMember() throws Exception {
		String userid = "yoogj0513";
		MemberVO item = dao.readMember(userid);
		System.out.println("read : "+item);
	}
	
	@Test
	public void teatList() throws Exception {
		List<MemberVO> list = dao.list();
		for(MemberVO m : list) {
			System.out.println("list : "+m);
		}
	}
	
	//@Test
	public void testUpdate() throws Exception {
		MemberVO vo = new MemberVO();
		vo.setUserpw("123123");
		vo.setUsername("유");
		vo.setEmail("yoo@test.com");
		vo.setUserid("yoogj0513");
		dao.updateMember(vo);
		System.out.println("update: "+vo);
	}
	
	//@Test
	public void testRemove() throws Exception {
		String userid = "yoogj0513";
		int res = dao.removeMember(userid);
		System.out.println("remove : " + res);
	}
}
