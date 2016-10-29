package com.mooplans.controller;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;

import com.mooplans.dao.LoadStartupData;
import com.mooplans.dao.NotificationSystem;

/**
 * Servlet implementation class StartupServlet
 */

public class StartupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	static Logger log = Logger.getLogger(StartupServlet.class.getName());
	
	Thread t = null;
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
		log.info("loading user data");
		lsd.loadUsers();
		log.info("loading user data COMPLETE");
		
		log.info("loading dish data");
		lsd.loadDishes();
		log.info("loading dish data COMPLETE");
		
		if(t == null){
			log.info("--STARTING THREAD--");
			t = new Thread(new NotificationSystem());
	        t.start();
		}else{
			log.info("--THREAD IS RUNNING--");
		}		
		
	}
}
