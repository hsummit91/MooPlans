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

import com.mooplans.dao.DishDAO;
import com.mooplans.dao.EmailDAO;
import com.mooplans.dao.PayPalDAO;
import com.mooplans.model.Cart;
import com.mooplans.model.User;

/**
 * Servlet implementation class ActionServlet
 */
@WebServlet("/ActionServlet")
public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static Logger log = Logger.getLogger(ActionServlet.class.getName());
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
		if(action != null){
			if(action.equalsIgnoreCase("restPage")){
				String mealPref = request.getParameter("mealPref");
				String mealType = request.getParameter("mealType");
				
				log.info("Action called :: restPage, mealPref="+mealPref+", mealType="+mealType);
				
				JSONArray restList = DishDAO.getRestnames(mealPref,mealType);
				response.setContentType("application/json");
				out.write(restList+"");			
			}else if(action.equalsIgnoreCase("menuPage")){
				log.info("Action called :: menuPage");
				Cart shoppingCart;
				shoppingCart = (Cart) session.getAttribute("cart");
					if(shoppingCart == null){
						log.info("creating shopping cart");
						shoppingCart = new Cart();
						session.setAttribute("cart", shoppingCart);
					}

					int restId = Integer.parseInt(request.getParameter("restId"));
					log.info("restaurant selected: "+restId);

					JSONArray menuList = DishDAO.getDishDetails(restId, "", "");	
					
				request.setAttribute("menuList", menuList);
				request.setAttribute("restaurant", restId+"");
				getServletConfig().getServletContext().getRequestDispatcher("/jsp/menu.jsp").forward(request,response);
			}else if(action.equalsIgnoreCase("menuFilter")){
				log.info("Action called :: menuFilter");

				int restId = Integer.parseInt(request.getParameter("restId"));
				String mealPref = request.getParameter("mealPref");
				String mealType = request.getParameter("mealType");
				
				log.info("Action called :: restPage, mealPref="+mealPref+", mealType="+mealType+", restaurant="+restId);
			
				JSONArray menuList = DishDAO.getDishDetails(restId, mealPref, mealType);	
				response.setCharacterEncoding("UTF-8");
				response.setContentType("application/json");
				out.write(menuList+"");	
			}else if(action.equalsIgnoreCase("getFeaturedDishes")){
				log.info("Action called :: getFeaturedDishes");
				int isFeatured = Integer.parseInt(request.getParameter("isFeatured"));

				JSONArray menuList = DishDAO.getFeaturedDishes(isFeatured);	
				response.setContentType("application/json");
				out.write(menuList+"");	
			}	
		}else{
			String transactionId = request.getParameter("tx");
			String status = request.getParameter("st");
			final float amount = Float.parseFloat(request.getParameter("amt"));

			log.info("Action called :: addPoints :: amount="+amount);
			
			if(amount == 0){
				session.setAttribute("message", "Your previous transaction was cancelled.");
			}else{
				final User user = (User)session.getAttribute("User");
				final float points = PayPalDAO.addPoints(user, transactionId, amount, status);
				if(points>0){
					
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