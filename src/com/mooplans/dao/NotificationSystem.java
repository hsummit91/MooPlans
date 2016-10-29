package com.mooplans.dao;

import static com.mooplans.dao.DBConnThread.connection;
import static com.mooplans.dao.DBConnThread.cstmt;
import static com.mooplans.dao.DBConnThread.getConnection;
import static com.mooplans.dao.DBConnThread.release;
import static com.mooplans.dao.DBConnThread.rs;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.mooplans.model.Dishes;
import com.mooplans.model.StartupData;
import com.mooplans.model.User;


public class NotificationSystem implements Runnable{
	
	static Logger log = Logger.getLogger(NotificationSystem.class.getName());

	public int getOrders(){
		int newOrders = 0;
		try{
			try{
				getConnection();
			}catch(Exception e){
				log.error("getOrders :: connection ",e);
				release();
				getConnection();
			}
			
			String sql = "CALL poll_orders()";
			try{
				cstmt = connection.prepareCall(sql);
				rs = cstmt.executeQuery();
			}catch(Exception e){
				log.error("getOrders :: error while getting prepareCall ",e);
			}
			
			if(rs.next()){
				StartupData sd = StartupData.getInstance();
				HashMap<String, Float> items = new HashMap<String, Float>();
				HashMap<Integer, Dishes> forRestaurants = new HashMap<Integer, Dishes>();
				
				HashMap<Integer, String> dishNotesMap = new HashMap<Integer, String>();
				
				int orderId = rs.getInt("ordr_id");
				int userId = rs.getInt("order_user_id");
				
				String dishOrders = rs.getString("order_ids");
				
				String[] splittedStr = dishOrders.split(",");
				
				String dishNotes = rs.getString("order_notes");
				
				String[] notesStr = dishNotes.split("##");
				
				String paymentMode = rs.getString("payment_mode");
				
				float totalBill = Float.parseFloat(rs.getString("order_total"));
				
				for (int i = 0; i < splittedStr.length; i++){
					Dishes dish = sd.getDishDataById(Integer.parseInt(splittedStr[i]));
					
					if(paymentMode.equals("points")){
						items.put(dish.getDishName(), dish.getDishPrice());
					}else{
						items.put(dish.getDishName(), dish.getDishFullPrice());
					}
					
					forRestaurants.put(Integer.parseInt(splittedStr[i]), dish);
					try{
						dishNotesMap.put(Integer.parseInt(splittedStr[i]), notesStr[i]);
					}catch(Exception e){
						log.error("getOrders :: ",e);
					}
				}
			
				log.info("SENDING MAIL: OrderId=["+orderId+"] for user=["+userId+"]");
				
				User user = sd.getUserDataById(userId);
				String deliver = rs.getString("order_deliverat");
				if(deliver != null){
					user.setUser_address(deliver);
				}
				String phone = rs.getString("order_phone");
				if(phone != null){
					user.setUser_phone(phone);
				}
					
				EmailDAO.sendOrderMailUser(user, items, orderId, paymentMode, totalBill);
				
				log.info("SENDING MAIL TO RESTAURANTS: OrderId=["+orderId+"]");
				
				EmailDAO.sendOrderMailRest(user, forRestaurants, orderId, dishNotesMap, paymentMode);
				
				newOrders = 1;
			}else{
				newOrders = 0;
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return newOrders;
	}

	public void restartThread(){
		Thread t = new Thread(new NotificationSystem());
		t.start();
	}
	
	@Override
	public void run() {
		int pollOrders = 0;
	     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		while(true){
			try{
				pollOrders = getOrders();
			}catch(Exception e){
				log.error("Error calling stored procedure :: ",e);
			}
			if(pollOrders == 0){
				try {
					release();
					log.info("THREAD SLEEPING @ "+dateFormat.format(new Date()));
					Thread.sleep(300000);
					log.info("THREAD WAKING UP @ "+dateFormat.format(new Date()));
				} catch (InterruptedException e) {
					log.error("Error in polling :: ",e);
					e.printStackTrace();
					restartThread();
				}
			}
		}
	}	
}
