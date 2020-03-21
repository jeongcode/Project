<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="passwordMsg" value="${requestScope.msg}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.password-form {
		width: 340px;
    	margin: 50px auto;
	}
    .password-form form {
    	margin-bottom: 15px;
        padding: 30px;
    }
    .password-form h2 {
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
		var passwordCheck = false;
		if('${passwordMsg}'){
			alert('${passwordMsg}');
		}
		
		$("#passwordFindBtn").click(function (){
			location.href="${contextPath}/memberTmpPasswordForm.do";
		});
		
        $('#passwordCheck').blur(function() {
	    	if($('#password1').val() == $(this).val()){
	    		$('#passwordCheck').attr('class', 'form-control  is-valid');
	            passwordCheck = true;
	        }else{
	            $('#passwordCheck').attr('class', 'form-control  is-invalid');
	            passwordCheck = false;
	        }
        });
        
		$("#submitBtn").click(function (){
			if(passwordCheck == false){
				alert("비밀번호를 재확인하여 주세요");
			}
			else{
 				var form = $("#passwordForm");
 				form.submit();
			}
		});
		
	});
</script>
<title>password</title>
</head>
<body>
<div class="password-form">
    <form id="passwordForm" name="passwordForm" method="post" action="${contextPath}/memberPasswordUpdate.do">
        <div class="form-group">
            <input type="password" class="form-control" id="password1" name="password1" placeholder="비밀번호 입력" required="required">
        </div>
        <div class="form-group">
            <input type="password" class="form-control" id="passwordCheck" name="passwordCheck" placeholder="비밀번호 재입력" required="required">
        </div>
        <div class="form-group">
            <input type="button" class="btn btn-primary btn-block" id="submitBtn" value="비밀번호 수정">
        </div>
    </form>
</div>
</body>
</html>