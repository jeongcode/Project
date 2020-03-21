<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	.passwordFind-form {
		width: 340px;
    	margin: 50px auto;
	}
    .passwordFind-form form {
    	margin-bottom: 15px;
        padding: 30px;
    }
    .passwordFind-form h2 {
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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	

	$(function (){
		var emailDuplChk = false;
		
		$("#email").blur(function (){
	    	$.ajax({
	    		type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
	            url:"${contextPath}/memberEmailDuplChk.do",//요청할 서블릿의 매핑주소 또는 JSP의 주소 
	            data:{"email" : $("#email").val()},//서블릿 또는 JSP페이지로 요청할 데이터 설정
	            success:function(result){
	            }
			}).done(function (result){
	        	if(result == "1"){
                    $('#email').attr('class', 'form-control is-valid');
                    emailDuplChk = true;
	        	}
	        	else{
                    $('#email').attr('class', 'form-control is-invalid');
                    emailDuplChk = false;
	        	}
	    	});	
		});
		
		$("#tmpPasswordBtn").click(function(){
			if(emailDuplChk == false){
				alert("이메일을 확인하여 주세요");
			}
			else{
				var form = $("#passwordFindForm");
				form.submit();
			}
		});
	});
</script>
<title>passwordFind</title>
</head>
<body>
<div class="passwordFind-form">
    <form id="passwordFindForm" name="passwordFindForm" method="post" action="${contextPath}/memberTmpPassword.do">
        <div class="form-group">
            <input type="text" class="form-control" id="email" name="email" placeholder="Email" required="required">
        </div>
        <div class="form-group">
            <input type="button" class="btn btn-primary btn-block" id="tmpPasswordBtn" value="임시 비밀번호 발급">
        </div>
    </form>
</div>
</body>
</html>