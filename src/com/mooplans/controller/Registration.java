package com.mooplans.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		// TODO Auto-generated constructor stub
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

		String url = "/jsp/register.jsp";

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
			request.setAttribute("errormsg", "Fist name can not be empty");
		}
		if(emailId == null || emailId.equals("")){
			request.setAttribute("errormsg", "Username can not be empty");
			if(password == null || password.equals("")){
				request.setAttribute("errormsg", "User and Password can not be Empty..!!");
			}
		}

		if(phone == null || phone.equals("")){
			request.setAttribute("errormsg", "Phone can not be empty");
		}

		if(university == null || university.equals("")){
			request.setAttribute("errormsg", "University can not be empty");
		}

		if(address == null || address.equals("")){
			request.setAttribute("errormsg", "Address can not be empty");
		}

		else {

			System.out.println("firstname ="+firstname);
			System.out.println("lastname ="+lastname);
			System.out.println("userName ="+emailId);
			System.out.println("password ="+password);
			System.out.println("phone ="+phone);
			System.out.println("university ="+university);
			System.out.println("address ="+address);

			User userObject = new User(password, firstname, lastname, emailId, 
					phone, university, address, role, id, points);

			int ID = LoginDAO.registerUser(userObject);

			if (ID == 0) {
				System.out.println("Registraion failed ID :"+ID);
				request.setAttribute("errormsg", "Registration failed. Please try again.");
			}
			else if (ID < 0) {
				System.out.println("Registraion failed ID :"+ID);
				request.setAttribute("errormsg", "Email ID already exists.");
			}else{
				System.out.println("Registraion done success ID :"+ID);
				url = "/jsp/success.jsp";
			}
		}

		System.out.println("Validation ==>"+request.getAttribute("errormsg"));
		response.sendRedirect(getServletContext().getContextPath()+url);
	}
}
