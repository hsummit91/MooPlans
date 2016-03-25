package com.mooplans.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mooplans.dao.DishDAO;
import com.mooplans.model.Dishes;
import com.mooplans.model.Restaurant;

/**
 * Servlet implementation class MenuServlet
 */
@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MenuServlet() {
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
		System.out.println("In menu action");
		
		String restName = request.getParameter("restName");
		System.out.println(restName);
		
			ArrayList<Dishes> menuList = new ArrayList<Dishes>();
			menuList = DishDAO.getDishDetailsByName(restName);
			
			for (int i = 0; i < menuList.size(); i++) {
				System.out.println(menuList.get(i).getDishName());
				System.out.println(menuList.get(i).getDishCategory());
				System.out.println(menuList.get(i).getDishPrice());
			}
			
			request.setAttribute("menuList", menuList); 
			getServletConfig().getServletContext().getRequestDispatcher("/jsp/menu.jsp").forward(request,response);
	}
}
