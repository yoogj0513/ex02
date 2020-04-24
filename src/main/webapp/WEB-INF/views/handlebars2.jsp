<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
</head>
<body>
	<ul id="list">
		
	</ul>
	
	<!-- {{#each.}} ... {{/each}} : 들어오는 데이터가 배열일 때 사용. each문을 돌리는 것 -->
	<!-- dateHelper는 id. 어떤 이름이든 설정 가능 -->
	<script id="template" type="text/x-handlebars-template">
		{{#each.}}
		<li class="replies">
			<div>
				<p>{{rno}}</p>
				<p>{{replyer}}</p>
				<p>{{replytext}}</p>
				<p>{{dateHelper replydate}}</p>
			</div>
		</li>
		{{/each}}
	</script>
	<script>
		Handlebars.registerHelper("dateHelper", function(value){
			var d = new Date(value);
			var year = d.getFullYear();
			var month = d.getMonth()+1;
			var day = d.getDate();
			var week = d.getDay();
			var weeks = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
			
			
			return year + "/" + month + "/" + day + " " + weeks[week];
			// dateHelper가 위치한 곳에 return 값이 들어감
		})
	
		var source = $("#template").html();
		var data = [
				{"rno":1, "replyer":"홍길동1", "replytext":"1번 댓글입니다.....", "replydate":new Date(2019,2,11)},
				{"rno":2, "replyer":"홍길동2", "replytext":"2번 댓글입니다.....", "replydate":new Date(2020,0,1)},
				{"rno":3, "replyer":"홍길동3", "replytext":"3번 댓글입니다.....", "replydate":new Date(2020,1,1)},
				{"rno":4, "replyer":"홍길동4", "replytext":"4번 댓글입니다.....", "replydate":new Date(2020,2,1)},
				{"rno":5, "replyer":"홍길동5", "replytext":"5번 댓글입니다.....", "replydate":new Date(2020,3,1)}
		];
		
		var func = Handlebars.compile(source);
		$("#list").html(func(data));
	</script>
</body>
</html>