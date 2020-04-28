<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>작성자 : ${test }</p>
	<p>fileList</p>
	<c:forEach var="file" items="${fileList }">
		<div>name : ${file}</div>
		<div>
			<img src="${pageContext.request.contextPath }/resources/upload/${file}"/>
		</div>
	</c:forEach>

	
</body>
</html>