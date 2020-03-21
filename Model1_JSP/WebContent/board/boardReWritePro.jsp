<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	BoardDAO bDao = new BoardDAO();

// 게시판 수정시 이메일과 별명은 수정 하지 못하게 만들어 놓아서 origin이라고 표시

	int originBoardNum = Integer.parseInt(request.getParameter("originNum"));
	String originEmail = request.getParameter("email");	
	String originNickname = request.getParameter("nickname");
	String reWritePasswd = request.getParameter("passwd");
	String reWriteSubject = request.getParameter("subject");	
	String reWriteContent = request.getParameter("content");
	
	BoardBean bBean = new BoardBean();
	
	bBean.setNum(originBoardNum);
	bBean.setEmail(originEmail);
	bBean.setNickname(originNickname);	
	bBean.setPasswd(reWritePasswd);
	bBean.setSubject(reWriteSubject);
	bBean.setContent(reWriteContent);
	bBean.setIp(request.getRemoteAddr());
	bBean.setDate(new Timestamp(System.currentTimeMillis()));
	
	int result = bDao.boardReWrite(bBean);
	if(result == 1){
%>
			<script>
				window.alert("수정 성공");
				location.href="board.jsp";
			</script>
<% 
	}
	else{
%>
		<script>
			window.alert("수정 실패");
			location.href="boardReWrite.jsp";
		</script>
<%
	}
	
%>