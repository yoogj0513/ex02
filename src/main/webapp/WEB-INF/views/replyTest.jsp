<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#list .item {
		border-bottom: 1px solid #ddd;
		padding: 5px;
		width: 400px;
		position: relative;
	}
	
	#list .item .text {
		display: block;
	}
	
	#list .item .btnWrap {
		position: absolute;
		right: 10px;
		top: 10px;
	}
	
	#pagination li {
		border: 1px solid gray;
		float: left;
		margin: 0 5px;
		list-style: none;
		padding: 2px 4px;
	}
	
	#modPopup {
		width: 300px;
		height: 100px;
		padding: 5px;
		background-color: lightgray;
		position: absolute;
		top: 30%;
		left: 20%;
		display: none;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
<script id="template" type="text/x-handlebars-tamplate">
	{{#each list}}
	<li>
		<div class="item">
			<span class="rno">{{rno}}</span> : <span class="writer">{{replyer}}</span>
			<span class="text">{{replytext}}</span>
			<div class="btnWrap">
				<button class="btnMod" data-rno="{{rno}}" data-text="{{replytext}}">수정</button>
				<button class="btnDel" data-rno="{{rno}}">삭제</button>
			</div>
		</div>
	</li>
	{{/each}}
</script>

<script>
	// 전역변수는 항상 가장 상단에 설정
	var no = 1;

	function getPageList( page ){
		var bno = $("#bno").val();
		$.ajax({
			url:"replies/"+bno+"/"+page,
			type:"get",
			datatype:"json",
			success:function(res){
				console.log(res);
				$("#list").empty();
				var source = $("#template").html();
				var func = Handlebars.compile(source);
				$("#list").append(func(res));
				
				/* $(res.list).each(function(i, obj) {
					var rno = obj.rno;
					var replyer = obj.replyer;
					var replytext = obj.replytext;
					
					var $btnMod = $("<button>").addClass("btnMod").attr("data-rno", rno).attr("data-text", replytext).text("수정");
					var $btnDel = $("<button>").addClass("btnDel").attr("data-rno", rno).text("삭제");
					var $divBtnWrap = $("<div>").addClass("btnWrap").append($btnMod).append($btnDel);
					
					var $spanRon = $("<span>").addClass("rno").text(rno);
					var $spanWriter = $("<span>").addClass("writer").text(replyer);
					var $spanText = $("<span>").addClass("text").text(replytext);
					
					var $divItem = $("<div>").addClass("item").append($spanRon).append(" : ").append($spanWriter)
											 .append($spanText).append($divBtnWrap);
			
					var $li = $("<li>").append($divItem);
					$("#list").append($li);
				}) */
				
				var startPage = res.pageMaker.startPage;
				var endPage = res.pageMaker.endPage;
				$("#pagination").empty();
				for(var i = startPage; i <= endPage; i++){
					var $li = $("<li>").append(i);
					$("#pagination").append($li);
				}
				
			}
		})
	}
	
	function closePop(){
		$(".mod-rno").text("");
		$("#mod-text").val("");
		$("#modPopup").hide();
	}

	$(function(){
		$("#btnList").click(function() {
			getPageList(1);
		})
		
		$("#btnAdd").click(function() {
			//댓글 등록
			var bno = $("#bno").val();
			var replyer = $("#replyer").val();
			var text = $("#replytext").val();
			
			//서버 주소 : /replies/
			
			// get 파라메타 형식으로 json 객체임
			//data: {"bno":bno, "replyer":replyer, "replytext":text}, 
			
			// @RequestBody 서버에서 사용시
			// 1. headers - "Content-Type" : "application/json"
			// 2. 보내는 data는 json string으로 변형해서 보내야 됨
			//    - "{bno:bno}"
			
			var json = JSON.stringify({"bno":bno, "replyer":replyer, "replytext":text}); // json객체를 json스트링으로 변환
			$.ajax({
				url: "replies/",
				type: "post", 
				headers:{"Content-Type":"application/json"}, //약속된 이름이기 때문에 오타나면 안됨
				data:json,
				dataType : "text",// String: text / 객체 : json으로 데이터 전송됨
				success:function(res){
					console.log(res);
					if(res == "SUCCESS"){
						alert("댓글이 등록되었습니다.");
						//리스트 갱신
						getPageList(1);
					}
				}
			})
		})
		
		$(document).on("click", "#pagination li", function(){
			// click했는 li태그 번호
			no = $(this).text();
			getPageList(no);
		})
		
		$(document).on("click", ".btnDel", function(){
			var rno = $(this).attr("data-rno");
			console.log(rno);
			$.ajax({
				url:"replies/"+rno,
				type: "delete",
				dataType : "text",
				success:function(res){
					console.log(res);
					if(res == "SUCCESS"){
						alert("삭제되었습나다.");						
						getPageList(no);
					}
				}
			})
		})
		
		$(document).on("click", ".btnMod", function(){
			var rno = $(this).attr("data-rno");
			var text = $(this).attr("data-text");
			
			$(".mod-rno").text(rno);
			$("#mod-text").val(text);
			
			$("#modPopup").show();
		})
		
		$("#btnModSave").click(function() {
			var rno = $(this).parent().find(".mod-rno").text();
			var text = $(this).parent().find("#mod-text").val();
			
			$.ajax({
				url:"replies/"+rno,
				type:"put",
				headers : {"Content-Type":"application/json"},
				data: JSON.stringify({"replytext" : text}),
				dataType : "text",
				success:function(res){
					console.log(res);
					if(res == "SUCCESS"){
						alert("수정되었습니다.");
						closePop();
						getPageList(no);
					}
				}
			})
		})
		
		$("#btnClose").click(function() {
			closePop();
		})
	})
</script>
</head>
<body>
	<div class="box">
		<p>
			<label>BNO</label>
			<input type="text" id="bno" value="4098"/>
		</p>
		<p>
			<label>Replyer</label>
			<input type="text" id="replyer"/>
		</p>
		<p>
			<label>Reply Text</label>
			<input type="text" id="replytext"/>
		</p>
		<p>
			<button id="btnList">List</button>
			<button id="btnAdd">Add</button>
		</p>
		
		<hr />
		
		<div id="listWrap">
			<ul id="list">
				
			</ul>
			<ul id="pagination"></ul>
		</div>
		
		<div id="modPopup">
			<div class="mod-rno">22</div>
			<div>
				<input type="text" id="mod-text" value="text"/>
			</div>
			<button id="btnModSave">수정</button>
			<button id="btnClose">닫기</button>
		</div>
	</div>
</body>
</html>