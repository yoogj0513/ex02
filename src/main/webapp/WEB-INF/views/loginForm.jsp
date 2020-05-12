<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.error {
		color: red;
		font-size: 14px;
	}
</style>
</head>
<body>
	<form action="login" method="post">
		<fieldset>
			<p>
				<label>아이디</label>
				<input type="text" name="userid"/>
			</p>
			<p>
				<label>패스워드</label>
				<input type="password" name="userpw" />
			</p>
			<p>
				<input type="submit" value="로그인" />
			</p>
			<c:if test="${error != null }">
				<p class="error">${error }</p>
			</c:if>
		</fieldset>
	</form>
	
	<%
		System.out.println("---------------loginForm.jsp");
	%>
</body>
</html>