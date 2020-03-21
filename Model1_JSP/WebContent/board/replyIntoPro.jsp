<%@page import="reply.ReplyBean"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String numStr = request.getParameter("num");
	int num = Integer.parseInt(numStr);
	int lev = Integer.parseInt(request.getParameter("lev"));
	
	ReplyDAO rDao = new ReplyDAO();
	int readcountResult = rDao.replyIncreaseReadcount(num,lev);
	if(readcountResult == 1){
		ReplyBean rBean = rDao.replyInto(num , lev);
		request.setAttribute("rBean", rBean);
		pageContext.forward("replyInto.jsp");
	}
	else{
%>
		<script>
			windowl.alert("조회수 증가 실패");
			location.href="board.jsp";
		</script>
<%
	}
%>