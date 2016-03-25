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

		System.out.println("Inaction");
		String action = request.getParameter("action");

		if(action == null){
			action = "";
		}

		if(action.equals("")){
			ArrayList<Restaurant> restList = new ArrayList<Restaurant>();
			restList = DishDAO.getRestnames();
			System.out.println("number of rest "+restList.size());

			request.setAttribute("restList", restList);
			getServletConfig().getServletContext().getRequestDispatcher("/jsp/orders.jsp").forward(request,response);

		}	
	}
}
