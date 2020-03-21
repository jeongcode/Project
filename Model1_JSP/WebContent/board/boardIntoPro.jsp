<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String nickname = (String)session.getAttribute("nickname");
	String email = (String)session.getAttribute("email");
	if(nickname == null || email == null){
%>
	<script>
		location.href="../member/login.jsp";
	</script>
<%
	}
%>
<%
	int num = Integer.parseInt(request.getParameter("num"));

	BoardDAO bDao = new BoardDAO();
	BoardBean bBean = new BoardBean();
	
	int result = bDao.boardIncreaseReadcount(num);
	if(result == 1){

		bBean = bDao.boardInto(num);
 	 	request.setAttribute("origin", bBean);
		pageContext.forward("boardInto.jsp");		
	}
%>
