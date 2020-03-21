<%@page import="member.MemberDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userEmail = (String)session.getAttribute("email");
	
	MemberDAO mDao = new MemberDAO();
	
	int result = mDao.mypageMemberDel(userEmail);
	
	if(result == 0){
%>
	<script>
		window.alert("삭제에 실패 하였습니다. 재로그인 후 시도하여주세요");
		location.href="../index.jsp";
	</script>
<%
	}
	else{
%>
	<script>
		location.href="logoutPro.jsp";
	</script>
<%
	}
%>