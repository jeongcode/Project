<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//	session.invalidate();
	session.removeAttribute("email");
	session.removeAttribute("nickname");
	session.removeAttribute("read");
%>
<script>
	window.alert("로그 아웃");	
	location.href="../index.jsp";
</script>
	