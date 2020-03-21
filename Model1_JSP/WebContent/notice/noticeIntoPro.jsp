<%@page import="notice.NoticeDAO"%>
<%@page import="notice.NoticeBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	NoticeDAO nDao = new NoticeDAO();

	int result = nDao.noticeIncreaseReadcount(num);
	if(result == 1){
		NoticeBean nBean = nDao.noticeInto(num);
		
 		request.setAttribute("nBean",nBean);
		pageContext.forward("noticeInto.jsp"); 
	}
	else{
%>
		<script>
			window.alert("공지사항 글 접근 실패");
			location.href("notice.jsp");
		</script>
<%		
	}
%>