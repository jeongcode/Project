<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="memberBean" value="${requestScope.memberBean}" />

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

	function memberDel(){
		location.href="${contextPath}/memberDelete.do";
	}
	
	$(function (){
		if('${loginMsg}'){
			alert('${loginMsg}');
		}
		$("#passwordUpdateBtn").click(function(){
			location.href="${contextPath}/memberPasswordUpdateForm.do";
		});
	});
</script>
<title>Login</title>
</head>
<body>
<div class="login-form">
        <div class="form-group">
        	<label>가입일</label> 
            <input type="text" class="form-control" value="${memberBean.joindate}" disabled>
        </div>
        <div class="form-group">
        	<label>별명</label> 
            <input type="text" class="form-control" value="${memberBean.nickname}" disabled>
        </div>
        <div class="form-group">
        	<label>이메일</label> 
            <input type="text" class="form-control" value="${memberBean.email}" disabled>
        </div>
        <div class="form-group">
        	<label>전화번호</label> 
            <input type="text" class="form-control" value="${memberBean.tel}" disabled>
        </div>
        <div class="form-group">
        	<label>포인트</label> 
            <input type="text" class="form-control" value="${memberBean.point}" disabled>
        </div>
        <div class="form-group">
            <input type="button" class="btn btn-primary btn-block" id="passwordUpdateBtn" value="비밀번호 수정">
        </div>
        <div class="form-group">
            <input type="button" class="btn btn-primary btn-block" onclick="memberDel();" value="회원탈퇴">
        </div>
</div>
</body>
</html>