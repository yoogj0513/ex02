<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

</head>
<body>
	<p>test : ${test }</p>
	<p>file : ${file }</p>
	<%-- 외부 데이터를 들고오는 것이기 때문에 서버에서 전달할 수 없음 직접 전달할 수 있도록 데이터를 까서 전달  --%>
	<%-- 외부를 쓰는 이유는 서버가 사라지면 서버에 올라간 이미지 데이터도 모든 같이 사라짐. 사이트 유저가 있다면 유저 이미지가 날라가버리는 것  --%>
	<%-- 이미지 데이터 저장하는  곳은 외부!! 서버 내부에 upload하지 않는다. --%>
	<%-- displayFile?filename= : a태그처럼 요청하는 것 --%>
	<p><img src="displayFile?filename=${file }" id="img"/></p>
	<div id="box"></div>
	<script>
		var file = "${file}";
		var s = file.indexOf("s_");
		var dir = file.substring(0, s);
		var fileName = file.substring(s+2, file.length);
		var filePath = dir + fileName;
		
		$("#img").click(function() {
			console.log(filePath);
			var $img = $("<img>").attr("src", "displayFile?filename="+filePath);
			$("#box").append($img);
		})
	</script>
</body>
</html>