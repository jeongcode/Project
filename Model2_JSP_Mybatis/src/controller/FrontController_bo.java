package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;
import action.*;

// Related QnA Controller

@WebServlet("*.bo")
public class FrontController_bo extends javax.servlet.http.HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		// 요청URL : http://localhost:8090/
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		System.out.println("FrontController contextPath : " + contextPath);
		System.out.println("FrontController command : " + command);
			
		ActionForward forward = null;
		Action action = null;
			
		if(command.equals("/QnaWriteForm.bo")){
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./view/qna/qnaWriteForm.jsp");
		}
		else if(command.equals("/QnaWrite.bo")){
			action = new QnaWriteAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/qnaList.bo")){
			action = new QnaListAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/qnaInfo.bo")){
			action = new QnaInfoAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/qnaDelete.bo")){
			action = new QnaDeleteAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/qnaRewrite.bo")){
			action = new QnaRewriteAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/adminQnaSearch.bo")){
			action = new QnaListAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/adminPaymentSearch.bo")){
			action = new PaymentAllSelectAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/replyWrite.bo")){
			action = new ReplyWriteAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/replyDelete.bo")){
			action = new ReplyDeleteAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/paymentInsert.bo")){
			action = new PaymentInsertAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/paymentSelect.bo")){
			action = new PaymentSelectAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/paymentAllSelect.bo")){
			action = new PaymentAllSelectAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/unreadPaymentQnaCount.bo")){
			action = new UnreadPaymentQnaCountAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/unreadPaymentQnaList.bo")){
			action = new UnreadPaymentQnaSelectAction();
			try{
				forward = action.execute(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
			}
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

