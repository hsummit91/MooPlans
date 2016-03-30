package com.mooplans.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mooplans.dao.LoginDAO;
import com.mooplans.model.User;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session=request.getSession();
		//String loggedIn = "false";
		String url = "/jsp/login.jsp";
		RequestDispatcher rd = null;  
		
		String emailId= request.getParameter("email");
		String password=request.getParameter("password");
		String errorMsg = "";
		Boolean isError = false;

		if(emailId == null || emailId.equals("")){
			errorMsg = "Username can not be empty";
			if(password == null || password.equals("")){
				errorMsg = "User and Password can not be empty..";
			}
		}else if(password == null || password.equals("")){
			errorMsg = "Password can not be empty..";
		}else {

			System.out.println("userName ="+emailId);
			System.out.println("password ="+password);

			int ID = LoginDAO.checkUserDetails(emailId, password);

			System.out.println("ID ####> "+ID);

			if (ID == 0) {
				errorMsg = "Username and Password does not match..";
			}else{
	            session.setAttribute("user", emailId);
	            session.setAttribute("userId", ID);
	            //setting session to expiry in 30 mins
	            session.setMaxInactiveInterval(30*60);
	            Cookie userName = new Cookie("user", emailId);
	            userName.setMaxAge(30*60);
	            response.addCookie(userName);

	          //  loggedIn = "true";
				//session.setAttribute("loggedIn", loggedIn);
				User u = LoginDAO.getDetails(ID);
				session.setAttribute("User", u);
				if(u.getUser_role().equalsIgnoreCase("student")){
					url = "/jsp/home.jsp";
				}
				// for future work
				else if(u.getUser_role().equalsIgnoreCase("restaurant")){
					url = "/jsp/restaurant.jsp";
				}
			}
		}

		System.out.println("errorMsg ==>"+errorMsg);
		System.out.println("Session Validation ==>"+session.getAttribute("user"));
		
		if(errorMsg != ""){
			isError = true;
		}
		//rd = request.getRequestDispatcher(url);
		//rd.forward(request, response);
		response.sendRedirect(getServletContext().getContextPath()+url+"?errorMsg="+errorMsg+"&isError="+isError);
	}
}
