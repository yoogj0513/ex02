<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>
</head>
<body>
	<div id="temp1"></div>
	<script>
		var source = "<h1>{{title}}</h1><p>{{name}}</p>"; //틀
		var data = {title:"My Title", name:"My Name"};
		var template = Handlebars.compile(source); //function이 return
		
		var text = template(data); //json데이터가 들어간  tag text return
		$("#temp1").html(text);
	</script>
	
	<hr />
	<div id="temp2"></div>
	<script>
		var s2 = "<h1>{{hobby1}}</h1><h2>{{hobby2}}</h2><h3>{{hobby3}}</h3>";
		var d2 = {"hobby1":"넷플릭스", "hobby2":"닌텐도게임", "hobby3":"유튜브보기"};
		var func = Handlebars.compile(s2);
		$("#temp2").html(func(d2));
	</script>
	
	<hr />
	<div id="temp3"></div>
	<script>
		var d3 = {"hobby1":"넷플릭스222", "hobby2":"닌텐도게임222", "hobby3":"유튜브보기222"};
		$("#temp3").html(func(d3));
	</script>

	<!-- type="text/x-handlebars-tamplate" : 템플릿 메소드. 오타나면 안됨 -->
	<!-- 틀을 갖추는 스트립트 -->
	
	<hr />
	<div id="temp4"></div>
	
	<script id="template" type="text/x-handlebars-tamplate">
		<span>{{name}}</span>
		<div>
			<span>{{userid}}</span><br>
			<span>{{addr}}</span><br>
			<span>{{email}}</span>
		</div>
	</script>
	<script>
		var source = $("#template").html();// "<h1>{{hobby1}}</h1><h2>{{hobby2}}</h2><h3>{{hobby3}}</h3>" 이 작업을 한것과 같은 것
		var data = {name:"이름", userid:"pretty", addr:"대구 서구", email:"test@test.com"};
		var func = Handlebars.compile(source);
		$("#temp4").html(func(data));
	</script>
</body>
</html>