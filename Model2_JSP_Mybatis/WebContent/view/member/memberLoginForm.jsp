<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="loginMsg" value="${requestScope.msg}"/>
<%
	Cookie[] c = request.getCookies();
	String cookieVal = "";
	if(c != null){
		for(Cookie i : c){
			if(i.getName().equals("userEmail")){
				cookieVal = i.getValue();
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.login-form {
		width: 340px;
    	margin: 50px auto;
	}
    .login-form form {
    	margin-bottom: 15px;
        padding: 30px;
    }
    .login-form h2 {
        margin: 0 0 15px;
    }
    .form-control, .btn {
        min-height: 38px;
        border-radius: 2px;
    }
    .btn {        
        font-size: 15px;
        font-weight: bold;
    }
</style>
<script type="text/javascript">
	$(function (){
		if('${loginMsg}'){
			alert('${loginMsg}');
		}
		$("#passwordFindBtn").click(function (){
			location.href="${contextPath}/memberTmpPasswordForm.do";
		});
	});
</script>
<title>Login</title>
</head>
<body>
<div class="login-form">
    <form id="loginForm" name="loginForm" method="post" action="${contextPath}/memberLogin.do">
        <div class="form-group">
            <input type="text" class="form-control" id="email" name="email" placeholder="Email" required="required" value="<%=cookieVal !="" ? cookieVal : "" %>">
        </div>
        <div class="form-group">
            <input type="password" class="form-control" id="pasword" name="password" placeholder="Password" required="required">
        </div>
        <div class="form-group" id="loginBtnArea">
            <input type="submit" class="btn btn-primary btn-block" id="loginBtn" value="로그인">
        </div>
        <div class="clearfix">
            <input type="button" class="btn btn-primary btn-block" id="passwordFindBtn" value="임시 비밀번호 발급" >
            <label class="pull-left checkbox-inline"><input type="checkbox" id="rememberID" name="rememberID" <%=cookieVal!=""?"checked" : ""%>>이메일 저장</label>
        </div>        
    </form>
</div>
</body>
</html>