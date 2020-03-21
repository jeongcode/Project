<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));

	GalleryDAO gDao = new GalleryDAO();
	GalleryBean gBean = new GalleryBean();
	
	int incReadCountResult = gDao.galleryIncreaseReadcount(num);
	if(incReadCountResult == 1){
		gBean = gDao.galleryInto(num);
		if(gBean != null){
			request.setAttribute("gBean",gBean);
			pageContext.forward("galleryInto.jsp");
		}
	}
%>