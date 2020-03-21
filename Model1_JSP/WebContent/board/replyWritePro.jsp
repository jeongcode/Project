<%@page import="reply.ReplyDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="rBean" class="reply.ReplyBean"/>
<jsp:setProperty property="*" name="rBean"/>
<%
// replyWrite에서 받아오는 값 -> email , nickname , subject , content , originNum 

rBean.setIp(request.getRemoteAddr());
rBean.setDate(new Timestamp(System.currentTimeMillis()));
int originNum = Integer.parseInt(request.getParameter("originNum"));

ReplyDAO rDao = new ReplyDAO();
int levCheckResult = rDao.replyRegLevCheck(originNum);
int writeResult = rDao.replyWrite(rBean, originNum, levCheckResult);
if(writeResult == 1){
%>
	<script>
		alert("답글 작성 완료");
		location.href="board.jsp";
	</script>
<%	
}
else{
%>
	<script>
		alert("답글 작성 실패");
		location.href="boardIntoPro.jsp?num=<%= originNum %>"
	</script>
<%
}
%>