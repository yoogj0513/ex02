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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script id="template" type="text/x-handlebars-tamplate">
	{{#each list}}
		<tr>
			<td>{{userid}}</td>
			<td>{{username}}</td>
			<td>{{userpw}}</td>
			<td>{{email}}</td>
		</tr>
	{{/each}}
</script>
<script>
	$(function(){
		
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
			<table></table>
		</div>
	</div>
</body>
</html>