<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String strNum = request.getParameter("num");
	int num = Integer.parseInt(strNum);
	String strLev = request.getParameter("lev");
	int lev = Integer.parseInt(strLev);
	System.out.println("num = " + num + " lev = " + lev);
	ReplyDAO rDao = new ReplyDAO();
	int delResult = rDao.replyDel(num , lev);
	if(delResult == 1){
%>
		<script>
			window.alert("삭제 완료");
			location.href="board.jsp";
		</script>
<%		
	}
%>