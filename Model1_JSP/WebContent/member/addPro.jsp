<%@page import="java.sql.Timestamp"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="MBean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="MBean"/>
<% 
	MemberDAO dao = new MemberDAO();
	Timestamp time = new Timestamp(System.currentTimeMillis());
	MBean.setReg_date(time);
	int check =	dao.addMember(MBean);
	
	if(check == 1){
		%>
		<script>
			window.alert("회원가입 완료");
			location.href="../index.jsp";
		</script>
		<%
	}
	else{
		%>
		<script>
			widonw.alert("회원가입 실패");
			location.href="resistration.jsp";
		</script>
		<% 
	}
%>
