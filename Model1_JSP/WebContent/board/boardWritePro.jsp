<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 	request.setCharacterEncoding("UTF-8");	%>
	<jsp:useBean id="bBean" class="board.BoardBean"/>
	<jsp:setProperty property="*" name="bBean"/>
 
<%
	bBean.setIp(request.getRemoteAddr());
	bBean.setDate(new Timestamp(System.currentTimeMillis()));
	
	BoardDAO bDao = new BoardDAO();
	
	int result = bDao.boardWrite(bBean);
	if(result == 1){
%>
	<script>
		window.alert("글쓰기 완료");
		location.href="board.jsp";
	</script>
<% 		
	}
	else {
%>
	<script>
		window.alert("글쓰기 실패");
		location.href="boardWrite.jsp";
	</script>
<%
	}
%>
