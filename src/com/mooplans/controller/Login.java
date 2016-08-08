package com.mooplans.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mooplans.dao.LoginDAO;
import com.mooplans.model.Image;
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
	@SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session=request.getSession();
		String url = "/jsp/login.jsp";
		
		String emailId= request.getParameter("email");
		String password=request.getParameter("password");
		String pay=request.getParameter("pay");
		
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
			System.out.println("Checking for pay-->"+pay);

			if (ID == 0) {
				errorMsg = "Username and Password does not match..";
			}else{
	            session.setAttribute("user", emailId);
	            session.setAttribute("userId", ID);
	            //setting session to expiry in 30 mins
	            session.setMaxInactiveInterval(10*60);
	            Cookie userName = new Cookie("user", emailId);
	            userName.setMaxAge(10*60);
	            response.addCookie(userName);

				User u = LoginDAO.getDetails(ID);
				String address = u.getUser_address();
				session.setAttribute("userAddress", address);
				session.setAttribute("User", u);
				if(!pay.equals("0")){
					url = "/jsp/addPoints.jsp";
					System.out.println("NOT NULL = "+pay);
				}else{
					System.out.println("###NULL===");
					if(u.getUser_role().equalsIgnoreCase("student")){
						url = "/jsp/home.jsp";
					}else if(u.getUser_role().equalsIgnoreCase("restaurant")){ // for future work
						url = "/restaurant/index.jsp";
					}
				}
			}
		}
		
		ArrayList<Image> images = new ArrayList<Image>();
		images = LoginDAO.getCodeImages();
		session.setAttribute("images", images);

		System.out.println("errorMsg ==>"+errorMsg);
		System.out.println("Session Validation ==>"+session.getAttribute("user"));
		
		if(errorMsg != ""){
			isError = true;
		}
		//rd = request.getRequestDispatcher(url);
		//rd.forward(request, response);
		response.sendRedirect(getServletContext().getContextPath()+url+"?errorMsg="+URLEncoder.encode(errorMsg)+"&isError="+isError+"&pay="+pay);
	}
}
