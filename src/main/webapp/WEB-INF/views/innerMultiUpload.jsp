<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="inMultiUp" method="post" enctype="multipart/form-data">
		<input type="text" name="test" placeholder="작성자"/>
		<input type="file" name="files" multiple="multiple"/><!-- multiple="multiple" : 이미지 여러개 추가 가능 --> 
		<input type="submit" value="제출" />
	</form>
</body>
</html>