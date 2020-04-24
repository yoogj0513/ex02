package com.yi.ex02;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yi.domain.ReplyVO;
import com.yi.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ReplyDAOTest {
	@Autowired
	private ReplyDAO dao;
	
	@Test
	public void testInsert() throws Exception {
		ReplyVO vo = new ReplyVO();
		vo.setBno(4098);
		vo.setReplyer("user01");
		vo.setReplytext("댓글을 test해봅니다.");
		dao.insert(vo);
	}
	
	@Test
	public void testList() throws Exception {
		dao.list(4098);
	}
	
	@Test
	public void testUpdate() throws Exception {
		ReplyVO vo = new ReplyVO();
		vo.setRno(3);
		vo.setReplytext("댓글을 수정합니다.");
		dao.update(vo);
	}
	
	@Test
	public void testDelete() throws Exception {
		dao.delete(2);
	}
}
