package com.mooplans.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mooplans.dao.FeedbackDAO;
import com.mooplans.model.User;

/**
 * Servlet implementation class Feedback
 */
@WebServlet("/Feedback")
public class Feedback extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Feedback() {
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
		
		String url = "/jsp/home.jsp";
		
		String firstname= request.getParameter("userName");
		String emailId= request.getParameter("userEmail");
		String phone=request.getParameter("userPhone");
		String message=request.getParameter("userMsg");
		
			System.out.println("firstname ="+firstname);
			System.out.println("userName ="+emailId);
			System.out.println("phone ="+phone);
			System.out.println("message ="+message);

			User userObject = new User(firstname, emailId, phone, message);

			int ID = FeedbackDAO.insertFeedback(userObject);

			if (ID == 0) {
				System.out.println("Registraion failed ID :"+ID);
				request.setAttribute("errormsg", "Registration failed. Please try again.");
			}
			else if (ID < 0) {
				System.out.println("Registraion failed ID :"+ID);
				request.setAttribute("errormsg", "Email ID already exists.");
			}else{
				System.out.println("Registraion done success ID :"+ID);
				url = "/contact.jsp";
			}
		response.sendRedirect(getServletContext().getContextPath()+url);
	}

}
