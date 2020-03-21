<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/js/total.html" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="sessionEmail" value="${sessionScope.email}"/>
<c:set var="sessionNickname" value="${sessionScope.nickname}"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function (){
		if('${sessionEmail}'){
	    	$.ajax({
	    		type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
	            url:"${contextPath}/unreadPaymentQnaCount.bo",//요청할 서블릿의 매핑주소 또는 JSP의 주소 
	            data:{"email" : '${sessionEmail}'},//서블릿 또는 JSP페이지로 요청할 데이터 설정
	            success:function(result){
	            }
			}).done(function (result){
				$("#unreadCount").text(result);				
			});	
		}
	});
</script>
</head>
<body>
	<ul class="nav justify-content-center nav-tabs">
	  <li class="nav-item">
	    <a class="nav-link" href="${contextPath}/home.do">메인</a>
	  </li>
	  <c:choose>
	  	<c:when test="${sessionEmail == null}">
			  <li class="nav-item">
			    <a class="nav-link" href="${contextPath}/memberLoginForm.do">로그인</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="${contextPath}/memberJoinForm.do">회원가입</a>
			  </li>
		</c:when>
		<c:when test="${sessionNickname == '관리자'}">
			  <li class="nav-item">
			    <a class="nav-link" href="${contextPath}/adminMemberSearh.do">회원 관리</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="${contextPath}/adminQnaSearch.bo">문의 내역 관리</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="${contextPath}/adminPaymentSearch.bo">모든 결제 내역 확인</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" href="${contextPath}/memberLogout.do">로그아웃</a>
			  </li>
		</c:when>
	  	<c:otherwise>
			  <li class="nav-item">
			    <a class="nav-link" href="${contextPath}/QnaWriteForm.bo">1:1 문의</a>
			  </li>
			  <li>
			    <a class="nav-link" href="${contextPath}/unreadPaymentQnaList.bo">알림
					<sup><span id="unreadCount" class="badge badge-pill badge-danger"></span></sup>
			    </a>
			  </li>
			  <li>
				  <a class="btn btn-primary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    ${sessionNickname} &nbsp; 님
				  </a>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
				    <a class="dropdown-item" href="${contextPath}/paymentSelect.bo">결제 내역</a>
				    <a class="dropdown-item" href="${contextPath}/qnaList.bo">문의 내역</a>
				    <a class="dropdown-item" href="${contextPath}/memberInfo.do">회원정보</a>
				    <a class="dropdown-item" href="${contextPath}/memberLogout.do">로그아웃</a>
				  </div>
			  </li>
	  	</c:otherwise>
	  </c:choose>
	</ul>
</body>
</html>