package com.mooplans.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mooplans.dao.EmailDAO;
import com.mooplans.dao.PayPalDAO;
import com.mooplans.model.Cart;
import com.mooplans.model.Dishes;
import com.mooplans.model.Order;
import com.mooplans.model.User;
import com.mooplans.dao.NotificationSystem;

/**
 * Servlet implementation class AddOrderShippingAddressServlet
 */
@WebServlet("/AddressServlet")
public class AddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddressServlet() {
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

		String action = request.getParameter("action");
		HttpSession session = request.getSession();
		Cart shoppingCart;
		shoppingCart = (Cart) session.getAttribute("cart");
		HashMap<Integer, String> items = shoppingCart.getCartItems();
		String name = null;
		String shippingAddress = null;
		String phone = null;
		String url = null;
		String message = null;
		String time = null;
		User user = null;
		if(session.getAttribute("User") == null)
			url = "/login.jsp";
		else user = (User) session.getAttribute("User");

		
		if(action.equalsIgnoreCase("currentAddress")){
			name = user.getUser_firstname();
			for(Integer key: items.keySet()){
				System.out.println("Key"+items.get(key)+" value="+key);
			}
		}else if(action.equalsIgnoreCase("newAddress")){
			shippingAddress = request.getParameter("address");
			time = request.getParameter("time");
			
/*			int hr = time.charAt(0);
			int hr1 = hr - 1;
			String mins = "";
			if(time.charAt(2) == 0){
				mins = "45";
			}else if(time.charAt(2) == 3){
				mins = "15";
			}*/
			
/*			System.out.println("DELIVERY TIME: "+time);
			System.out.println("PREPARATION TIME: "+ hr1 +":"+ mins);*/
			
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
		
		boolean pointsDeducted = PayPalDAO.updateUserPoints(user, items);
		if(pointsDeducted){
			// Create the new order and update order table
			int orderId = PayPalDAO.createOrder(user, items);
			
//			new Thread(new Runnable() {
//			    public void run() {
			    	//EmailDAO.sendOrderMailRest(user, items, orderId);
					//EmailDAO.sendOrderMailUser(user, items, orderId);
//			    }
//			}).start();
			
			
			url = "/jsp/orderSummary.jsp";
			message = "Thank you for your purchase. Your Order #"+orderId;
			session.setAttribute("totalBill", String.valueOf(totalBill));
			session.setAttribute("message", message);
		}else{
			url = "/jsp/addPoints.jsp";
			items.clear();
			message = "Not enough points. Please add points";
			session.setAttribute("errMessage", message);
		}
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);	

	}

}