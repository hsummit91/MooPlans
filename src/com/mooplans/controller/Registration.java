package com.mooplans.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mooplans.dao.EmailDAO;
import com.mooplans.dao.LoginDAO;
import com.mooplans.model.User;

/**
 * Servlet implementation class Registration
 */
@WebServlet("/Registration")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Registration() {
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

		String url = "/jsp/register.jsp";
		String pay = "";
		String errorMsg = "";
		Boolean isError = false;
		
		try{
			pay = request.getParameter("pay");
			if(pay == null){
				pay = "0";
			}
			System.out.println("====>"+pay+"<====");
		}catch(Exception e){
			
		}
		String firstname= request.getParameter("firstname");
		String lastname=request.getParameter("lastname");
		String emailId= request.getParameter("email");
		String password=request.getParameter("password");
		String phone=request.getParameter("phone");
		String university= request.getParameter("university");
		String address=request.getParameter("address");
		String role = "student";
		int points = 0;
		int id = 0;

		if(firstname == null || firstname.equals("")){
			errorMsg = "Fist name can not be empty";
		}
		if(emailId == null || emailId.equals("")){
			errorMsg =  "Username can not be empty";
			if(password == null || password.equals("")){
				errorMsg = "User and Password can not be Empty..!!";
			}
		}

		if(phone == null || phone.equals("")){
			errorMsg = "Phone can not be empty";
		}

		if(university == null || university.equals("")){
			errorMsg = "University can not be empty";
		}

		if(address == null || address.equals("")){
			errorMsg =  "Address can not be empty";
		}

		else {

			User userObject = new User(password, firstname, lastname, emailId, 
					phone, university, address, role, id, points);

			int ID = LoginDAO.registerUser(userObject);

			if (ID == 0) {
				errorMsg =  "Registration failed, please try again";
			}
			else if (ID < 0) {
				errorMsg = "Email ID already registered";
			}else{
				// Sending welcome email to user
				User user = new User();
				user.setUser_firstname(firstname);
				user.setUser_email(emailId);
				EmailDAO.sendMail(user, 1, 0);
				
				// Set success message
				System.out.println("Registraion done success ID :"+ID);
				url = "/jsp/login.jsp?errorMsg=Registration_Successful&isError=true&pay="+pay;
			}
		}
		
		if(errorMsg != ""){
			isError = true;
		}
		response.sendRedirect(getServletContext().getContextPath()+url+"?errorMsg="+URLEncoder.encode(errorMsg)+"&isError="+isError+"&pay="+pay);
	}
}
