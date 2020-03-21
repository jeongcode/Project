<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String realFolder = getServletContext().getRealPath("/upload");
	int maxSize = 10 * 1024 * 1024;
	MultipartRequest multi = new MultipartRequest(request ,realFolder,maxSize,"UTF-8",new DefaultFileRenamePolicy());
	System.out.println(realFolder);
	Enumeration formNames = multi.getFileNames();
	String formName = (String)formNames.nextElement(); 
	String fileName = multi.getFilesystemName(formName);
	String originFileName = multi.getOriginalFileName(formName);
	System.out.println("realFolder : " + realFolder);
	System.out.println("fileName : " + fileName);
	System.out.println("originFileName : " + originFileName);
	
	
		String email = multi.getParameter("email");
		String nickname = multi.getParameter("nickname");
		String passwd = multi.getParameter("passwd");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content"); 
		GalleryBean gBean = new GalleryBean();
		gBean.setNum(Integer.parseInt(multi.getParameter("num")));
		gBean.setEmail(email);
		gBean.setNickname(nickname);
		gBean.setPasswd(passwd);
		gBean.setSubject(subject);
		gBean.setContent(content);
		gBean.setFile(fileName);
	// 이미지 수정 하지 않을 시 기존에있는 originFile을 넘겨줌
	if(gBean.getFile() == null){
		gBean.setFile(multi.getParameter("originFile"));
	}
	System.out.println(gBean.toString());
	
	GalleryDAO gDao = new GalleryDAO();
	int result = gDao.galleryReWrite(gBean);
	if(result == 1){
%>
		<script>
			window.alert("수정 완료");
			location.href="gallery.jsp";
		</script>
<%
	}
	else{
%>
		<script>
			window.alert("수정 실패");
			history.back();
		</script>
<%		
	}
%>