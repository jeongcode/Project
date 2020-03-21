<%@page import="chat.ChatDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	response.setCharacterEncoding("utf-8");
	String kakaoAuth = request.getParameter("kakaoAuth");
	if("yes".equals(kakaoAuth)){
		session.setAttribute("email","방문(카카오)");
		session.setAttribute("nickname","방문(카카오)");
		%>
		<script>
			location.href="../index.jsp";
		</script>
		<%
	}
	else{
	String userEmail = request.getParameter("useremail");
	String userPasswd = request.getParameter("userpasswd");
	
	MemberDAO mDAO = new MemberDAO();
	
	MemberBean mBean = mDAO.loginChkMember(userEmail, userPasswd);
	String nickname = mBean.getNickname();
	String name = mBean.getName();
	String email = mBean.getEmail();
	
	// 로그인 성공 시 이름 , 이메일 , 별명 session에 저장
	if( nickname != null ){
		session.setAttribute("nickname", nickname);
		session.setAttribute("email", email);
		ChatDAO cDao = new ChatDAO();
		//로그인 성공 시 기존에 있던 email을 매개변수 fromID 로 전송
		int result = cDao.chatReadCheck(email);
		System.out.println("loginPro.jsp result : " + result);
		if(result > 0){
			session.setAttribute("read","NOREAD");
		}
		%>
			<script>
				window.alert("정상 로그인");
				location.href="../index.jsp";
			</script>
		<%
	}
	else{
		%>
			<script>
				window.alert("아이디와 비밀번호가 일치하지 않습니다");
				location.href="login.jsp";
			</script>
		<%
	}
}

%>