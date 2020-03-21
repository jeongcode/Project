<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mBean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mBean"/> 
<%


	MemberDAO mDao = new MemberDAO();
	System.out.println("mypageModInfoPro.jsp  : " + mBean.getEmail());
	
	int result = mDao.mypageMemberMod(mBean);
	if(result == 0){
%>		
	<script>
		window.alert("수정 실패");
		history.back();
	</script>
<% 		
	}
	else {
		session.setAttribute("nickname", mBean.getNickname());
%>
	<script>
		window.alert("수정 완료");
		location.href="../index.jsp";
	</script>
<% 		
	}
%>
