<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>회원가입</title>
	<script language="javascript" src="//code.jquery.com/jquery-3.4.1.min.js"></script>
	<!-- 구글 폰트  -->
	<link href="https://fonts.googleapis.com/css?family=Noto+Serif+KR:600|Poiret+One&display=swap" rel="stylesheet">
	<link href="../css/main.css" rel="stylesheet">
<style type="text/css">
			#wrap{
				width: 971px;
				text-align: left;
				margin: 0 auto 0 auto;
				min-height: 750px;
				height: 1000px;
				background-image: url(../images/shadow.png);
				background-repeat-x : no-repeat;
				background-repeat-y : repeat;
			}
			#table_search{
				padding-left : 360px;
				padding-top : 20px;
			}
			table#noticeTable {
				width: 800px;
				table-layout: fixed;
				padding-left : 200px;
				padding-top : 150px;
				display: table;
				border-spacing: 2px;
 			}

			
</style>
<%
	request.setCharacterEncoding("UTF-8");
	String nickname = (String)session.getAttribute("nickname");
	String email = (String)session.getAttribute("email");
	if(!"admin@admin.com".equals(email)){
%>
	<script>
		window.alert("관리자가 아닙니다");
	</script>
<%
	}
	String originNum = request.getParameter("num");
	String originSubject = request.getParameter("subject");
	String originContent = request.getParameter("content");
	
%>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
		<form action="noticeReWritePro.jsp" method="post">
			<table id="noticeTable">

				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value="<%= email %>" readonly></td>
				</tr>
				<tr>
					<td>별명</td>
					<td><input type="text" name="nickname" value="<%= nickname %>" readonly></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd" required></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%= originSubject %>"></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td><textarea rows="13" cols="40" name="content"> <%= originContent %> </textarea> </td>
				</tr>											
			</table>
			
			<div id="table_search">
				<input type="submit" value="글 수정완료" class="btn"> 
				<input type="button" value="글목록" class="btn" 
					   onclick="location.href='notice.jsp'">
				<input type="hidden" value="<%= originNum %>" name="num">
			</div>
		</form>	
	</article>
	</div>
  </body>
</html>
