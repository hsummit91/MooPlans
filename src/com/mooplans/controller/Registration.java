package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

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
		
		PrintWriter out = response.getWriter();
		
		String url = "/index.jsp";
		String pay = "";
		String errorMsg = "";
		Boolean isError = false;
		int ID = 0;
		String app = "web";
		
		try{
			app = request.getParameter("app");
		}catch(Exception e){
			// request from web app
			app = "web";
		}
		if(app == null){
			app = "web";
		}
		
		try{
			pay = request.getParameter("pay");
			if(pay == null){
				pay = "0";
			}
			System.out.println("====>"+pay+"<====");
		}catch(Exception e){
			
		}
		String firstname= request.getParameter("firstname");
		String lastname= request.getParameter("lastname");;
		String emailId= request.getParameter("email");
		String password=request.getParameter("password");
		String phone=request.getParameter("phone");
		String university= request.getParameter("university");
		String address= "";
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

/*		if(address == null || address.equals("")){
			errorMsg =  "Address can not be empty";
		}*/

		else {

			User userObject = new User(password, firstname, lastname, emailId, 
					phone, university, address, role, id, points);

			ID = LoginDAO.registerUser(userObject);

			if (ID == 0) {
				errorMsg =  "Registration failed, please try again";
			}else if (ID < 0) {
				errorMsg = "Email ID already registered";
			}else{
				// Sending welcome email to user
				final User user = new User();
				user.setUser_firstname(firstname);
				user.setUser_email(emailId);
				
				new Thread(new Runnable() {
				    public void run() {
				    	EmailDAO.sendMail(user, 1, 0);
				    }
				}).start();
				
				// Set success message
				System.out.println("Registraion done success ID :"+ID);
				url = "/index.jsp";
				errorMsg="";
				isError=false;
				//pay="0";
			}
		}
		
		if(errorMsg != ""){
			isError = true;
		}
		
		if(app.equals("ios")){
			JSONObject rigisterArray = new JSONObject();
			try {
				rigisterArray.put("userEmail", emailId);
				rigisterArray.put("success", ID);
				rigisterArray.put("firstName", firstname);
				rigisterArray.put("lastName", lastname);
				rigisterArray.put("phone", phone);
				rigisterArray.put("address", address);
				rigisterArray.put("university", university);
				rigisterArray.put("Error", errorMsg);
				rigisterArray.put("userId", ID);
				rigisterArray.put("isError", isError);
			} catch (JSONException e) {
				e.printStackTrace();
			}
			response.setContentType("application/json");
			out.write(rigisterArray+"");
		}else{		
			response.sendRedirect(getServletContext().getContextPath()+url+"?errorMsg="+URLEncoder.encode(errorMsg)+"&isError="+isError+"&pay="+pay);
		}
	}
}