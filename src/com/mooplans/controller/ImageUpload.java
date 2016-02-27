package com.mooplans.controller;
import java.io.File;
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

import com.mooplans.model.User;

import static com.mooplans.dao.LoginDAO.*;
@WebServlet("/ImageUpload")
@MultipartConfig(fileSizeThreshold=1024*1024*2,	// 2MB 
maxFileSize=1024*1024*10,		// 10MB
maxRequestSize=1024*1024*50)	// 50MB
public class ImageUpload extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * Name of the directory where uploaded files will be saved, relative to
	 * the web application directory.
	 */
	private static final String SAVE_DIR = "/Users/Summit/git/MooPlans/WebContent/imgs";



	/**
	 * handles file upload
	 */


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String savePath = SAVE_DIR;
		String url = null, path = null;
		// creates the save directory if it does not exists
		File fileSaveDir = new File(savePath);
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}

		HttpSession se = request.getSession();
		User user = (User) se.getAttribute("User=");
		int id = user.getUser_id();
		for (Part part : request.getParts()) {
			String fileName = extractFileName(part);

			File imageDir = new File(savePath + File.separator + id);
			FileUtils.deleteDirectory(imageDir);
			imageDir.mkdir();
			part.write(imageDir + File.separator + fileName);
			path = "imgs" + File.separator + id + File.separator + fileName;
			addImage(path, id);
		}
		url = "/jsp/imageUpload.jsp";
		response.sendRedirect(getServletContext().getContextPath()+url);
	}

	/**
	 * Extracts file name from HTTP header content-disposition
	 */
	private static String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length()-1);
			}
		}
		return null;
	}
}