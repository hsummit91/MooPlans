package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mooplans.dao.DishDAO;
import com.mooplans.dao.PayPalDAO;
import com.mooplans.model.Cart;
import com.mooplans.model.StartupData;
import com.mooplans.model.User;

/**
 * Servlet implementation class OrderServletAPI
 */
@WebServlet("/OrderServletAPI")
public class OrderServletAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServletAPI() {
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
		
		HashMap<Integer, String> items = new HashMap<Integer, String>();		
		HashMap<Integer, String> notes = new HashMap<Integer, String>();
		
		String shoppingCart = null;
		String name = null;
		String shippingAddress = null;
		String phone = null;
		String paymentMode = "";
		String time = null;
		int userId = 0;
		
		String message = null;
		
		User user = null;
		
		if(action.equalsIgnoreCase("placeOrder")){
			
			shoppingCart = request.getParameter("cart");
			JSONArray cartArray = null;
			try {
				cartArray = new JSONArray(shoppingCart);
				if(shoppingCart != null){
				    for (int i = 0; i < cartArray.length(); i++) {
				        JSONObject cartObject = cartArray.getJSONObject(i);
				        
				        int id = (int) cartObject.get("id");
				        String item = (String) cartObject.get("item");
				        String note = (String) cartObject.get("notes");
				        
				        items.put(id, item);
				        notes.put(id, note);
				    }
					
				}
			}catch (JSONException e) {
					e.printStackTrace();
			}
			userId = Integer.parseInt(request.getParameter("userId"));
			
			StartupData sd = StartupData.getInstance();
			user = sd.getUserDataById(userId);
			
			name = request.getParameter("name");
			shippingAddress = request.getParameter("address");
			time = request.getParameter("time");
			phone = request.getParameter("phone");
			
			try{
				paymentMode = request.getParameter("paymentMode");
			}catch(Exception e){
				paymentMode = "points";
			}
			user.setDelivery_time(time);
			user.setUser_address(shippingAddress);
		}

		// Calling PayDAO to deduct User points based on his order and make entry in the order table(s)
		float totalBill = 0;
		for(Integer key: items.keySet()){
			System.out.println("Key"+items.get(key)+" value="+key);
			// Get all Dish Points here and prepare Bill
			totalBill += PayPalDAO.getBill(key); 
		}
		
		boolean pointsDeducted = PayPalDAO.updateUserPoints(user, items, totalBill);
		JSONObject returnObject = new JSONObject();
		int success = 0;
		if(pointsDeducted){
			// Create the new order and update order table
			int orderId = PayPalDAO.createOrder(user, items, notes, paymentMode, totalBill);
			
			message = "Thank you for your purchase. Your Order #"+orderId;
			success = 1;
			try {
				returnObject.put("totalBill", String.valueOf(totalBill));
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}else{
			items.clear();
			message = "Not enough points. Please add points";
		}
		
		try {
			returnObject.put("message", message);
			returnObject.put("success", success);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		response.setContentType("application/json");
		out.write(returnObject+"");		
	}

}
