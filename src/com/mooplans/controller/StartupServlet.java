package com.mooplans.controller;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.mooplans.dao.LoadStartupData;
import com.mooplans.dao.NotificationSystem;

/**
 * Servlet implementation class StartupServlet
 */

public class StartupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StartupServlet() {
        super();
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		
		LoadStartupData lsd = new LoadStartupData();
		System.out.println(".......... loading users ...........");
		lsd.loadUsers();
		
		System.out.println(".......... loading dishes ...........");
		lsd.loadDishes();
		
		//------------------------------
		System.out.println("%%%%%%%%%%%%%%%% ........................... %%%%%%%%%%%%%%%%%");
		Thread t = null;
		if(t == null){
			System.out.println("%%%%%%%%%%%%%%%% STARTING THREAD %%%%%%%%%%%%%%%%%");
			t = new Thread(new NotificationSystem());
	        t.start();
		}else{
			System.out.println("%%%%%%%%%%%%%%%% THREAD ALREADY STARTED %%%%%%%%%%%%%%%%%");
		}
		
		//------------------------------
	
		
		
	}

}
