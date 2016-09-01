package com.mooplans.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.StringTokenizer;

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

		String dish_command = request.getParameter("dish_command");
		System.out.println("Commmand:" +dish_command);

		String header1 = "\"categoryName\"";
		String header2 = "\"allowed\"";
		String header3 = "\"categoryData\"";

		String  [] categoryName = new String[50];
		Integer [] allowed = new Integer[50];
		int index=0;

		StringTokenizer st2 = new StringTokenizer(dish_command, ",");
		while (st2.hasMoreElements()) {

			String catName = st2.nextElement().toString();
			Integer allwd = Integer.parseInt(st2.nextElement().toString());

			StringBuilder sb = new StringBuilder();
			sb.append("\ncategoryName : " + catName);
			sb.append("\nallowed : " + allwd);
			sb.append("\n*******************\n");
			System.out.println(sb.toString());

			categoryName[index] = catName;
			allowed[index] = allwd;
			index++;
		}


		List<String> items = new ArrayList<String>();
		String item = request.getParameter("item");
		String type = request.getParameter("type");
		String price = request.getParameter("price");

		StringBuilder item1 = new StringBuilder();
		item1.append("{\"item\":\"").append(item).append("\",");
		item1.append("\"type\":\"").append(type).append("\",");
		item1.append("\"price\":\"").append(price).append("\"},");


		StringBuilder temp = new StringBuilder();

		for (int k = 2; k <= 50; k++) {
			if(request.getParameterValues("item"+k) != null){
				temp.append("{\"item\":\"").append(Arrays.toString(request.getParameterValues("item"+k))).append("\",");
				temp.append("\"type\":\"").append(Arrays.toString(request.getParameterValues("type"+k))).append("\",");
				temp.append("\"price\":\"").append(Arrays.toString(request.getParameterValues("price"+k))).append("\"},");
			}
		}
		items.add(item1.toString().concat(temp.toString().replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\\}\\{", "\\},\\{").replaceAll("\\},\\]", "\\}\\]")));

		String[] dish_allergen = new String[50];
		String[] dish_category = new String[50];
		String[] dish_health = new String[50];
		List<String> choices = new ArrayList<String>();

		dish_category = request.getParameterValues("dish_category");
		dish_allergen = request.getParameterValues("dish_allergen");
		dish_health = request.getParameterValues("dish_health");

		String str1 = Arrays.toString(dish_allergen);  
		String str2 = Arrays.toString(dish_category);  
		String str3 = Arrays.toString(dish_health);  
		String str4 = items.toString(); 

		//	System.out.println(" conversion1 " +str4);

		str1 = str1.substring(1, str1.length()-1).replaceAll("  ", ",").replaceAll("null", "").replaceAll(" , ", "").replaceAll(",,", "").replaceAll(",,, ", "");
		str2 = str2.substring(1, str2.length()-1).replaceAll("  ", ",").replaceAll("null", "").replaceAll(" , ", "").replaceAll(",,", "").replaceAll(",,, ", "");
		str3 = str3.substring(1, str3.length()-1).replaceAll("  ", ",").replaceAll("null", "").replaceAll(" , ", "").replaceAll(",,", "").replaceAll(",,, ", "");
		//	str4 = str4.substring(1, str4.length()-1).replaceAll("null", "").replaceAll("  ", ",").replaceAll(", ,", "").replaceAll(" , ", "").replaceAll(",,", "").replaceAll(",,, ", "").replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("#, ", "#");

		//	System.out.println(" conversion2 " +str4);


		String dish_full_price = request.getParameter("dish_full_price");
		float dish_point = 0;
		String numberAsString = dish_full_price;
		DecimalFormat decimalFormat = new DecimalFormat("#");
		try {
			dish_point = decimalFormat.parse(numberAsString).floatValue();
		} catch (ParseException e) {
			System.out.println(numberAsString + " is not a valid number.");
		}

		String dish_points = String.format("%.02f", (dish_point/10));
		System.out.println(dish_points + " points.");


		request.setAttribute("dish_allergen", str1);
		request.setAttribute("dish_category", str2);
		request.setAttribute("dish_health", str3);
		request.setAttribute("dish_choice", str4);
		request.setAttribute("dish_points", dish_points);
		RequestDispatcher rd = request.getRequestDispatcher("/restaurant/insert.jsp");
		rd.forward(request, response);

	}

}



