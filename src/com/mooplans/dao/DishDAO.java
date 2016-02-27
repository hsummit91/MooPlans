package com.mooplans.dao;

import static com.mooplans.dao.DBConnection.connection;
import static com.mooplans.dao.DBConnection.getConnection;
import static com.mooplans.dao.DBConnection.pstmt;
import static com.mooplans.dao.DBConnection.release;
import static com.mooplans.dao.DBConnection.rs;

import java.sql.SQLException;
import java.util.ArrayList;

import com.mooplans.model.Dishes;
import com.mooplans.model.Restaurant;

public class DishDAO {
	
	public static ArrayList<Restaurant> getRestDetails(){
		ArrayList<Restaurant> restaurant = new ArrayList<Restaurant>();
		try{
			getConnection();
			String sql = "SELECT rest_id,rest_name,rest_phone FROM restaurant";
			pstmt = connection.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				Restaurant rest = new Restaurant();
				rest.setRestId(rs.getInt(1));
				rest.setRestName(rs.getString(2));
				rest.setRestPhone(rs.getString(3));
				restaurant.add(rest);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			//release();
		}
		return restaurant;
	}
	
	
	public static ArrayList<Dishes> getDishDetails(){
		ArrayList<Dishes> userDishes = new ArrayList<Dishes>();
		
		try{
			getConnection();
			String sql = "SELECT dishes.dish_name, dishes.dish_category, restaurant.rest_name, dishes.dish_price "
					+ "FROM dishes INNER JOIN restaurant ON dishes.dish_rest_id=restaurant.rest_id";
			pstmt = connection.prepareStatement(sql);

			getConnection(); // connection  re-established
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Dishes dishes = new Dishes();
				dishes.setDishName(rs.getString(1));
				dishes.setDishCategory(rs.getString(2));
				dishes.setRest_name(rs.getString(3));
				dishes.setDishPrice(rs.getFloat(4)); 
				//dishes.setRest_details(getRestDetails());
				userDishes.add(dishes);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return userDishes;
	}
	
}
