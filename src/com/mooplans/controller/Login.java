package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.mooplans.dao.LoginDAO;
import com.mooplans.model.Image;
import com.mooplans.model.User;

import org.apache.log4j.Logger;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static Logger log = Logger.getLogger(Login.class.getName());
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
		
		PrintWriter out = response.getWriter();
		
		HttpSession session=request.getSession();
		String url = "/index.jsp";
		
		String emailId= request.getParameter("email");
		String password=request.getParameter("password");
		String pay=request.getParameter("pay");
		String app = "web";
		int ID = 0;
		
		try{
			app = request.getParameter("app");
		}catch(Exception e){
			// request from web app
			app = "web";
		}
		if(app == null){
			app = "web";
		}
		
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
			ID = LoginDAO.checkUserDetails(emailId, password);
			
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
				}else{
					if(u.getUser_role().equalsIgnoreCase("student")){
						url = "/jsp/home.jsp";
					}else if(u.getUser_role().equalsIgnoreCase("restaurant")){ // Added for new build
						url = "/restaurant/index.jsp";
					}else if(u.getUser_role().equalsIgnoreCase("admin")){ // Added for new build
						url = "/admin/index.jsp";
					}
				}
			}
		}
		
		ArrayList<Image> images = new ArrayList<Image>();
		images = LoginDAO.getCodeImages();
		session.setAttribute("images", images);

		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		
		log.info("LOGIN :: username=["+emailId+"] userId=["+ID+"] pay=["+pay+"] app=["+app+"] login at=["+dateFormat.format(new Date())+"]");
		
		if(errorMsg != ""){
			isError = true;
		}

		if(app.equals("ios")){
			JSONObject loginArray = new JSONObject();
			try {
				loginArray.put("userEmail", emailId);
				loginArray.put("userId", ID);
				loginArray.put("Error", errorMsg);
				loginArray.put("isError", isError);
			} catch (JSONException e) {
				e.printStackTrace();
			}
			response.setContentType("application/json");
			out.write(loginArray+"");
		}else{
			response.sendRedirect(getServletContext().getContextPath()+url+"?errorMsg="+URLEncoder.encode(errorMsg)+"&isError="+isError+"&pay="+pay);
		}
		
	}
}
