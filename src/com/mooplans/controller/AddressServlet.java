package com.mooplans.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.mooplans.dao.PayPalDAO;
import com.mooplans.dao.SMSTwillio;
import com.mooplans.model.Cart;
import com.mooplans.model.User;
import com.twilio.sdk.TwilioRestException;

/**
 * Servlet implementation class AddOrderShippingAddressServlet
 */
@WebServlet("/AddressServlet")
public class AddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static Logger log = Logger.getLogger(AddressServlet.class.getName());
	
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
		HashMap<Integer, String> notes = shoppingCart.getCartNotes();
		HashMap<Integer, Integer> cQty = shoppingCart.getCartQty();
		String name = null;
		String shippingAddress = null;
		String phone = null;
		String url = null;
		String message = null;
		String time = null;
		User user = null;
		float finalBill = 0;
		float finalPoints = 0;
		String checkout = "";
		
		if(session.getAttribute("User") == null){
			url = "/login.jsp";
		}else{
			user = (User) session.getAttribute("User");
		}

		if(action.equalsIgnoreCase("currentAddress")){
			name = user.getUser_firstname();
		}else if(action.equalsIgnoreCase("newAddress")){
			shippingAddress = request.getParameter("address");
			time = request.getParameter("time");
			checkout = request.getParameter("checkoutType");
			finalBill = Float.parseFloat(request.getParameter("finalBill"));
			finalPoints = Float.parseFloat(request.getParameter("finalPoints"));

			user.setDelivery_time(time);
			user.setUser_address(shippingAddress);
		}
		
		log.info("request for order : time=["+time+"], checkout=["+checkout+"], finalBill=["+finalBill+"], finalPoints=["+finalPoints+"] from user= "+user.getUser_email());
		
		// Calling PayDAO to deduct User points based on his order and make entry in the order table(s)

		float totalBill = 0;

		if(checkout.equals("points")){
			totalBill = finalPoints; 
		}else if(checkout.equals("cash")){
			totalBill = finalBill;
		}
		boolean pointsDeducted = false;
		if(checkout.equals("cash")){
			pointsDeducted = true;
		}else{
			pointsDeducted = PayPalDAO.updateUserPoints(user, items, totalBill);
		}

		if(pointsDeducted){
			// Create the new order and update order table
			int orderId = PayPalDAO.createOrder(user, items, notes, checkout, totalBill, cQty);
			
			if(orderId <= 0){
				log.info("Order failed for  user "+user.getUser_email());
				url = "/jsp/OrderError.jsp";
				items.clear();
				message = "Error placing order. Please try placing the order again.";
				session.setAttribute("errMessage", message);
			}else{
				log.info("Order successful for order# "+orderId);
				url = "/jsp/orderSummary.jsp";
				message = "Thank you for your purchase. Your Order #"+orderId;

				try{
					SMSTwillio.sendSMS(user, orderId);
				}catch(TwilioRestException e){
					log.error("SMS NOT SENT with orderId: "+user.getUser_id()+" user_id: "+user.getUser_id()+" for number: "+user.getUser_phone());
					log.error("error while sending sms :: ",e);
					e.printStackTrace();
				}

				session.setAttribute("deliveryTime", time);
				session.setAttribute("deliveryAddress", shippingAddress);
				session.setAttribute("paymentMode", checkout);
				session.setAttribute("totalBill", String.valueOf(totalBill));
				session.setAttribute("message", message);
			}

		}else{
			url = "/jsp/OrderError.jsp";
			items.clear();
			message = "Not enough points. Please purchase a meal plan or check-out using cash";
			session.setAttribute("errMessage", message);
		}
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		dispatcher.forward(request, response);	

	}

}