<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/view/inc/header.jsp" %>
<c:set var="msg" value="${requestScope.msg}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>QnA</title>
<script type="text/javascript">
	$(function (){
		if('${msg}'){
			alert('${msg}');
		}
	});
</script>
</head>
<body>
	<form name="noticeForm" method="post" action="${contextPath}/QnaWrite.bo" onSubmit="Check(); return false">
		<table class="table" style="margin-left:auto; margin-right:auto; width:80%; text-align:center; margin-top:50px;" >
			<tr>
				<td style="width: 15%; text-align:left; border-top:none;">
					<b>문의사항</b>
				</td>
				<td style="width:85%; text-align:left; border-top:none;">
					<input id="title" name="title" type="text" placeholder="17자 이내로 입력해 주세요." maxlength="17" style="border:none; width:400px; margin-left: 22px; background-color:#ffffff;"/>
				</td>
			</tr>
			<tr>
				<td style="width: 15%; text-align:left;">
					<b>문의내용</b>
				</td>
				<td style="width:85% text-align:left; padding-top:10px; padding-left: 20px;">
					<textarea id="content" name="content" class="form-control" rows="15" cols="100" placeholder="문의하실 내용을 남겨주세요." maxlength="2048" style="border:none; height: 350px;"></textarea>
				</td>
			</tr>
		</table>
		
		<div style="width:900px; text-align:right;">
			<input type="submit" class="btn btn-primary" value="글쓰기" />
		</div>
	  </form>
</body>
</html>