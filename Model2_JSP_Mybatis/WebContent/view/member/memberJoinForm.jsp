<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Member Join Form</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function (){
		var latest = jQuery.noConflict();
		var nicknameCheck = false;
		var passCheck = false;
		var emailDuplCheck_1 = false; // true - keydown 이메일 형식 정상 입력시
		var emailDuplCheck_2 = false;
		var emailAuthCheck = false;
		var mobileCheck = false;
		var adminAuthNum ;
		
		latest('#emailAuthNumInput').hide(); // 최초 이메일 인증 번호 입력 영역 숨김
		
		latest('#join-submit').click(function(){
			if(nicknameCheck == false){
				alert("별명 입력을 완료하세요");
			}
			else if(emailDuplCheck_1 == false){
				alert("이메일 형식에 맞게 입력하세요");
			}
			else if(emailDuplCheck_2 == false){
				alert("이메일 중복체크를 완료 하세요");
			}
			else if(emailAuthCheck == false){
				alert("이메일 인증을 완료 하세요");
			}
			else if(passCheck == false){
				alert("비밀번호를 확인 하세요")
			}
			else if(mobileCheck == false){
				alert("휴대폰 번호를 마저 입력 하세요");
			}
			else{
				joinForm.action = "${contextPath}/memberJoin.do";
				joinForm.submit();
			}
		});
		
		latest('#nickname').blur(function(){
			if(latest('#nickname').val() == ""){
				alert('1자 이상 입력하여주세요');
                latest('#nickname').attr('class', 'form-control is-invalid');
                nicknameCheck = false;
			}
			else{
	        	latest.ajax(
	                  {
	                     type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
	                       url:"${contextPath}/memberNicknameDuplChk.do",//요청할 서블릿의 매핑주소 또는 JSP의 주소 
	                       data:{"nickname" : $('#nickname').val()},//서블릿 또는 JSP페이지로 요청할 데이터 설정
	                       success:function(data){
	                             if(data == "0"){
	                                latest('#nickname').attr('class', 'form-control is-valid');
								 	nicknameCheck = true;
	                             }
	                           	 else{
	                                 latest('#nickname').attr('class', 'form-control is-invalid');
	                           		 nicknameCheck = false;
	                           	 }
	                       }
	                  }
	            );
				
			}
		});
		
		
		latest('#email').keydown(function(){
			var email = latest('#email').val();
	         var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	         if (!getMail.test(email)) {
            		latest('#emailDuplChkResult').attr("style","color: red;");
               		latest('#emailDuplChkResult').text("이메일 형식에 맞게 작성하여 주세요");
	         	   return;
	         }
	         else{
            		latest('#emailDuplChkResult').text("");
            		emailDuplCheck_1 = true;
	         }
	    });
		

		latest('#email').blur(function(){
			if(emailDuplCheck_1 == true && latest('#email').val().length > 0){
				var email = latest('#email').val();
		         	latest.ajax(
		                  {
		                     type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
		                       url:"${contextPath}/memberEmailDuplChk.do",//요청할 서블릿의 매핑주소 또는 JSP의 주소 
		                       data:{"email" : email},//서블릿 또는 JSP페이지로 요청할 데이터 설정
		                       success:function(data){
		                             if(data == "0"){
		                            	latest('#emailDuplChkResult').text("사용 가능한 이메일 입니다");
		                            	latest('#emailDuplChkResult').attr("style","color: green;");
		                             	emailDuplCheck_2 = true;
		                             }
		                           	 else{
		                           		latest('#emailDuplChkResult').attr("style","color: red;");
		                           		latest('#emailDuplChkResult').text("중복되는 이메일 입니다");
		                        	 	emailDuplCheck_2 = false;
		                             }
		                       }
		                  }
		            );
			}
			else{
           		latest('#emailDuplChkResult').attr("style","color: red;");
           		latest('#emailDuplChkResult').text("이메일을 마저 작성하여 주세요");
			}
			});
		
		latest('#emailAuthNumSend').click(function(){
			var email = latest('#email').val();
			if(emailDuplCheck_2 == false){
				alert("이메일 중복 확인을 완료하여주세요");
			}
			else{
				latest('#email').attr('readonly', 'readonly');
				latest.ajax(
		                  {
		                     type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
		                       url:"${contextPath}/memberEmailAuthNumSend.do",//요청할 서블릿의 매핑주소 또는 JSP의 주소 
		                       data:{"email" : email},//서블릿 또는 JSP페이지로 요청할 데이터 설정
		                       success:function(data){
		                             if(data.length > 4){
		                              adminAuthNum = data;
		                              alert("이메일 메일함을 확인하여 주세요" + adminAuthNum);
		                      		  latest('#emailAuthNumInput').show();
		                           }
		                       }
		                  }
		            ); 
		         }
		});

		latest('#emailAuthSubmit').click(function (){
			var userAuthNum = latest('#userAuthNum').val();
			if(userAuthNum == adminAuthNum){
				alert("이메일 인증 되었습니다");
				emailAuthCheck = true;
                latest('#emailAuthNumSend').attr('class', 'form-control  is-valid');
        		latest('#emailAuthNumInput').hide();
			}
			else{
				alert("인증번호를 확인해주세요");
			}
		});
		
		latest('#passwordCheck').focus(function(){
      	  if(latest('#password').val() == null || latest('#password').val() == "" ){
    	  	  latest('#password').focus();  
	          latest('#passwordCheck').attr('class', 'form-control  is-invalid');
	      	  passCheck = false;
      	  }
		});
		
        latest('#passwordCheck').blur(function() {
	    	if(latest('#password').val() == latest(this).val()){
	    		latest('#passwordCheck').attr('class', 'form-control  is-valid');
	            passCheck = true;
	        }else{
	            latest('#passwordCheck').attr('class', 'form-control  is-invalid').focus();
	       }
           });
        
        latest('#mobile').keypress(function (event) { 
        	if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8) {
        		event.preventDefault(); 
        	} 
    		if(latest('#mobile').val().length >= 10){
                latest('#mobile').attr('class', 'form-control is-valid');
    			mobileCheck = true;
    		}
    		else{
    			mobileCheck = false;
    		}
       	});
	});
