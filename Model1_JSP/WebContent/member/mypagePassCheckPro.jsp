<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String email = (String)session.getAttribute("email");
	String passwd = request.getParameter("passwd");
	
	MemberDAO mDao1 = new MemberDAO();
	MemberBean mBean1 = new MemberBean();
	
	mBean1.setEmail(email);
	mBean1.setPasswd(passwd);
	
	boolean result = mDao1.mypagePassChk(mBean1);

	if(result == true){
		MemberDAO mDao2 = new MemberDAO();
		MemberBean mBean2 = mDao2.mypageMemberInfo(mBean1);
		request.setAttribute("MemberBean", mBean2);
		pageContext.forward("mypageInfo.jsp");
	}else{
%>
		<script>
			window.alert("인증실패");
			location.href="mypagePassCheck.jsp";
		</script>
<%		
	}
%>