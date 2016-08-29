package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mooplans.dao.DishDAO;
import com.mooplans.model.Cart;
import com.mooplans.model.Dishes;
import com.mooplans.model.User;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartServlet() {
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
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		Cart shoppingCart;
		shoppingCart = (Cart) session.getAttribute("cart");
		
		//allow access only if session exists		
		User user = null;
		int success = 0;
		if(session.getAttribute("User") != null){
			user = (User) session.getAttribute("User");
		}
		
		if(shoppingCart == null){
			System.out.println("Cart servlet where cart is empty");
			shoppingCart = new Cart();
			session.setAttribute("cart", shoppingCart);
		}

		String dishName = "";
		String dishId = "";
		String buttonClick  = "";
		String notes = "";
		
		float dishPrice = 0;
		float dishFullPrice = 0;
		
		try{
			buttonClick  = request.getParameter("button");
		}catch(NullPointerException ne){
			
		}
		
		if(buttonClick != null){
			dishName = request.getParameter("dishName").trim();
			dishId = request.getParameter("dishId").trim();		
			notes = request.getParameter("notes").trim();
			
			dishFullPrice = Float.parseFloat(request.getParameter("dishFullPrice"));
			dishPrice = Float.parseFloat(request.getParameter("dishPrice"));
			
			shoppingCart.addToCart(Integer.parseInt(dishId), dishName, notes, dishPrice, dishFullPrice);
		}else{
			dishId = request.getParameter("dishId").trim();
			shoppingCart.deleteFromCart(Integer.parseInt(dishId));
		}
	
		session.setAttribute("cart", shoppingCart);
		success = shoppingCart.numberOfItems();
		//response.sendRedirect(getServletContext().getContextPath()+"/jsp/cart.jsp?added=true");
		out.write(success+"");
		}
}
