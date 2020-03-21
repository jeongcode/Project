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
    <title>게시판</title>
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
			BoardBean bBean = (BoardBean)request.getAttribute("origin");
			int originNum = bBean.getNum();
			String originPasswd = bBean.getPasswd();
			String originEmail = bBean.getEmail();
			String originNickname =	bBean.getNickname();
			String originSubject = bBean.getSubject();
			String originContent = bBean.getContent();
%>
<script type="text/javascript">
	function boardOwnDel(){
		<%
			if(!originEmail.equals(email)){
		%>
				window.alert("자신의 글이 아닙니다");
		<%
			}
			else{
		%>
				var boardPasswd = document.boardForm.boardPasswd.value;
				if(boardPasswd == ""){
					window.alert("게시글의 비밀번호를 입력하세요");
				}
				else{
					if(boardPasswd == <%= originPasswd %>){
						document.boardForm.method = "post";
						document.boardForm.action = "boardDelPro.jsp";
						document.boardForm.submit();
					}
				}
		<%
			}
		%>
	}
	function boardOwnMod(){
		<%
			if(!originEmail.equals(email)){
		%>
				window.alert("자신의 글이 아닙니다");
		<%
			}
			else{
		%>
				var boardPasswd = document.boardForm.boardPasswd.value;
				if(boardPasswd == ""){
					window.alert("게시글의 비밀번호를 입력하세요");
				}
				else{
					if(boardPasswd == <%= originPasswd %>){
						// board 수정 필요
						// forward시 조건문 거치지않고 바로 실행
 						document.boardForm.method = "post";
						document.boardForm.action = "boardReWrite.jsp";
						document.boardForm.submit();
			<%-- 		<% 
				 			request.setAttribute("nBean",bBean);
							pageContext.forward("boardReWrite.jsp"); 
						%> --%>
					}
				}
		<%
			}
		%>
	}
	function replyWrite(){
		document.boardForm.method="post";
		document.boardForm.action="replyWrite.jsp";
		document.boardForm.submit();
	}
</script>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
		<form action="commentWritePro.jsp" method="post" name="boardForm" id="boardForm">
			<table id="boardTable">

				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" value="<%= originEmail %>" readonly></td>
				</tr>
				<tr>
					<td>작성자(별명)</td>
					<td><input type="text" name="nickname" value="<%= originNickname %>" readonly></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%= originSubject %>" readonly></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td><textarea rows="13" cols="40" name="content" readonly><%= originContent %></textarea> </td>
				</tr>											
			</table>
			<div id="comment">
				댓글  <textarea rows="2" cols="71" id="commentContent"name="commentContent" required></textarea>
				<input type="submit" name="commentWrite" value="댓글 작성">
			</div>
			<div id="table_search">
				<input type="button" value="글 삭제" class="btn"
						onclick="boardOwnDel()">
				<input type="button" value="글 수정" class="btn"
						onclick="boardOwnMod()"> 
				<input type="hidden" value="<%= originNum %>" name="originNum">
				<input type="password" value="" placeholder="게시판 비밀번호 입력" name="boardPasswd">
				<br>
				<input type="button" value="답글 작성" class="btn" onclick="replyWrite();">
				<input type="button" value="글 목록" class="btn" 
					 	onclick="location.href='board.jsp'">
			</div>
		</form>	
			<div id="comment">
				<% 
					//Comment Size 확인 및 List 가져오기
					//Comment가 작성된 Board를 확인하기 위해 originNum(클릭한 게시판의 num)을 매개변수로 전달
					CommentDAO cDao = new CommentDAO();
					ArrayList<CommentBean> commentArr = cDao.commentListCheck(originNum);
					int commentSize = cDao.commentSizeCheck(originNum);
				%>
				<%
					for(int i = 0 ; i < commentArr.size() ; i++ ){
						CommentBean cBeanArr = commentArr.get(i);
				%>
				<!-- comment 삭제 방법 reg_seq , num 을 조건으로 걸어 삭제 -->
				<form action="commentDelPro.jsp" method="post">
					<a><%= cBeanArr.getNickname() %></a> &nbsp; <a><%= new SimpleDateFormat("yyyy/MM/dd HH:mm").format(cBeanArr.getDate()) %></a><br>
					<textarea rows="auto" cols="70" disabled><%= cBeanArr.getContent() %></textarea>
					<input type="hidden" value="<%= cBeanArr.getReg_seq() %>" name="reg_seq">
					<input type="hidden" value="<%= cBeanArr.getNum() %>" name="originNum">
					<input type="submit" value="댓글 삭제" ><br> 	
				</form>	
				<%
					}
				%>
				
			</div>
<%-- 	Form 분할		
			<div id="table_search">
				<input type="button" value="글 삭제" class="btn"
						onclick="boardOwnDel()">
				<input type="button" value="글 수정" class="btn"
						onclick="boardOwnMod()"> 
				<input type="hidden" value="<%= originNum %>" name="originNum">
				<input type="password" value="" placeholder="게시판 비밀번호 입력" name="boardPasswd">
				<br>
				<input type="button" value="답글 작성" class="btn" onclick="replyWrite();">
				<input type="button" value="글 목록" class="btn" 
					 	onclick="location.href='board.jsp'">
			</div>
		</form>	
 --%>	
 		</article>
	</div>
  </body>
</html>
