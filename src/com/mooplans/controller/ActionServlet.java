package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mooplans.dao.DishDAO;
import com.mooplans.model.Dishes;

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
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("Inaction");
		
		PrintWriter out = response.getWriter();

		String action = request.getParameter("action");

		if(action == null){
			action = "";
		}

		if(action.equals("")){
			ArrayList<Dishes> menuList = new ArrayList<Dishes>();
			menuList = DishDAO.getDishDetails();
			
//
//			for (int i = 0; i < menuList.size(); i++) {
//		
//				System.out.println(menuList.get(i).getDishName());
//				System.out.println(menuList.get(i).getDishCategory());
//				System.out.println(menuList.get(i).getDishPrice());
//				System.out.println(menuList.get(i).getRest_name());
//			}
//			

			request.setAttribute("menuList", menuList); //categorylist is an arraylist      contains object of class category  
			getServletConfig().getServletContext().getRequestDispatcher("/jsp/orders.jsp").forward(request,response);

		}	
	}
}
