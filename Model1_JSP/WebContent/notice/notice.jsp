<%@page import="java.text.SimpleDateFormat"%>
<%@page import="notice.NoticeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>공지사항</title>
	<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
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
				table-layout: auto;
				padding-left : 200px;
				padding-top : 150px;
				display: table;
				border-spacing: 2px;
 			}
			.pageDiv{
				margin-top: 10px;
				margin-left: 450px;
				padding-bottom: 10px;
			}
			.pageDiv a{
				margin-left: 10px;
				font-size: 1.5em;
			}
			.tno{
				width: 70px
			}
			.writeBtn{
				margin-top: 50px;
				margin-left: 450px;
			}
</style>
<script type="text/javascript">

</script>
</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
			<table id="noticeTable">
				<%
					String pageNum = request.getParameter("pageNum");
					if(pageNum == null){
						pageNum = "0";
					}
					int currentPage = Integer.parseInt(pageNum);
					
					NoticeDAO nDao = new NoticeDAO();
					int noticeSize = nDao.noticeSizeCheck();
				%>
				<tr>
					<td colspan="4">공지글 수 : <%= noticeSize %> </td>
				</tr>
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<%
					//currentPage = 전달받는 페이지 쪽 수 
					//noticeSize = 공지사항 모든 글 수
					//size = 페이지에 출력할 글 수
					//transPage = 게시판 총 글 수의 size로 나눈 값 (SQL 검색 시 시작 번호를 지정할 값)
					int size = 10;
					int transPage = 0;
					if(currentPage > 1){
						transPage = (noticeSize / size);
						for(int i = 0 ; i < transPage ; i++){
							currentPage += 9;
						}
					}
					else{
						currentPage = (currentPage > 0 ? +10 : 0) ;
					}
					ArrayList<NoticeBean> noticeArr = nDao.noticeListCheck(currentPage , size);	
				if(noticeArr.size() > 0){ 
					for ( int i = 0 ; i < noticeArr.size() ; i++){
					NoticeBean nBean = noticeArr.get(i);
				%>	
					<tr>
						<td> <%= nBean.getNum() %></td>
						<td> <a href="noticeIntoPro.jsp?num=<%=nBean.getNum()%>"><%= nBean.getSubject() %></a></td>
						<td> <%= nBean.getNickname() %></td>
						<td> <%= new SimpleDateFormat("yyyy/MM/dd").format(nBean.getDate()) %></td>
						<td> <%= nBean.getReadcount() %></td>
					</tr>					
				<% 		
					}
				}
				else{
				%>
					<tr>
						<td></td>
						<td colspan="4"> 공지사항 글이 없습니다 </td>
					</tr>
				<% 	
				}
				%>
			</table>
			<div class="writeBtn">
			<%
				String email = (String)session.getAttribute("email");	
				if("admin@admin.com".equals(email)){
			%>
				<input type="button" value="글 쓰기" onclick="location.href='noticeWrite.jsp'">
			<%
				}
				int divPage = 0;
				for(int i = 0 ; i < noticeSize / size + 1 ; i++){
					divPage++;
				}
			%>	
			</div>	
			<div class="clear"></div>
			<div class="pageDiv">
			<%
				if(divPage > 0){
					for(int i = 1 ; i <= divPage ; i++){
				%>
						<a href="notice.jsp?pageNum=<%= i-1 %>"> <%= i %></a>
				<%
					}
				}
			%>	
			</div>		
		</article>
	</div>
  </body>
</html>
