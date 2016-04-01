package com.mooplans.dao;

import static com.mooplans.dao.DBConnection.connection;
import static com.mooplans.dao.DBConnection.getConnection;
import static com.mooplans.dao.DBConnection.pstmt;
import static com.mooplans.dao.DBConnection.release;
import static com.mooplans.dao.DBConnection.rs;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.mooplans.model.Dishes;
import com.mooplans.model.User;

public class PayPalDAO {
	
//	public static float getBill(HashMap<Integer, String> items){
//		
//		float totalBill = 0;
//		for(Integer key: items.keySet()){
//			System.out.println("Key"+items.get(key)+" value="+key);
//			//getDishPrice
//		}
//		
//		try{
//			getConnection();
//			String sql = "SELECT dishes.dish_name, dishes.dish_category, restaurant.rest_name, dishes.dish_price"
//					+ " FROM dishes INNER JOIN restaurant ON dishes.dish_rest_id=restaurant.rest_id"
//					+ " WHERE restaurant.rest_status <> 0 ";
//			pstmt = connection.prepareStatement(sql);
//
//			getConnection(); // connection  re-established
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()){
//				Dishes dishes = new Dishes();
//				dishes.setDishName(rs.getString(1));
//				dishes.setDishCategory(rs.getString(2));
//				dishes.setRest_name(rs.getString(3));
//				dishes.setDishPrice(rs.getFloat(4)); 
//				//dishes.setRest_details(getRestDetails());
//				//userDishes.add(dishes);
//			}
//		}catch(SQLException e){
//			e.printStackTrace();
//		}finally{
//			release();
//		}
//		return userDishes;
//	}
//	
	
	
	public static void updateUserPoints(User user, float totalBill){
		try{
			getConnection();
			String sql = "UPDATE user SET user_points = ? where user_email = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, user.getUser_password());
			pstmt.setString(2, user.getUser_email());
			pstmt.executeUpdate();

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
	}
	
}
