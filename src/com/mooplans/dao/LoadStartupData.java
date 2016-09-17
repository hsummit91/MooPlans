package com.mooplans.dao;

import static com.mooplans.dao.DBConnThread.connection;
import static com.mooplans.dao.DBConnThread.getConnection;
import static com.mooplans.dao.DBConnThread.pstmt;
import static com.mooplans.dao.DBConnThread.release;
import static com.mooplans.dao.DBConnThread.rs;

import java.sql.SQLException;
import java.util.HashMap;

import com.mooplans.model.Dishes;
import com.mooplans.model.StartupData;
import com.mooplans.model.User;

public class LoadStartupData {

		public void loadUsers(){

			try{
				getConnection();
				String sql = "SELECT user_id, user_firstname, user_email, user_phone, user_points FROM user";
				pstmt = connection.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				StartupData sd = StartupData.getInstance();
				
				HashMap<Integer, User> userData = sd.getUserData();
				
				while(rs.next()){
					User user = new User();
					int userId = rs.getInt(1);
					user.setUser_id(userId);
					user.setUser_firstname(rs.getString(2));
					user.setUser_email(rs.getString(3));
					user.setUser_phone(rs.getString(4));
					user.setUser_points(Float.parseFloat(String.format( "%.2f",rs.getFloat(5))));
					userData.put(userId, user);
				}
				System.out.println("LOADING COMPLETE -------- USER DATA SIZE *********** "+userData.size());
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				release();
			}
		}
		
		public void loadDishes(){

			try{
				getConnection();
				String sql = "SELECT d.dish_id, d.dish_name, d.dish_price, d.dish_rest_id, r.rest_name, "
						+ "d.dish_category, d.dish_description, d.dish_choice, r.rest_email, r.rest_phone, "
						+ "d.dish_sides, d.dish_health, d.dish_full_price, r.rest_delivery_fee, "
						+ "r.rest_type, d.discounted_price, d.marketing_fee, d.discounted_points, d.marketing_fee_points "
						+ "FROM dishes as d join restaurant as r "
						+ "on d.dish_rest_id = r.rest_id";
				pstmt = connection.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				StartupData sd = StartupData.getInstance();
				
				HashMap<Integer, Dishes> dishData = sd.getDishData();
				
				while(rs.next()){
					Dishes dish = new Dishes();

					int dishId = rs.getInt(1);
					
					dish.setDishId(dishId);
					dish.setDishName(rs.getString(2));
					dish.setDishPrice(Float.parseFloat(String.format( "%.2f",rs.getFloat(3))));
					dish.setRestId(rs.getInt(4));
					dish.setRest_name(rs.getString(5));
					dish.setDishCategory(rs.getString(6));
					dish.setDishDescription(rs.getString(7));
					dish.setDishChoice(rs.getString(8));
					dish.setRestEmail(rs.getString(9));
					dish.setRestPhone(rs.getString(10));
					dish.setDishSides(rs.getString(11));
					dish.setDishHealth(rs.getString(12));
					dish.setDishFullPrice(Float.parseFloat(String.format( "%.2f",rs.getFloat(13))));
					dish.setDeliveryFee(rs.getInt(14));
					dish.setRestaurantType(rs.getInt(15));
					dish.setDcntPrice(Float.parseFloat(String.format( "%.2f",rs.getFloat(16))));
					dish.setMrktFee(Float.parseFloat(String.format( "%.2f",rs.getFloat(17))));
					dish.setDcntPoints(Float.parseFloat(String.format( "%.2f",rs.getFloat(18))));
					dish.setMrktPoints(Float.parseFloat(String.format( "%.2f",rs.getFloat(19))));
					
					dishData.put(dishId, dish);
				}
				System.out.println("LOADING COMPLETE -------- DISH DATA SIZE *********** "+dishData);
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				release();
			}
		}
	
}
