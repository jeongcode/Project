<%@page import="java.text.SimpleDateFormat"%>
<%@page import="gallery.GalleryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>갤러리</title>
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
			#frame{
				padding-top: 300px;
				padding-left: 180px;
				overflow: hidden;
			}
			img{
				margin: auto;
				vertical-align: top;
				height: 200px; 
			}
			.writeBtn{
				margin-top: 50px;
				margin-left: 450px;
				padding-bottom: 10px;
			}
			.gallery-item-wrap{
				display: inline;
				margin-left:100px;
			}
			#image{
				width: 200px;
				height: 100px;
			}
			span{
				font-size: 1em;
			}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<script>
    $(document).ready(function(){
      $('.bxslider').bxSlider({
          mode:"horizontal",    
          speed:500,
          pause: 1000,
          pager:false,
          moveSlides:1,   
          slideWidth:190,   
          minSlides:6,    
          maxSlides:6,    
          slideMargin:12, 
          auto:true,         
          controls:false    
      });
    });
</script>

</head>
  <body>
  	<div id="imagewrap">
	<header>
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</header>
	<article>
		<div class="bxslider">
			<div><img src="../images/A.jpg" alt="A"></div>
			<div><img src="../images/B.jpg" alt="B"></div>
			<div><img src="../images/C.jpg" alt="C"></div>
			<div><img src="../images/D.jpg" alt="D"></div>
			<div><img src="../images/E.jpg" alt="E"></div>
			<div><img src="../images/F.jpg" alt="F"></div>
			<div><img src="../images/G.jpg" alt="G"></div>
			<div><img src="../images/H.jpg" alt="H"></div>
			<div><img src="../images/I.jpg" alt="I"></div>
			<div><img src="../images/J.jpg" alt="J"></div>
			<div><img src="../images/K.jpg" alt="K"></div>
		</div>			
	<div class="writeBtn">			
			<%
				String email = (String)session.getAttribute("email");	
				String nickname = (String)session.getAttribute("nickname");
				if(email != null && nickname != null && !"방문(카카오)".equals(email)){
			%>
				<input type="button" value="글 쓰기" onclick="location.href='galleryWrite.jsp'">
			<%
				}
			%>
	</div>
				<div class="gallery-item-box" style="">
		<%
			String realFolder = getServletContext().getRealPath("/upload");
			System.out.println("upload realFolder : " + realFolder);
			String realPath = request.getContextPath();
			System.out.println("getContextPath() realPath : " + realPath);
			GalleryDAO gDao = new GalleryDAO();
			ArrayList<GalleryBean> arr = gDao.galleryListCheck();
			for(int i = 0 ; i < arr.size() ; i++){
				GalleryBean gBean = arr.get(i);
				int num = gBean.getNum();
		%>
					<div class="gallery-item-wrap">
 							<a href="galleryIntoPro.jsp?num=<%= num %>"><img src="<%= realPath %>/upload/<%= gBean.getFile() %>" id="image"></a>
							<a href="galleryIntoPro.jsp?num=<%= num %>"><span><%= gBean.getSubject() %></span></a>
							<span><%= new SimpleDateFormat("yyyy/MM/dd").format(gBean.getDate()) %></span> | <span> <%= gBean.getReadcount() %></span>
							|<span><%= gBean.getNickname() %></span>
					</div>
		<%		
			}
		%>
				</div>
	</article>
	</div>
  </body>
</html>
