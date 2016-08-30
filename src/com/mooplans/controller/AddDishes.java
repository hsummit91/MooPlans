package com.mooplans.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class AddDishes
 */
@WebServlet("/AddDishes")
public class AddDishes extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddDishes() {
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

		String[] dish_allergen = new String[50];
		String[] dish_category = new String[50];
		String[] dish_health = new String[50];
		//String[] choices = null;
		List<String> choices = new ArrayList<String>();

		dish_category = request.getParameterValues("dish_category");
		dish_allergen = request.getParameterValues("dish_allergen");
		dish_health = request.getParameterValues("dish_health");
		
		String[] ch = request.getParameterValues("choices");
		for (int m = 2; m <= 50; m++) {
				String temp = Arrays.toString(request.getParameterValues("choices"+m));
				if(temp.length() != 0 )
				choices.add(temp+"#");
		}
		
		String str1 = Arrays.toString(dish_allergen);  
		String str2 = Arrays.toString(dish_category);  
		String str3 = Arrays.toString(dish_health);  
		String str4 = choices.toString(); 

		
		str1 = str1.substring(1, str1.length()-1).replaceAll("  ", ",").replaceAll("null", "").replaceAll(" , ", "").replaceAll(",,", "").replaceAll(",,, ", "");
		str2 = str2.substring(1, str2.length()-1).replaceAll("  ", ",").replaceAll("null", "").replaceAll(" , ", "").replaceAll(",,", "").replaceAll(",,, ", "");
		str3 = str3.substring(1, str3.length()-1).replaceAll("  ", ",").replaceAll("null", "").replaceAll(" , ", "").replaceAll(",,", "").replaceAll(",,, ", "");
		str4 = str4.substring(1, str4.length()-1).replaceAll("null#", "").replaceAll("  ", ",").replaceAll(", ,", "").replaceAll(" , ", "").replaceAll(",,", "").replaceAll(",,, ", "").replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("#, ", "#");
	
		String str5 = ch[0].concat(", ").concat(ch[1]).concat(", ").concat(ch[2]).concat("#").concat(str4).trim();

		String dish_full_price = request.getParameter("dish_full_price");
		float dish_point = 0;
		String numberAsString = dish_full_price;
		DecimalFormat decimalFormat = new DecimalFormat("#");
		try {
			dish_point = decimalFormat.parse(numberAsString).floatValue();
		} catch (ParseException e) {
			System.out.println(numberAsString + " is not a valid number.");
		}

		String dish_points = String.format("%.02f", dish_point/10);
		//System.out.println(dish_points + " points.");


		request.setAttribute("dish_allergen", str1);
		request.setAttribute("dish_category", str2);
		request.setAttribute("dish_health", str3);
		request.setAttribute("dish_choice", str5);
		request.setAttribute("dish_points", dish_points);
		RequestDispatcher rd = request.getRequestDispatcher("/restaurant/insert.jsp");
		rd.forward(request, response);

	}

}



