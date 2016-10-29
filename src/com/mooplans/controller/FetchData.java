package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mooplans.dao.DishDAO;
import com.mooplans.dao.LoginDAO;
import com.mooplans.dao.OrderDAO;
import com.mooplans.model.Cart;

/**
 * Servlet implementation class FetchData
 */
@WebServlet("/FetchData")
public class FetchData extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	static Logger log = Logger.getLogger(FetchData.class.getName());
	
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
		HttpSession session = request.getSession();
		Cart shoppingCart = (Cart) session.getAttribute("cart");
		
		if(action == null){
			action = "";
		}
		
		if(action.equals("getUserDetails")){
			int userId = Integer.parseInt(request.getParameter("userId"));
			log.info("Action called :: getUserDetails -- userId="+userId);
			
			JSONObject userDetails = LoginDAO.getUserDetails(userId);
	        response.setContentType("application/json");
	        out.write(userDetails+"");
		}else if(action.equals("getPastOrders")){
			int userId = Integer.parseInt(request.getParameter("userId"));
			log.info("Action called :: getPastOrders -- userId="+userId);
			
			JSONArray userDetails = OrderDAO.getPastOrders(userId);
	        response.setContentType("application/json");
	        out.write(userDetails+"");
		}else if(action.equals("cartJson")){
			log.info("Action called :: cartJson");
			JSONArray cartArray = shoppingCart.getCartArray();
			response.setContentType("application/json");
			out.write(cartArray+"");
		}else if(action.equals("firstTimeData")){
			int userId = Integer.parseInt(request.getParameter("userId"));
			String gender= request.getParameter("gender");
			String allergies=request.getParameter("allergies");
			String diet= request.getParameter("diet");
			String cuisine=request.getParameter("cuisine");
			
			log.info("Action called :: firstTimeDate -- userId="+userId);
			
			JSONObject updateData = LoginDAO.updateUserFirstTimeData(gender, allergies, diet, cuisine, userId);
			response.setContentType("application/json");
			out.write(updateData+"");
		}else if(action.equals("getMealChoices")){
			int dishId = Integer.parseInt(request.getParameter("dishId"));
			
			log.info("Action called :: getMealChoices -- dishId="+dishId);
			JSONArray menuList = DishDAO.getMealChoices(dishId);	
			response.setContentType("application/json");
			out.write(menuList+"");			
		}else if(action.equals("getallOrders")){
			
			JSONArray menuList = OrderDAO.getAllOrders();	
			response.setContentType("application/json");
			out.write(menuList+"");	
		}else{
			response.sendRedirect(getServletContext().getContextPath()+"/jsp/home.html");
		}
	}

}
