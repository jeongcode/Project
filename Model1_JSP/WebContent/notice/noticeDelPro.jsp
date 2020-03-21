<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String strnum = request.getParameter("num");
	int num = Integer.parseInt(strnum);
	NoticeDAO nDao = new NoticeDAO();
	
	int result = nDao.noticeDel(num);
	if(result == 1){
%>
		<script>
			window.alert("삭제 성공");
			location.href="notice.jsp";
		</script>
<%
	}
	else{
%>
		<script>
			window.alert("삭제 실패");
			history.back();
		</script>
<%
	}
%>