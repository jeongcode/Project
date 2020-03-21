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
    <title>답글</title>
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
			table#boardTable {
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
	ReplyBean rBean = (ReplyBean)request.getAttribute("rBean");
	int num = rBean.getNum();
	String writerEmail = rBean.getEmail();
	String passwd = rBean.getPasswd();
	String writerNickname = rBean.getNickname();
	String subject = rBean.getSubject();
	String content = rBean.getContent();
	int lev = rBean.getReg_lev();
	// 답글 수정 시 기본 데이터를 뿌려주기 위해 into 시 썻던 데이터들 그대로 mod에 쓰기위해 request영역에 set 
	request.setAttribute("rBean",rBean);
%>
<script type="text/javascript">
	function replyOwnDel(){
	<%
		if(!writerEmail.equals(email)){
			%>
				window.alert("자신의 답글이 아닙니다");
			<%
		}
		else{
			%>
			var boardPasswd = document.replyForm.replyPasswd.value;
				if(boardPasswd == <%= passwd %>){
					var form = document.replyForm;
					form.method = "post";
					form.action = "replyDelPro.jsp"
					form.submit();
				}
				else{
					window.alert("비밀번호가 틀렸습니다");
				}
			<%
		}
	%>
	
	}
	function replyOwnMod(){
		<%
		if(!writerEmail.equals(email)){
			%>
				window.alert("자신의 답글이 아닙니다");
			<%
		}
		else{
			%>
			var boardPasswd = document.replyForm.replyPasswd.value;
				if(boardPasswd == <%= passwd %>){
					var form = document.replyForm;
					form.method = "post";
					form.action = "replyReWrite.jsp"
					form.submit();
				}
				else{
					window.alert("비밀번호가 틀렸습니다");
				}
			<%
		}
	%>
	}
</script>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
		<form action="replyMod.jsp" method="post" name="replyForm" id="replyForm">
			<table id="boardTable">

				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value="<%= writerEmail %>" readonly></td>
				</tr>
				<tr>
					<td>작성자(별명)</td>
					<td><input type="text" name="nickname" value="<%= writerNickname %>" readonly></td>
				</tr>				
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%= subject %>" readonly></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td><textarea rows="13" cols="40" name="content" readonly><%= content %></textarea> </td>
				</tr>											
			</table>
			<div id="table_search">
			<input type="button" value="글 삭제" class="btn"
						onclick="replyOwnDel()">
				<input type="button" value="글 수정" class="btn"
						onclick="replyOwnMod()"> 
				<input type="hidden" value="<%= num %>" name="num">
				<input type="hidden" value="<%= lev %>" name="lev">
				<input type="password" value="" placeholder="게시판 비밀번호 입력" name="replyPasswd" required>
				<br>
				<input type="button" value="글 목록" class="btn" 
					 	onclick="location.href='board.jsp'">
			</div>
		</form>	
	</article>
	</div>
  </body>
</html>
