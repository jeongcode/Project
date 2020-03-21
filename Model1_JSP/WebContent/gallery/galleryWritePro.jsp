<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	// 업로드
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
	
	String flag = ""; 
	
	// 다운로드 
/* 	response.setContentType("Application/x-msdownload");
	response.setHeader("Content-Disposition", "attachment:filename="+fileName);
	File file = new File(realFolder + "/" + new String(fileName.getBytes("8859_1"),"UTF-8"));
	byte[] data = new byte[1024];
	if(file.isFile()){
		try{
			BufferedInputStream input = new BufferedInputStream(new FileInputStream(file));
			BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream());
			int read;
			while((read = input.read(data)) != -1){
				output.write(data, 0 , read);
			}
			output.flush();
			output.close();
			input.close();
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}
 */	
	
	// DB접근
 	if(fileName != null || fileName != ""){
		String email = multi.getParameter("email");
		String nickname = multi.getParameter("nickname");
		String passwd = multi.getParameter("passwd");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content"); 

		GalleryBean gBean = new GalleryBean();
/* 		String email = request.getParameter("email");
		String nickname = request.getParameter("nickname");
		String passwd = request.getParameter("passwd");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content"); 
		String fileName = request.getParameter("file");
 */		gBean.setEmail(email);
		gBean.setNickname(nickname);
		gBean.setPasswd(passwd);
		gBean.setSubject(subject);
		gBean.setContent(content);
		gBean.setFile(fileName);
		gBean.setDate(new Timestamp(System.currentTimeMillis()));
		GalleryDAO gDao = new GalleryDAO();
		int result = gDao.galleryWrite(gBean);
		if(result == 1){
			%>
				<script>
					window.alert("글쓰기 완료");
					location.href="gallery.jsp";
				</script>
			<%
		}
		else{
			%>
				<script>
					window.alert("글쓰기 실패");
					history.back();
				</script>
		<%
		}
 	}
%>	
	

			