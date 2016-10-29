package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mooplans.dao.PayPalDAO;
import com.mooplans.model.StartupData;
import com.mooplans.model.User;

/**
 * Servlet implementation class OrderServletAPI
 */
@WebServlet("/OrderServletAPI")
public class OrderServletAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	static Logger log = Logger.getLogger(OrderServletAPI.class.getName());
	
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
		HashMap<Integer, Integer> cQty = new HashMap<Integer, Integer>();
		
		String shoppingCart = null;
		String name = null;
		String shippingAddress = null;
		String phone = null;
		String time = null;
		int userId = 0;
		
		float finalBill = 0;
		float finalPoints = 0;
		String checkout = "";
		float totalBill = 0;
		String message = null;
		
		User user = null;
		
		if(action.equalsIgnoreCase("placeOrder")){
			
			log.info("action called :: placeOrder");
			
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
				        int qty = (int) cartObject.get("qty");
				        
				        log.info("cart :: id=["+id+"], item=["+item+"], notes=["+note+"], qty=["+qty+"]");
				        
				        items.put(id, item);
				        notes.put(id, note);
				        cQty.put(id, qty);
				    }
					
				}
			}catch (JSONException e) {
					log.error("error while getting cart data ",e);
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
				finalBill = Float.parseFloat(request.getParameter("finalBill"));
			}catch(Exception e){
				finalBill = 0;
			}
			
			try{
				finalPoints = Float.parseFloat(request.getParameter("finalPoints"));
			}catch(Exception e){
				finalPoints = 0;
			}
						
			try{
				checkout = request.getParameter("checkoutType");
			}catch(Exception e){
				checkout = "points";
			}
			
			if(checkout.equals("points")){
				totalBill = finalPoints; 
			}else if(checkout.equals("cash")){
				totalBill = finalBill;
			}
			
			log.info("order user data :: userId=["+userId+"], name=["+name+"], address=["+shippingAddress+"], "
					+ "time=["+time+"], phone=["+phone+"], checkout=["+checkout+"] totalBill=["+totalBill+"]");
			
			user.setDelivery_time(time);
			user.setUser_address(shippingAddress);
		}

		// Calling PayDAO to deduct User points based on his order and make entry in the order table(s)
		
		boolean pointsDeducted = false;
		if(checkout.equals("cash")){
			pointsDeducted = true;
		}else{
			pointsDeducted = PayPalDAO.updateUserPoints(user, items, totalBill);
		}
		
		JSONObject returnObject = new JSONObject();
		int success = 0;
		if(pointsDeducted){
			// Create the new order and update order table
			int orderId = PayPalDAO.createOrder(user, items, notes, checkout, totalBill, cQty);
			
			if(orderId <= 0){
				items.clear();
				message = "Something went wrong please try ordering again";
			}else{
				message = "Thank you for your purchase. Your Order #"+orderId;
				success = 1;
				try {
					returnObject.put("totalBill", String.valueOf(totalBill));
				} catch (JSONException e) {
					e.printStackTrace();
				}
			}

		}else{
			items.clear();
			message = "Not enough points. Please add points";
		}
		
		try {
			returnObject.put("deliveryTime", time);
			returnObject.put("deliveryAddress", shippingAddress);			
			returnObject.put("paymentMode", checkout);
			returnObject.put("message", message);
			returnObject.put("success", success);
		} catch (JSONException e) {
			log.error("error while returning data to user ",e);
			e.printStackTrace();
		}
		response.setContentType("application/json");
		out.write(returnObject+"");		
	}

}
