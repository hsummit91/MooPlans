package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mooplans.dao.LoginDAO;
import com.mooplans.dao.OrderDAO;

/**
 * Servlet implementation class FetchData
 */
@WebServlet("/FetchData")
public class FetchData extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FetchData() {
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
		PrintWriter out = response.getWriter();
		
		String action = request.getParameter("action");
		
		if(action == null){
			action = "";
		}
		
		if(action.equals("getUserDetails")){
			int userId = Integer.parseInt(request.getParameter("userId"));
			
			JSONObject userDetails = LoginDAO.getUserDetails(userId);
	        response.setContentType("application/json");
	        out.write(userDetails+"");
		}else if(action.equals("getPastOrders")){
			int userId = Integer.parseInt(request.getParameter("userId"));
			
			JSONArray userDetails = OrderDAO.getPastOrders(userId);
	        response.setContentType("application/json");
	        out.write(userDetails+"");
		}else{
			response.sendRedirect(getServletContext().getContextPath()+"/jsp/home.html");
		}
	}

}
