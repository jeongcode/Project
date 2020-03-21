<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("originNum"));

	BoardDAO bDao = new BoardDAO();
	
	int result = bDao.boardDelete(num);
	if(result != 1){
%>
		<script>
			window.alert("삭제 실패");
			location.href="board.jsp";
		</script>
<%
	}
	else{
%>
		<script>
			window.alert("삭제 성공");
			location.href="board.jsp";
		</script>
<%	
	}
%>