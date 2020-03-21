<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="visit.VisitDAO"%>
<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDAO"%>
<%@page import="board.CommentDAO"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
		<title>홈</title>
<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Noto+Serif+KR:600|Poiret+One&display=swap" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<style type="text/css">
	#wrap{
		background-image: url(images/shadow.png);
	}
	#boardtable{
			font-size: 0.9em;
			width: 800px;
			table-layout: auto;
			padding-left : 180px;
			padding-top : 50px;
			display: table;
			border-spacing: 2px;
	}
	#noticetable{
			font-size: 0.9em;
			width: 800px;
			table-layout: auto;
			padding-left : 180px;
			padding-top : 50px;
			display: table;
			border-spacing: 2px;
	}
	#mainboard{
		font-size: 0.75em;
	}
	td{
		text-align: center;
	}
	#visit>th{
		border: 2px, solid , #4444;
	}
	span{
		margin-left: 50px;
	}
	#redCircle{
		width:15px;
		height:15px;
	}
</style>
</head>
<body>
	<div id="imagewrap">
		<header>
		<% 
			String readCheck = (String)session.getAttribute("read");
			System.out.println("readCheck : " + readCheck);

			String nickname = (String)session.getAttribute("nickname");
			if(nickname == null){
		%>
				<div id="loginjoinbox">
					<a href="index.jsp" id="lojo"> HOME </a><br>
					<a href="member/login.jsp" id="lojo"> LOGIN </a><br> 
					<a href="member/resistration.jsp" id="lojo"> JOIN </a>
				</div>
		<%		
			}
			else{
		%>		
				<div id="loginjoinbox">
					<a href="#" id="lojo"> <%= nickname %> 님 환영합니다 </a><br>
					<a href="index.jsp" id="lojo"> HOME </a><br>
					<a href="member/logoutPro.jsp" id="lojo"> LOGOUT </a><br>
					<a href="member/mypagePassCheck.jsp" id="lojo"> MY PAGE</a>
				</div>
		<%		
			}
		%>
				<div class="clear"></div>
				<nav id="topmenu">
					<ul>
						<li><a href="board/board.jsp">게시판</a></li>
						<li><a href="notice/notice.jsp">공지사항</a></li>
						<li><a href="gallery/gallery.jsp">갤러리</a></li>
						<li id="chat"><a href="chat/chat.jsp">채팅
				<%			
							if("NOREAD".equals(readCheck)){
				%>
							<img id="redCircle" src="images/redcircle.png">
				<%	
							}
				%>
					</a>
					</li>
					</ul>
				</nav>
	</header>
		<article>
				<% 
					SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-DD");
					String date = formatter.format(new java.util.Date());
					VisitDAO vDao = new VisitDAO();
					int totalVisit = vDao.getTotalVisit();
					int todayVisit = vDao.getTodayVisit(date);
				%>
					<span>총 방문자 수 : <%= totalVisit %></span> <br>
					<span>오늘 방문자 수 : <%= todayVisit %></span>

			<table id="boardtable">
				<%
				BoardDAO bDao = new BoardDAO();	
				int boardSize = bDao.boardSizeCheck();
				%>
				<tr>
					<td>게시판 글 수 : <%= boardSize %> </td>
				</tr>
				
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<%
					BoardBean bBean = new BoardBean();
					ArrayList<BoardBean> arr = bDao.boardListCheck(0,5);
					if(arr.size() == 0){
				%>
					<tr>
						<td></td>
						<td rowspan="4"> 게시글이 없습니다 </td>
					</tr>
				<% 
					}
					else{
					CommentDAO cDao = new CommentDAO();
					for(int i = 0 ; i < arr.size() ; i++){
						BoardBean checkBean = arr.get(i);
						int num = checkBean.getNum();
						int commentSize = cDao.commentSizeCheck(num);
		// board list 체크 할 시 board 테이블과 reply 테이블을 union을 사용하여 
		// reg_lev가 0이면 기본 게시글로 처리 하고 0 이상이면 답글로 처리한다
						if(checkBean.getReg_lev() == 0){
				%>
					<tr>
						<td> <%= num %></td>
						<td class="left"> <a href="board/boardIntoPro.jsp?num=<%= num %>"><%= checkBean.getSubject() %> &nbsp;[<%=commentSize%>] </a></td>
						<td> <%= checkBean.getNickname() %> </td>
						<td> <%= new SimpleDateFormat("yyyy/MM/dd").format(checkBean.getDate()) %> </td>
						<td> <%= checkBean.getReadcount() %> </td>
					</tr>
				<% 		
						}
						else{
				%>
					<tr>
						<td></td>
						<td class="left"><img src="images/level.gif"><img src="images/re.gif"> <a href="board/replyIntoPro.jsp?num=<%= num %>&lev=<%= checkBean.getReg_lev() %>"><%= checkBean.getSubject() %> </a></td>
						<td> <%= checkBean.getNickname() %> </td>
						<td> <%= new SimpleDateFormat("yyyy/MM/dd").format(checkBean.getDate()) %> </td>
						<td> <%= checkBean.getReadcount() %> </td>
					</tr>
				<%
						}
						}
					}
				%>
				
			</table>
			<table id="noticetable">
				<%
					NoticeDAO nDao = new NoticeDAO();
					int noticeSize = nDao.noticeSizeCheck(); 
				%>
				<tr>
					<td>공지사항 글 수 : <%= noticeSize %>  </td>
				</tr>
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<%
					ArrayList<NoticeBean> noticeArr = nDao.noticeListCheck(0,5);
					if(noticeArr.size() == 0){
				%>
					<tr>
						<td></td>
						<td rowspan="4"> 게시글이 없습니다 </td>
					</tr>
				<% 
					}
					else{
						for(int i = 0 ; i < noticeArr.size() ; i++){
						NoticeBean nBean = noticeArr.get(i);
						int noticeNum = nBean.getNum();
				%>
						<tr>
							<td> <%= nBean.getNum() %> </td>
							<td class="left"><a href="notice/noticeIntoPro.jsp?num=<%= noticeNum %>"><%= nBean.getSubject() %> </a></td>
							<td> <%= nBean.getNickname() %> </td>
							<td> <%= new SimpleDateFormat("yyyy/MM/dd").format(nBean.getDate()) %> </td>
							<td> <%= nBean.getReadcount() %></td>
						</tr>
				<% 		
						}
					}
				%>
			</table>
		</article>
		</div>
	</body>
</html>