package com.mooplans.model;

import java.util.HashMap;

public class StartupData {
	
	   private static StartupData instance = null;
	   protected StartupData() {
	      // Exists only to defeat instantiation.
	   }
	   public static StartupData getInstance() {
	      if(instance == null) {
	         instance = new StartupData();
	      }
	      return instance;
	   }
	
	HashMap<Integer, User> userData = new HashMap<Integer, User>();
	HashMap<Integer, Dishes> dishData = new HashMap<Integer, Dishes>();
	
	public HashMap<Integer, User> getUserData(){
		return userData;
	}
	
	public User getUserDataById(int id){
		return userData.get(id);
	}
	
	public HashMap<Integer, Dishes> getDishData(){
		return dishData;
	}
	
	public Dishes getDishDataById(int id){
		return dishData.get(id);
	}

}
