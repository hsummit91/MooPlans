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
import com.mooplans.dao.EmailDAO;
import com.mooplans.dao.PayPalDAO;
import com.mooplans.model.Cart;
import com.mooplans.model.Dishes;
import com.mooplans.model.Restaurant;
import com.mooplans.model.User;

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
		HttpSession session = request.getSession();
		String action = request.getParameter("action");
		System.out.println("Action called "+action);
if(action != null){
		if(action.equalsIgnoreCase("restPage")){
			System.out.println("In Rest action");
			JSONArray restList = DishDAO.getRestnames();
			response.setContentType("application/json");
			out.write(restList+"");			
		}else if(action.equalsIgnoreCase("menuPage")){
			System.out.println("In Menu action");
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
}else{
			System.out.println("In addedPoints action");
			String transactionId = request.getParameter("tx");
			String status = request.getParameter("st");
			final float points = Float.parseFloat(request.getParameter("amt"));

			if(points == 0){
				session.setAttribute("message", "Your previous transaction was cancelled.");
			}else{
				final User user = (User)session.getAttribute("User");
				boolean pointsAdded = PayPalDAO.addPoints(user, transactionId, (int)points, status);
				if(pointsAdded){
					
					new Thread(new Runnable() {
					    public void run() {
					    	EmailDAO.sendMail(user, 2, points);
					    }
					}).start();
					
					
					session.setAttribute("message", "Added "+points+" points");
				}else{
					session.setAttribute("message", "Transaction failed. Please try again");
				}
			}
			response.sendRedirect(getServletContext().getContextPath()+"/jsp/home.jsp");
}
	}
}