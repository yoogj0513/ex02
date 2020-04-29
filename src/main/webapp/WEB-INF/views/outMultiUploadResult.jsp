<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<p>작성자 : ${test }</p>
	<p>fileList</p>
	<c:forEach var="file" items="${fileList }">
		<div>name : ${file}</div>
		<div>
			<img src="displayFile?filename=${file }" class="img" data-img="${file }"/><br>
		</div>
	</c:forEach>
	<script>
		$(".img").click(function() {
			var file = $(this).attr("data-img");
			var s = file.indexOf("s_");
			var dir = file.substring(0, s);
			var fileName = file.substring(s+2, file.length);
			var filePath = dir + fileName;
			
			console.log(filePath);
			var $img = $("<img>").attr("src", "displayFile?filename="+filePath);
			$(this).parent().append($img);
		})
	</script>
</body>
</html>