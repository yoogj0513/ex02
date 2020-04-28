<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 파일 업로드시 enctype 작성해서 값을 전송 시켜야 함 -->
	<form action="inUp" method="post" enctype="multipart/form-data">
		<input type="text" name="test" placeholder="작성자"/>
		<input type="file" name="file"/>
		<input type="submit" value="제출" />
	</form>
</body>
</html>