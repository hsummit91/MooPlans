package com.mooplans.controller;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileUtils;

import com.mooplans.dao.DishDAO;
import com.mooplans.dao.LoginDAO;
import com.mooplans.model.Image;
import com.mooplans.model.Restaurant;
import com.mooplans.model.User;

import static com.mooplans.dao.LoginDAO.*;
@WebServlet("/ImageUpload")
public class ImageUpload extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * Name of the directory where uploaded files will be saved, relative to
	 * the web application directory.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * handles file upload
	 */


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String imageId = request.getParameter("imageId");
		System.out.println("imageId -- "+imageId);
		String url = "/jsp/imageDisplay.jsp";
		
			// Update the new selected image in DB
			System.out.println("Image id " +imageId);
			User user = (User) session.getAttribute("User");
			boolean imageChanged = LoginDAO.updateImagePath(user, Integer.parseInt(imageId));
	        response.setContentType("application/json");
	        response.getWriter().write(imageChanged+"");
	}

}