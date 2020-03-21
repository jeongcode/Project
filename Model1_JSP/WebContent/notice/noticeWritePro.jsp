<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="nBean" class="notice.NoticeBean"/>
<jsp:setProperty property="*" name="nBean"/>
<%
	Timestamp time = new Timestamp(System.currentTimeMillis());
	
	nBean.setDate(time);
	nBean.setIp(request.getRemoteAddr());
	
	NoticeDAO nDao = new NoticeDAO();
	
	int result = nDao.noticeWrite(nBean);
	if(result == 1){
%>
	<script>
		window.alert("공지사항 글쓰기 완료");
		location.href="notice.jsp";
	</script>
<%
	}
	else{
%>
	<script>
		window.alert("공지사항 글쓰기 실패");
		location.href="notice.jsp";
	</script>
<%		
	}
%>