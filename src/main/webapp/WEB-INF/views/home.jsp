<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ page session="false" %> session을 사용하지 않겠다는 것--%>
<html>
<head>
	<title>Home</title>
</head>
<body>

<c:if test="${Auth != null }">
	<h1>${Auth }님 반갑습니다. <a href="${pageContext.request.contextPath }/logout">[로그아웃]</a></h1>
</c:if>
<c:if test="${Auth == null }">
	<h1>로그인을 해주세요. <a href="${pageContext.request.contextPath }/login">[로그인]</a></h1>
</c:if>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
