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
	<form action="outMultiUp" method="post" enctype="multipart/form-data">
		<input type="text" name="test" placeholder="작성자"/>
		<input type="file" name="files" id="file" multiple="multiple"/>
		<input type="submit" value="제출" />
	</form>
	<div id="dropBox"></div>
	<script>
		$("#file").change(function(){
			var file = $(this)[0].files; // $(this)[0] : javascript객체
			
			$(file).each(function(i, obj) {
				var reader = new FileReader(); //javascript 객체
				reader.readAsDataURL(file[i]);
				reader.onload = function(e){
					var $img = $("<img>").attr("src", e.target.result); //e.target.result == reader.result -> 똑같은 값이 가져옴
					$("#dropBox").append($img);
				} 
			});
		})
	</script>
</body>
</html>