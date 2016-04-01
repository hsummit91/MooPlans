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
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		Cart shoppingCart;
		shoppingCart = (Cart) session.getAttribute("cart");

		if(shoppingCart == null){
			System.out.println("Cart servlet where cart is null");
			shoppingCart = new Cart();
			session.setAttribute("cart", shoppingCart);
		}

		int dishId = Integer.parseInt(request.getParameter("dishId"));
		String dishName = request.getParameter("dishName");
		Float dishPoints = Float.parseFloat(request.getParameter("dishPoints"));
		//int quantity = Integer.parseInt(request.getParameter("quantity"));
		System.out.println("Ordered ID item "+dishName+" for points "+dishPoints);
		shoppingCart.addToCart(dishId, dishName);
		session.setAttribute("cart", shoppingCart);
		try (PrintWriter out = response.getWriter()) {
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Cart</title>");            
			out.println("</head>");
			out.println("<body>");
			out.println("<h1>Meal successfully added to cart </h1>");
			out.println("<a href="+request.getContextPath()+"/ActionServlet?action=restPage><input type='submit' value='Add more Items'></a>");
			out.println("<hr>");
			out.println("<h2>Cart</h2>");
			HashMap<Integer, String> items = shoppingCart.getCartItems();
			out.println("<table border='1px'>");

			out.println("<th>Food Item</th>");
			for(Integer key: items.keySet()){
				out.println("<form action='CartServlet' method='doGet'><input type='hidden' name='itemId' value='"+key+"'>"
						+ "<tr><td>"+items.get(key)+"</td><td><input type='submit' value='delete'></td></tr></form>");
			}
			out.println("</table>");
			out.println("<a href="+request.getContextPath()+"/jsp/checkout.jsp><input type='submit' value='Proceed Checkout'></a>");
			out.println("</body>");
			out.println("</html>");
		  }
		}
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		System.out.println("in process");
        response.setContentType("text/html;charset=UTF-8");
        int itemId = Integer.parseInt(request.getParameter("itemId"));
          HttpSession session = request.getSession();
        Cart shoppingCart;
        shoppingCart = (Cart) session.getAttribute("cart");
        shoppingCart.deleteFromCart(itemId);
        session.setAttribute("cart", shoppingCart);
         shoppingCart = (Cart) session.getAttribute("cart");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Delete Item</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Meal successfully deleted from cart </h1>");
			out.println("<a href="+request.getContextPath()+"/ActionServlet?action=restPage><input type='submit' value='Add more Items'></a>");
            HashMap<Integer, String> items = shoppingCart.getCartItems();
            System.out.println("Size "+items.size());
            out.println("<table border='1px'>");
             
            out.println("<th>Food Item</th>");
			for(Integer key: items.keySet()){
				out.println("<form action='CartServlet' method='doGet'><input type='hidden' name='itemId' value='"+key+"'>"
						+ "<tr><td>"+items.get(key)+"</td><td><input type='submit' value='delete'></td></tr></form>");
			}
			out.println("</table>");
			out.println("<a href="+request.getContextPath()+"/jsp/checkout.jsp><input type='submit' value='Proceed Checkout'></a>");
			out.println("</body>");
			out.println("</html>");
        }
    }
}
