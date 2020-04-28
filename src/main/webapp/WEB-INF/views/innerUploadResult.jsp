<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>writer : ${test }</p>
	<p>file name : ${file }</p>
	<div>
		<img src="${pageContext.request.contextPath }/resources/upload/${file }" alt="" />
	</div>
</body>
</html>