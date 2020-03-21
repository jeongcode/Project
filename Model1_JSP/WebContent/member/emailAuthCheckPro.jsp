<%@page import="web.mail.MailSend"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MailSend ms = new MailSend();
	String useremail = request.getParameter("useremail");
	String adminAuthNum = "" ;
	String reAdminAuthNum = "";
	try{
		adminAuthNum = ms.MailSending(useremail);
		reAdminAuthNum = adminAuthNum;
		System.out.println("adminAuthNum Error Before  : " + adminAuthNum);
	}
	catch(NullPointerException e){
		System.out.println("adminAuthNum Error After  : " + adminAuthNum);
	}
	finally{
		reAdminAuthNum = adminAuthNum;
		System.out.println("finally adminAuthNum : " + adminAuthNum + "\nfinally reAdminAuthNum : " + reAdminAuthNum);
	}
	if(adminAuthNum.length() > 0){
%>
		<script>
			window.alert("이메일 전송 완료 " + <%= adminAuthNum %>);
		</script>
<%	
	}
%>
<script type="text/javascript">
	function authNumCheck(){
		var adminAuthNum = '<%= reAdminAuthNum %>';
		var userAuthNum = document.authNumCheckForm.userAuthNum.value;
		if(userAuthNum == adminAuthNum){
			window.alert("인증 완료");
			opener.emailAuthCheck = true;
			window.close();
		}
		else{
			window.alert("인증 실패");
		}
	}

</script>
<html>
<head>
	<title> 인증번호 확인 </title>
</head>
<body>
	<form name="authNumCheckForm">
		<table>
			<tr>
				<td> 인증번호 <input type="text" placeholder="인증번호 입력" name="userAuthNum"> </td>
				<td> <input type="button" value="확인" onclick="authNumCheck()"> </td>
			</tr>
		</table>
	</form>
</body>
</html>