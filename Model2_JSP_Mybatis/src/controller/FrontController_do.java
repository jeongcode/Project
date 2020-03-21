package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.*;
import vo.ActionForward;

// Related Airplane , Member Controller

@WebServlet("*.do")
public class FrontController_do extends javax.servlet.http.HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		// 요청URL : http://localhost:8090/
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		System.out.println("FrontController command : " + command);
		
		ActionForward forward = null;
		Action action = null;
		
		if(command.equals("/airplaneSearch.do")){
			action = new AirplaneSearchAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				System.out.println("FrontController airplaneSearch.do Error : " + e);
				response.getWriter().print("<script>alert('해당하는 항공편이 없습니다.'); location.href='"+contextPath+"/home.do';</script>");
				response.getWriter().flush();
				response.getWriter().close();
			}
		}
		else if(command.equals("/airplaneReSearch.do")){
			action = new AirplaneReSearchAction();
			try {
				action.execute(request, response);
			} catch (Exception e) {
				System.out.println("FrontController airplaneReSearch.do Error : 항공 검색 실패");
			}
			return;
		}
		else if(command.equals("/memberEmailAuthNumSend.do")){
			action = new EmailAuthNumSendAction();
			try{
				action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberNicknameDuplChk.do")){
			action = new NicknameDuplChkAction();
			try{
				action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberEmailDuplChk.do")){
			action = new EmailDuplChkAction();
			try{
				action.execute(request, response);
			}
			catch(Exception e){
				System.out.println("FrontController memberEmailDuplChk.do Error : " + e);
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberLogin.do")){
			action = new MemberLoginAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberJoin.do")){
			action = new MemberJoinAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberLogout.do")){
			action = new MemberLogoutAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/adminMemberSearh.do")){
			action = new AdminMemberSearchAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/adminMemberDelete.do")){
			action = new AdminMemberDeleteAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberInfo.do")){
			action = new MemberInfoAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberDelete.do")){
			action = new MemberDeleteAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberTmpPassword.do")){
			action = new MemberTmpPasswordAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberPasswordUpdate.do")){
			action = new MemberPasswordUpdateAction();
			try{
				forward  = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/memberPasswordUpdateForm.do")){
			forward = new ActionForward();
			forward.setPath("./view/member/memberPasswordUpdateForm.jsp");
			forward.setRedirect(true);
		}
		else if(command.equals("/memberTmpPasswordForm.do")){
			forward = new ActionForward();
			forward.setPath("./view/member/memberPasswordFindForm.jsp");
			forward.setRedirect(true);
		}
		else if(command.equals("/memberLoginForm.do")){
			forward = new ActionForward();
			forward.setPath("./view/member/memberLoginForm.jsp");
			forward.setRedirect(true);
		}
		else if(command.equals("/memberJoinForm.do")){
			forward = new ActionForward();
			forward.setPath("./view/member/memberJoinForm.jsp");
			forward.setRedirect(true);
		}
		else if(command.equals("/home.do")){
			forward = new ActionForward();
			forward.setPath("./view/main/index.jsp");
			forward.setRedirect(true);
		}
		else{
			forward = new ActionForward();
			forward.setPath("./view/main/index.jsp");
			forward.setRedirect(true);
		}

		
		
		
		if(forward != null){
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}
			else{
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
	
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
}
