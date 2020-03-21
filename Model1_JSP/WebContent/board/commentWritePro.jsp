<%@page import="board.CommentDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("originNum"));

// 로그인시에 session에 올려놓은 email과 nickname을 사용하여 댓글 작성자 구분
	String commentWriterEmail = (String)session.getAttribute("email");
	String commentWriterNickname = (String)session.getAttribute("nickname");
	String commentContent = request.getParameter("commentContent");
	
	CommentBean cBean = new CommentBean();
	
	cBean.setNum(num);
	cBean.setEmail(commentWriterEmail);
	cBean.setNickname(commentWriterNickname);
	cBean.setContent(commentContent);
	cBean.setDate(new Timestamp(System.currentTimeMillis()));
	
	CommentDAO cDao = new CommentDAO();

	int result = cDao.commentWrite(cBean);
	if(result == 1){
%>	
		<script>
			window.alert("댓글 정상 입력");
			location.href="boardIntoPro.jsp?num=<%=num%>";
		</script>
<%		
	}else{
%>
		<script>
			window.alert("댓글 입력 실패");
			history.back();
		</script>
<%
	}
%>