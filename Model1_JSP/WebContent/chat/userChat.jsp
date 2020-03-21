<%@page import="chat.ChatBean"%>
<%@page import="chat.ChatDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="gallery.GalleryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>채팅</title>
	<!-- 구글 폰트  -->
	<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
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
			#frame{
				padding-top: 300px;
				padding-left: 180px;
				overflow: hidden;
			}
			#chatForm{
				margin-left: 250px;
				margin-top: 200px;
				width: 500px;
			}
			#chatTable{
				border: 2px solid #000;
			}
			#chatTr{
				display: block;
				height: 500px;
				overflow: auto;
			}
			#chatTr>td{
				display: block;
			}
			#email{
				display:inline;
			}
			#mine{
				background-color: #fafaa0; 
			}
			#not{
				background-color: #fde1b4;
			}
</style>
<%
	String email = (String)session.getAttribute("email");
	String nickname = (String)session.getAttribute("nickname");
	if(email == null || nickname == null){
%>
		<script>
			location.href="../member/login.jsp";
		</script>
<% 
	request.setCharacterEncoding("UTF-8");
	}
	String selNickname = request.getParameter("selNickname");
	String selName = request.getParameter("selName");
	String selEmail = request.getParameter("selEmail");
	String fromID = email;
	String toID = selEmail;
%>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	function chatSubmit(){
		var fromID = '<%= fromID %>';
		var toID = '<%= toID %>';
		var content = $("#content").val();
		if(fromID == "" || fromID.length == 0 || toID == "" || toID.length == 0 ||
				content == "" || content.length == 0){
			window.alert("내용을 입력하세요 !!!");
		}
		else{
  		$.ajax(
				{
					type:"POST",
					dataType:"text",
					async:true,
			  		url:"chatSubmitPro.jsp",  		
			  		data:{
			  			fromID: encodeURIComponent(fromID),
						toID: encodeURIComponent(toID),
						content: encodeURIComponent(content)
			  		},
			  		success:function(result){
							location.reload();
			  		}
				}
			  );
		}
	}
</script>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
		<form id="chatForm" action="#" method="post">
			<h3> TO.<%= toID %></h3>
			<table id="chatTable">
				<tr id="chatTr">
				<%
					ChatDAO cDao = new ChatDAO();
					int result = cDao.chatSetRead(fromID, toID);
					if(result == 10){
						session.removeAttribute("read");
					}
					
					ArrayList<ChatBean> arr = cDao.getChatListByID(0, fromID, toID);
					for(int i = 0 ; i < arr.size() ; i++){
						ChatBean cBeanArr = arr.get(i);
						if(fromID.equals(cBeanArr.getFromID())){
					%>
						<td id="mine" align="right"><%= cBeanArr.getTime() %></td>
						<td id="mine" align="right"><%=cBeanArr.getContent() %></td>
					<%		
						}
						else{
					%>
						<td id="not" align="left"><%= cBeanArr.getTime() %></td>
						<td id="not" align="left"><%=cBeanArr.getContent() %></td>
					<%							
						}
					}
				%>
				</tr>
				<tr>
					<td>
						<input type="text" value="<%= email %>" name="email" id="email" disabled>
						<textarea rows="5" cols="70" name="content" id="content" required></textarea>
					</td>
					<td>
						<input type="button" value="전송" onclick="chatSubmit();">
					</td>
				</tr>
			</table>
		</form>
	</article>
	</div>
  </body>
</html>
