<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	label {
		width: 100px;
		float: left;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
<script id="template" type="text/x-handlebars-tamplate">
	{{#each.}}
		<tr>
			<td>{{userid}}</td>
			<td>{{username}}</td>
			<td>{{userpw}}</td>
			<td>{{email}}</td>
		</tr>
	{{/each}}
</script>
<script>

	function getPageList() {
		$.ajax({
			url: "member/list",
			type: "get",
			datatype: "json",
			success: function(res){
				console.log("res");
				console.log(res);
				$("#list").empty();
				var source = $("#template").html();
				var func = Handlebars.compile(source);
				$("#list").append(func(res));
				console.log($("#list"))
			}
		})
	}
	
	$(function(){
		$("#add").click(function(){
			var userid = $("input[name='id']").val();
			var username = $("input[name='name']").val();
			var userpw = $("input[name='password']").val();
			var email = $("input[name='email']").val();
			
			var json = JSON.stringify({userid : userid, username: username, 
										userpw: userpw, email: email});
			
			$.ajax({
				url:"member/create",
				type:"post",
				headers:{"Content-Type":"application/json"},
				data:json,
				dataType: "text",
				success: function(res){
					console.log(res);
					if(res == "SUCCESS") {
						alert("추가되었습니다");
						getPageList();
					}
				}
			})
		})
		
		$("#listView").click(function(){
			getPageList();
		})
	})
</script>
</head>
<body>
	<div class="wrap">
		<div class="formWrap">
			<form action="member" id="f1" method="post">
				<p>
					<label>아이디</label>
					<input type="text" name="id"/>
				</p>
				<p>
					<label>이름</label>
					<input type="text" name="name"/>
				</p>
				<p>
					<label>비밀번호</label>
					<input type="password" name="password"/>
				</p>
				<p>
					<label>이메일</label>
					<input type="text" name="email" />
				</p>
				<p>
					<input id="add" type="button" value="추가"/>
					<input id="listView" type="button" value="리스트 가져오기" />
				</p>
			</form>
			<table id="list"></table>
		</div>
	</div>
</body>
</html>