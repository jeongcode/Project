<%@page import="notice.NoticeBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
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
	String nickname = (String)session.getAttribute("nickname");
	String email = (String)session.getAttribute("email");
	if(nickname == null || email == null){
%>
	<script>
		location.href="../member/login.jsp";
	</script>
<%
	}
	NoticeBean nBean = (NoticeBean)request.getAttribute("nBean");
	String nEmail = nBean.getEmail();
	String nNickname = nBean.getNickname();
	String nSubject = nBean.getSubject();
	String nContent = nBean.getContent();
	int nNum = nBean.getNum();
	
%>
<script type="text/javascript">
	function noticeDel(){
		var form = document.noticeForm;
		form.method = "post";
		form.action = "noticeDelPro.jsp";
		form.submit();
	}
	function noticeReWrite(){
		var form = document.noticeForm;
		form.method = "post";
		form.action = "noticeReWrite.jsp";
		form.submit();
	}
</script>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
		<form action="" method="post" name="noticeForm" id="noticeForm">
			<table id="noticeTable">

				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value="<%= nEmail %>" readonly></td>
				</tr>
				<tr>
					<td>작성자(별명)</td>
					<td><input type="text" name="nickname" value="<%= nNickname %>" readonly></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%= nSubject %>" readonly></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td><textarea rows="13" cols="40" name="content" readonly><%= nContent %></textarea> </td>
				</tr>											
			</table>
				
		
			<div id="table_search">
			<%
				if("admin@admin.com".equals(email)){
			%>
				<input type="button" value="글 삭제" class="btn"
						onclick="noticeDel()">
				<input type="button" value="글 수정" class="btn"
						onclick="noticeReWrite()"> 
				<input type="button" value="글 목록" class="btn" 
					 	onclick="location.href='notice.jsp'">
				<input type="hidden" value="<%= nNum %>" name="num">
			<%
				}
				else{
			%>
				<input type="button" value="글 목록" class="btn" 
					 	onclick="location.href='notice.jsp'">
			<% } %>

			</div>
		</form>	
	</article>
	</div>
  </body>
</html>
