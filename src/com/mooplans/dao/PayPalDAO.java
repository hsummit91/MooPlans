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
import com.mooplans.model.Order;
import com.mooplans.model.Restaurant;
import com.mooplans.model.StartupData;
import com.mooplans.model.User;

public class PayPalDAO {

	public static float getBill(Integer dishId){
		
		StartupData sd = StartupData.getInstance();		
		Dishes dish = sd.getDishDataById(dishId);
		
		return dish.getDishPrice();
	}
	
	public static float getPriceBill(Integer dishId){
		
		StartupData sd = StartupData.getInstance();		
		Dishes dish = sd.getDishDataById(dishId);
		
		return dish.getDishFullPrice();
	}

	private static String getCurrentTimeStamp() {

		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime()).toString();

	}

	public static int createOrder(User user, HashMap<Integer, String> items, HashMap<Integer, String> notes, String paymentMode, float totalBill){

		int orderId = 0;
		StringBuilder sb = new StringBuilder();
		StringBuilder sb2 = new StringBuilder();
		for(Integer key: items.keySet()){
			// Get all Dish Points here and prepare Bill
			sb.append(Integer.toString(key)).append(",");
			sb2.append(notes.get(key)).append("##");
		}
		try{
			getConnection();
			String sql = "INSERT INTO orders (order_user_id, order_total, order_deliverat, order_date, order_phone, delivery_time, payment_mode, order_notes, order_ids)"
					+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, user.getUser_id());
			pstmt.setFloat(2, totalBill);
			pstmt.setString(3, user.getUser_address());
			pstmt.setString(4, getCurrentTimeStamp());
			pstmt.setString(5, user.getUser_phone());
			pstmt.setString(6, user.getDelivery_time());
			pstmt.setString(7, paymentMode);
			pstmt.setString(8, sb2.toString());
			String order_ids = sb.toString();
			order_ids = order_ids.substring(0, order_ids.length()-1);
			pstmt.setString(9, order_ids);
			pstmt.executeUpdate();

			String sql2 = "SELECT order_id FROM orders ORDER BY order_id DESC LIMIT 1";
			pstmt = connection.prepareStatement(sql2);
			rs = pstmt.executeQuery();
			while(rs.next()){
				orderId = rs.getInt(1); 
			}

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return orderId;
	}


	public static boolean updateUserPoints(User user, HashMap<Integer, String> items, float totalBill){

		//float totalBill = 0;
/*		for(Integer key: items.keySet()){
			// Get all Dish Points here and prepare Bill
			totalBill += getBill(key); 
		}*/

		boolean deductedPoints = false;
		float total = user.getUser_points() - (float) totalBill;
		if(total>=0){
			try{
				getConnection();
				String sql = "UPDATE user SET user_points = ? where user_email = ? and user_id=?";
				pstmt = connection.prepareStatement(sql);
				pstmt.setFloat(1, Float.parseFloat(String.format( "%.2f",total)));
				pstmt.setString(2, user.getUser_email());
				pstmt.setInt(3, user.getUser_id());
				int row = pstmt.executeUpdate();
				if(row==1) {
					deductedPoints = true;
					user.setUser_points(total);
					Order o = new Order();
					o.setOrder_total(totalBill);
				}
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				release();
			}
		}
		return deductedPoints;
	}

	public static float addPoints(User user, String tx_id, float amount, String status){

		int txCompleted = 0;
		float pointsAdded = 0;
		float points=0;

		try{
			getConnection();

			// Get points based on the amount from 
			System.out.println("==========>amount=======>"+amount);
			
			String sql2 = "SELECT points FROM meal_plans where amount like "+amount;
			pstmt = connection.prepareStatement(sql2);
			rs = pstmt.executeQuery();
			if(rs.next()){
				points = rs.getFloat(1); 
			}else{
				points = 0;
			}
			System.out.println("==========>points=======>"+points);
			float newPoints = Float.parseFloat(String.format( "%.2f",user.getUser_points())) + points;

			String sql1 = "INSERT INTO user_payment (tx_id, user_id, amount, payment_date, status)"
					+ " VALUES (?, ?, ?, ?, ?)";
			pstmt = connection.prepareStatement(sql1);
			pstmt.setString(1, tx_id);
			pstmt.setInt(2, user.getUser_id());
			pstmt.setFloat(3, amount);
			pstmt.setString(4, getCurrentTimeStamp());
			pstmt.setString(5, status);
			txCompleted = pstmt.executeUpdate();

			if(txCompleted>0){
				String sql = "UPDATE user SET user_points = ? where user_email = ? and user_id=?";
				pstmt = connection.prepareStatement(sql);
				pstmt.setFloat(1, newPoints);
				pstmt.setString(2, user.getUser_email());
				pstmt.setInt(3, user.getUser_id());
				int row = pstmt.executeUpdate();
				if(row==1) {
					pointsAdded = points;
					user.setUser_points(newPoints);
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return pointsAdded;
	}

}