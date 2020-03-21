<%@page import="reply.ReplyBean"%>
<%@page import="reply.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String strNum = request.getParameter("num");
	int num = Integer.parseInt(strNum);
	String strLev = request.getParameter("lev");
	int lev = Integer.parseInt(strLev);
	
	String passwd = request.getParameter("passwd");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	ReplyBean rBean = new ReplyBean();
	rBean.setPasswd(passwd);
	rBean.setSubject(subject);
	rBean.setContent(content);
	
	
	ReplyDAO rDao = new ReplyDAO();
	
	int result = rDao.replyReWrite(num , lev , rBean);
	if(result == 1){
%>	
		<script>
			window.alert("답글 수정 성공");
			location.href="board.jsp";
		</script>
<%		
	}
%>