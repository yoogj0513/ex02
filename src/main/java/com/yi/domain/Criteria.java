package com.yi.domain;

public class Criteria {
	private int page; // 현재 페이지 번호
	private int perPageNum; // 한 페이지 display 될 게시글의 갯수

	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
	
	public int getPageStart() { //db 시작 게시글 index번호 구하는 함수
		return (this.page - 1) * this.perPageNum;
	}

	@Override
	public String toString() {
		return String.format("Criteria [page=%s, perPageNum=%s]", page, perPageNum);
	}

}