</script>
</head>
<body>

	<div class="col-sm-6 col-md-offset-3" id="inputArea" style="margin: auto;">
		<form id="joinForm" method="post" >
			<div class="form-group">
				<label for="InputNickname">별명</label> 
				<input type="text" class="form-control" id="nickname" name="nickname" placeholder="원하는 별명을 입력해 주세요">
			</div>
			<div class="form-group">
				<label for="InputEmail">이메일 주소</label> 
				<div class="input-group">
					<input type="text" class="form-control" id="email" name="email" placeholder="이메일 주소를 입력해주세요">
					<div class="input-group-prepend">
						<input type="button" class="btn btn-primary" id="emailAuthNumSend" value="이메일 인증">
					</div>
				</div>
				<span id="emailDuplChkResult"></span>
			</div>
			<div class="form-group" id="emailAuthNumInput">
				<label for="InputEmail">이메일 인증 번호</label> 
				<div class="input-group">
					<input type="text" class="form-control" id="userAuthNum" name="userAuthNum" placeholder="인증번호를 입력해주세요">
					<div class="input-group-prepend">
						<input type="button" class="btn btn-primary" id="emailAuthSubmit" value="인증번호 작성완료">
					</div>
				</div>
				<span id="emailDuplChkResult"></span>
			</div>
			<div class="form-group">
				<label for="inputPassword">비밀번호</label> 
				<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요">
			</div>
			<div class="form-group">
				<label for="inputPasswordCheck">비밀번호 확인</label> 
				<input type="password" class="form-control" id="passwordCheck" placeholder="비밀번호 확인을 위해 다시한번 입력 해 주세요">
			</div>
			<div class="form-group">
				<label for="inputMobile">휴대폰 번호</label> 
				<input type="text" class="form-control" id="mobile" name="mobile" placeholder="휴대폰번호(정수)를 입력해 주세요">
			</div>
			<div class="form-group text-center">
				<input type="button" class="btn btn-primary" id="join-submit" value="회원가입">
			</div>
		</form>
	</div>


</body>
</html>