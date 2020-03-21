<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	MemberDAO mDao = new MemberDAO();
	String email = request.getParameter("email");
	String flag = "";
	if(email == "" || email == null){
		flag = "NO";
		out.print(flag);
	}
	int result = mDao.emailDuplCheck(email);
	if(result == 0){
		flag = "OK";
		out.print(flag);
	}
	else{
		flag = "NO";
		out.print(flag);
	}
%>
