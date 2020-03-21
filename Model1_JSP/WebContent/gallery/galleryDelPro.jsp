<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));	

	GalleryDAO gDao = new GalleryDAO();
	
	int result = gDao.galleryDelete(num);
	if(result == 1){
%>
		<script>
			window.alert("삭제 성공");
			location.href="gallery.jsp";
		</script>
<% 		
	}
	else{
%>
		<script>
			window.alert("<%=result%>result<%=num%>num");
			history.back();
			</script>
<%
	}
%>
