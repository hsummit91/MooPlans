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

import com.mooplans.dao.PayPalDAO;
import com.mooplans.model.Cart;
import com.mooplans.model.Dishes;
import com.mooplans.model.User;

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
		User user = null;
		if(session.getAttribute("User") == null)
		    url = "/login.jsp";
		else user = (User) session.getAttribute("User");
		
		if(action.equalsIgnoreCase("currentAddress")){
			name = user.getUser_firstname();
			for(Integer key: items.keySet()){
				System.out.println("Key"+items.get(key)+" value="+key);
			}
			System.out.println("Try "+user.getUser_firstname());
			System.out.println("Try "+user.getUser_address());
			System.out.println("Try "+user.getUser_phone());
			System.out.println("Points "+user.getUser_points());
		}
		
		else if(action.equalsIgnoreCase("newAddress")){
			name = request.getParameter("fullname");
			shippingAddress = request.getParameter("address");
			phone = request.getParameter("phone");
			System.out.println("New"+name);
			System.out.println("New"+shippingAddress);
			System.out.println("New"+phone);
			System.out.println("Points "+user.getUser_points());
		}
		
		// Calling PayDAO to deduct User points based on his order and make entry in the order table(s)
		PayPalDAO pp = new PayPalDAO();
		ArrayList<Dishes> userDishes = new ArrayList<Dishes>();
	//	float totalBill = pp.getBill(items);
		//pp.updateUserPoints(user, totalBill);
		
		
		//String url = "/paypal.jsp";
		
		//RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
		//dispatcher.forward(request, response);	
		
	}

}
