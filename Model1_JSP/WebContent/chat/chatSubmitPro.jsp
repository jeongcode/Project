<%@page import="chat.ChatDAO"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	String fromID = request.getParameter("fromID");
	String toID = request.getParameter("toID");
	String content = request.getParameter("content");


	fromID = URLDecoder.decode(fromID, "UTF-8");
	toID = URLDecoder.decode(toID, "UTF-8");
	content = URLDecoder.decode(content, "UTF-8");
	ChatDAO cDao = new ChatDAO();
	int result = cDao.chatSubmit(content, fromID, toID);
	System.out.println(result);
	response.getWriter().write(result);
%>