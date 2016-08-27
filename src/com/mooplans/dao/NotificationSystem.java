package com.mooplans.dao;

import static com.mooplans.dao.DBConnThread.*;

import java.sql.SQLException;
import java.util.HashMap;

import com.mooplans.model.Dishes;
import com.mooplans.model.StartupData;
import com.mooplans.model.User;

public class NotificationSystem implements Runnable{

	public int getOrders(){
		int newOrders = 0;
		try{
			try{
				getConnection();
			}catch(Exception e){
				System.out.println("ERR while getting connection");
				release();
				getConnection();
			}
			
			String sql = "CALL poll_orders()";
			cstmt = connection.prepareCall(sql);
			rs = cstmt.executeQuery();

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
				
				String[] notesStr = dishNotes.split(",");
				
				for (int i = 0; i < splittedStr.length; i++){
					Dishes dish = sd.getDishDataById(Integer.parseInt(splittedStr[i]));
					items.put(dish.getDishName(), dish.getDishPrice());
					forRestaurants.put(Integer.parseInt(splittedStr[i]), dish);
					try{
						dishNotesMap.put(Integer.parseInt(splittedStr[i]), notesStr[i]);
					}catch(Exception e){
						
					}
				}
			
				
				System.out.println("--@@@@@@@@@@@--DISH NOTES--->"+dishNotesMap);
				
				System.out.println(" ~~~~~~~~~~SENDING MAIL~~~~~~~~~~~~~> "+orderId+" --FOR USER--->"+userId);
				
				User user = sd.getUserDataById(userId);
				user.setUser_address(rs.getString("order_deliverat"));
				user.setUser_phone(rs.getString("order_phone"));
				
				
				EmailDAO.sendOrderMailUser(user, items, orderId);
				
				System.out.println(" ~~~~~~~~~~SENDING MAIL TO REST~~~~~~~~~~~~~> "+orderId);
				
				EmailDAO.sendOrderMailRest(user, forRestaurants, orderId, dishNotesMap);
				
				System.out.println(" ~~~~~~~~~~MAILS SENT~~~~~~~~~~~~~> "+orderId);
				newOrders = 1;
			}else{
				newOrders = 0;
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			//release();
		}
		return newOrders;
	}

	@Override
	public void run() {
		int pollOrders = 0;
		while(true){
			pollOrders = getOrders();
			
			if(pollOrders == 0){
				try {
					release();
					System.out.println("SLEEEEEPINNNNGGGGG");
					Thread.sleep(300000);
					System.out.println("WAKIIIIIINNNNNGGGGGG UPPP !!!");
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}

	
}
