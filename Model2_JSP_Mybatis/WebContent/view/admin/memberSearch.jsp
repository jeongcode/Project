<%@ page language="java" contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp"%>
<c:set var="memberList" value="${requestScope.memberList}"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
	function memberDelete(nickname){
    	$.ajax({
    		type:"post", //요청방식을 설정 합니다(post 또는 get 방식으로 선택)
            url:"${contextPath}/adminMemberDelete.do",//요청할 서블릿의 매핑주소 또는 JSP의 주소 
            data:{"nickname" : nickname},//서블릿 또는 JSP페이지로 요청할 데이터 설정
            success:function(result){
            }
		}).done(function (result){
        	if(result == "1"){
        		$("#"+ nickname +"").remove();
            }
    	});
	}
	function qnaSearch(){
		location.href="${contextPath}/adminQnaSearch.bo";
	}
	
	</script>
	<title>MemberList</title>
</head>
<body>
	<br>
	<div class="container">
		<table class="table table-hover" style="text-align: center;">
			<thead>
				<tr>
					<th style="background-color: #dddddd; text-align: center;">가입일</th>
					<th style="background-color: #dddddd; text-align: center;">별명</th>
					<th style="background-color: #dddddd; text-align: center;">Email</th>
					<th style="background-color: #dddddd; text-align: center;">포인트</th>
					<th style="background-color: #dddddd; text-align: center;">전화번호</th>
					<th style="background-color: #dddddd; text-align: center; width: 180px;">관 리</th>
				</tr>
				<c:forEach var="memberBean" items="${memberList}">
					<tr id="${memberBean.nickname}">
						<td>${memberBean.joindate}</td>
						<td>${memberBean.nickname}</td>
						<td>${memberBean.email}</td>
						<td>${memberBean.point}</td>
						<td>${memberBean.tel}</td>
						<td><input class="btn btn-danger" type="button" value="탈퇴" onclick="memberDelete('${memberBean.nickname}');"></td>
					</tr>		
				</c:forEach>
			</thead>
			<tbody id="memberListTable">
			
			</tbody>
		</table>
	</div>
</body>
</html>