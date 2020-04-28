<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#dropBox {
		width: 400px;
		height: 300px;
		border: 1px solid gray;
		margin-top: 30px;
	}
	
	#dropBox img {
		height: 100px;
	}
	
	.imgBox {
		float: left;
		position: relative;
		margin: 5px;
	}
	
	.imgBox button {
		position: absolute;
		top: 0;
		right: 0;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
</head>
<body>
	<form id="f1">
		<input type="text" name="test"/>
		<input type="submit" value="전송" />
	</form>
	<div id="dropBox"></div>
	
	<script>
		// 파일 업로드 시에 반드시 사용함
		var formData = new FormData(); //서버로 보낼 데이터를 담음
	
		$("#dropBox").on("dragenter dragover", function(e){
			e.preventDefault(); //이벤트 막기, 링크 막기
		})
		
		$("#dropBox").on("drop", function(e){
			e.preventDefault(); // 이벤트 막기, 링크 막기
			var files = e.originalEvent.dataTransfer.files; 
			var file = files[0]; //file 1개만
			console.log(file);
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.addEventListener("load", function(){
				var $img = $("<img>").attr("src", reader.result);
				$("#dropBox").append($img);
			})
			
			formData.append("files", file); //key : files에 file data가 추가됨
		})
		
		$("#f1").submit(function(e){
			e.preventDefault();
			
			formData.append("test", $("input[name='test']").val());

			$.ajax({
				url : "drag",
				type : "post",
				data : formData, //image, test
				processData: false, //file을 같이 서버로 보낼시에 셋팅, processData : false / contentType:false
				contentType : false,
				success:function(res){
					console.log(res);
					if(res.length > 0) {
						alert("업로드 완료");
						formData = new FormData(); // 남은 데이터 날리기
						$("#dropBox").empty();
						$(res).each(function(i, obj){
							var $div = $("<div>").addClass("imgBox");
							var $img = $("<img>").attr("src", "displayFile?filename="+obj);//서버에 바이트 내용을 다시 전송 요청
							var $btn = $("<button>").addClass("del").attr("type", "button").text("X").attr("data-imgfile", obj);
							$div.append($img).append($btn);
							$("#dropBox").append($div);
						})
					}
				}
			})
		})
		
		$(document).on("click", ".del", function(){
			var delDiv = $(this).parent();
			var delFile = $(this).attr("data-imgfile");
			console.log(delFile);
			$.ajax({
				url : "deleteFile",
				type : "get",
				data : {filename : delFile},
				success:function(res){
					console.log(res);
					if(res == "success"){
						alert("삭제 완료");
						delDiv.remove();
					}
				}
			})
		})
	</script>
</body>
</html>