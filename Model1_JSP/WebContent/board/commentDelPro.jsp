<%@page import="board.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
    
	String loginEmail = (String)session.getAttribute("email");
	int originNum = Integer.parseInt(request.getParameter("originNum"));
	int reg_seq = Integer.parseInt(request.getParameter("reg_seq"));
	
 	CommentDAO cDao = new CommentDAO();
	
// 로그인 한 유저의 이메일과 댓글 삭제를 누른 게시판 번호 , 댓글 작성 순서를 조건으로 검색하여
// 로그인 한 유저의 이메일과 댓글 작성한 이메일이 일치하는지 검사
	int OwnChkResult = cDao.commentOwnCheck(loginEmail , originNum , reg_seq); 
	if(OwnChkResult == 1){
		int commentDelResult = cDao.commentDel(originNum , reg_seq);
		if(commentDelResult == 1){
%>
			<script>
				window.alert("댓글 삭제 성공");
				location.href="boardIntoPro.jsp?num=<%= originNum %>";
			</script>
<%			
		}
		else{
%>
			<script>
				window.alert("댓글 삭제 실패");
				location.href="boardIntoPro.jsp?num=<%= originNum %>";
			</script>
<%			
		}
	}
	else{
%>
		<script>
			window.alert("자신이 작성한 댓글이 아닙니다");
			history.back();
		</script>
<%		
	}
%>
