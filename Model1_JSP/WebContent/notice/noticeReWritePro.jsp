<%@page import="java.sql.Timestamp"%>
<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="nBean" class="notice.NoticeBean"/>
<jsp:setProperty property="*" name="nBean"/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	nBean.setDate(new Timestamp(System.currentTimeMillis()));
	nBean.setIp(request.getRemoteAddr());

	NoticeDAO nDao = new NoticeDAO();
	int result = nDao.noticeReWrite(nBean);
	if(result == 1){
%>
		<script>
			alert("수정 완료");
			location.href="notice.jsp";
		</script>
<%
	}
	else {
%>
		<script>
			alert("수정 실패");
			history.back();
		</script>
<%		
	}
%>