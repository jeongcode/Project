<%@page import="reply.ReplyBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.CommentBean"%>
<%@page import="board.CommentDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
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
			table#replyTable {
				width: 800px;
				table-layout: fixed;
				padding-left : 200px;
				padding-top : 150px;
				display: table;
				border-spacing: 2px;
 			}
			div#comment{
				width: 800px;
				table-layout: fixed;
				padding-left : 200px;
			}
			div#comment>textarea{
				margin-left : 50px;
			}
			div#comment>input{
				margin-top : 10px;
				margin-left: 90px;
			}
			#commentDelBtn{
				margin-right: 80px;
			}

</style>
<%
	request.setCharacterEncoding("UTF-8");
	String nickname = (String)session.getAttribute("nickname");
	String email = (String)session.getAttribute("email");
	if(nickname == null || email == null){
%>
	<script>
		location.href="../member/login.jsp";
	</script>
<%
	}
	// 선택한 게시판의 num을 계속 전달
	int num = Integer.parseInt(request.getParameter("num"));
	int lev = Integer.parseInt(request.getParameter("lev"));
	String writerEmail = request.getParameter("email");
	String writerNickname = request.getParameter("nickname");
	String passwd = request.getParameter("passwd");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
			
%>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
		<form action="replyReWritePro.jsp" method="post" name="replyForm" id="replyForm">
			<table id="replyTable">

				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value="<%= email %>" readonly></td>
				</tr>
				<tr>
					<td>작성자(별명)</td>
					<td><input type="text" name="nickname" value="<%= nickname %>" readonly></td>
				</tr>				
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd" required></td>
				</tr>
				
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%= subject %>" required></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td><textarea rows="13" cols="40" name="content" required><%= content %></textarea> </td>
				</tr>											
			</table>
			<div id="table_search">
				<input type="submit" value="답글 수정 완료" class="btn">
				<input type="reset" value="초기화" >
				<input type="button" value="글 목록" class="btn" 
					 	onclick="location.href='board.jsp'">
				<input type="hidden" value="<%= num %>" name="num">
				<input type="hidden" value="<%= lev %>" name="lev">
			</div>
		</form>	
	</article>
	</div>
  </body>
</html>
