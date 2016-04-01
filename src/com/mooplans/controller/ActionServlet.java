package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mooplans.dao.DishDAO;
import com.mooplans.model.Cart;
import com.mooplans.model.Dishes;
import com.mooplans.model.Restaurant;

/**
 * Servlet implementation class ActionServlet
 */
@WebServlet("/ActionServlet")
public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ActionServlet() {
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
		System.out.println("Action called "+action);
		
		if(action.equalsIgnoreCase("restPage")){
			System.out.println("In Rest action");
			ArrayList<Restaurant> restList = new ArrayList<Restaurant>();
			restList = DishDAO.getRestnames();
			request.setAttribute("restList", restList);
			getServletConfig().getServletContext().getRequestDispatcher("/jsp/orders.jsp").forward(request,response);
		}
		
		if(action.equalsIgnoreCase("menuPage")){
			System.out.println("In Menu action");
			HttpSession session = request.getSession();
			Cart shoppingCart;
			shoppingCart = (Cart) session.getAttribute("cart");
			if(shoppingCart == null){
				System.out.println("Menu servlet where cart is null");
				shoppingCart = new Cart();
				session.setAttribute("cart", shoppingCart);
			}

			String restName = request.getParameter("restName");
			System.out.println("Selected restaurant: "+restName);

			ArrayList<Dishes> menuList = new ArrayList<Dishes>();
			menuList = DishDAO.getDishDetailsByName(restName);	
			request.setAttribute("menuList", menuList); 
			getServletConfig().getServletContext().getRequestDispatcher("/jsp/menu.jsp").forward(request,response);
		}
	}
}
