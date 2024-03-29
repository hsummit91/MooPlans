package com.mooplans.dao;

import static com.mooplans.dao.DBConnection.connection;
import static com.mooplans.dao.DBConnection.getConnection;
import static com.mooplans.dao.DBConnection.pstmt;
import static com.mooplans.dao.DBConnection.release;
import static com.mooplans.dao.DBConnection.rs;

import java.sql.SQLException;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;

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
	
	public static JSONArray getRestnames(String mealPref, String mealType){
		JSONArray restDetails = new JSONArray();
		
		try{
			getConnection();
			String sql = "SELECT rest_name,rest_id,rest_health,rest_meal_type"
						+ " FROM restaurant"
						+ " WHERE ";
			
			String[] mpArray = mealPref.split(",");
			String[] mtArray = mealType.split(",");
			
			System.out.println(mpArray.length +" = "+mtArray.length);
			
			if(mpArray.length > 1){
				sql += "(";
			}
			
			for (int i = 0; i < mpArray.length; i++){
				if(i == mpArray.length - 1){
					sql += "rest_health LIKE '%"+mpArray[i].trim()+"%' ";	
				}else{
					sql += "rest_health LIKE '%"+mpArray[i].trim()+"%' OR ";
				}
				
				System.out.println(mpArray[i].trim());
			}
			
			if(mpArray.length > 1){
				sql += ") ";
			}
			
			/*******************************************************/
			
			sql += "AND ";
			
			if(mtArray.length > 1){
				sql += "(";
			}
			
			for (int i = 0; i < mtArray.length; i++){
				if(i == mtArray.length - 1){
					sql += "rest_meal_type LIKE '%"+mtArray[i].trim()+"%' ";	
				}else{
					sql += "rest_meal_type LIKE '%"+mtArray[i].trim()+"%' OR ";
				}
				
				System.out.println(mtArray[i].trim());
			}
			
			if(mtArray.length > 1){
				sql += ") ";
			}
			
			sql += "AND restaurant.rest_status <> 0";
			
			System.out.println("==>"+sql+"<==");
			
			pstmt = connection.prepareStatement(sql);

			getConnection(); // connection  re-established
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				JSONObject rest = new JSONObject();
				try{
					rest.put("restName", rs.getString(1));
					rest.put("restId", rs.getString(2));
					rest.put("restHealth", rs.getString(3));
					rest.put("restMealType", rs.getString(4));
					restDetails.put(rest);					
				}catch(Exception e){
					
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return restDetails;
	}
	
	public static ArrayList<Dishes> getDishDetails(){
		ArrayList<Dishes> userDishes = new ArrayList<Dishes>();
		
		try{
			getConnection();
			String sql = "SELECT dishes.dish_name, dishes.dish_category, restaurant.rest_name, dishes.dish_price"
					+ " FROM dishes INNER JOIN restaurant ON dishes.dish_rest_id=restaurant.rest_id"
					+ " WHERE restaurant.rest_status <> 0 ";
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
	
	public static ArrayList<Dishes> getDishDetailsByName(String restName){
		ArrayList<Dishes> userDishes = new ArrayList<Dishes>();
		
		try{
			getConnection();
			String sql = "SELECT dish_name, dishes.dish_category, dishes.dish_price, dishes.dish_id"
					+ " FROM dishes INNER JOIN restaurant ON dishes.dish_rest_id=restaurant.rest_id"
					+ " WHERE restaurant.rest_status <> 0 and restaurant.rest_name=(?)";

			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, restName);
			rs = pstmt.executeQuery();
		
			while(rs.next()){
				Dishes dishes = new Dishes();
				dishes.setDishName(rs.getString(1));
				dishes.setDishCategory(rs.getString(2));
				dishes.setDishPrice(rs.getFloat(3)); 
				dishes.setDishId(rs.getInt(4)); 
				userDishes.add(dishes);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return userDishes;
	}
	
	public static JSONArray getDishDetails(int restId, String mealPref, String mealType){
		//ArrayList<Dishes> userDishes = new ArrayList<Dishes>();
		JSONArray menuFilter = new JSONArray();
		
		try{
			getConnection();
			String sql = "SELECT dish_name, dish_category, dish_price, dish_id, dish_health, dish_description, dish_sides, dish_full_price"
					+ " FROM dishes WHERE ";
			
			String[] mpArray = mealPref.split(",");
			String[] mtArray = mealType.split(",");
			
			System.out.println(mpArray.length +" = "+mtArray.length);
			
			if(mpArray.length > 1){
				sql += "(";
			}
			
			for (int i = 0; i < mpArray.length; i++){
				if(i == mpArray.length - 1){
					sql += "dish_health LIKE '%"+mpArray[i].trim()+"%' ";	
				}else{
					sql += "dish_health LIKE '%"+mpArray[i].trim()+"%' OR ";
				}
				
				System.out.println(mpArray[i].trim());
			}
			
			if(mpArray.length > 1){
				sql += ") ";
			}
			
			/*******************************************************/
			
			sql += "AND ";
			
			if(mtArray.length > 1){
				sql += "(";
			}
			
			for (int i = 0; i < mtArray.length; i++){
				if(i == mtArray.length - 1){
					sql += "dish_category LIKE '%"+mtArray[i].trim()+"%' ";	
				}else{
					sql += "dish_category LIKE '%"+mtArray[i].trim()+"%' OR ";
				}
				
				System.out.println(mtArray[i].trim());
			}
			
			if(mtArray.length > 1){
				sql += ") ";
			}
			
			if(restId > 0){
				sql += "AND dish_rest_id = "+restId;
			}
			
			System.out.println("==>"+sql+"<==");

			pstmt = connection.prepareStatement(sql);
			//pstmt.setInt(1, restId);
			rs = pstmt.executeQuery();
			
			
		
			while(rs.next()){			
				JSONObject dishFilter = new JSONObject();
				try{
					dishFilter.put("dishName", rs.getString(1));
					dishFilter.put("dishCat", rs.getString(2));
					dishFilter.put("dishPrice", rs.getFloat(3));
					dishFilter.put("dishId", rs.getInt(4));
					dishFilter.put("dishHealth", rs.getString(5));
					dishFilter.put("dishDesc", rs.getString(6));
					dishFilter.put("dishSides", rs.getString(7));
					dishFilter.put("dishFullPrice", rs.getDouble(8));
					menuFilter.put(dishFilter);					
				}catch(Exception e){
					
				}		
			}
			System.out.println(menuFilter);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return menuFilter;
	}
	
	public static JSONArray getFeaturedDishes(int isFeatured){
		JSONArray menuFilter = new JSONArray();
		
		try{
			getConnection();
			String sql = "SELECT dish_name, dish_category, dish_price, dish_id, dish_health, dish_description, dish_sides, dish_full_price"
					+ " FROM dishes WHERE isFeatured = ?";
		
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, isFeatured);
			rs = pstmt.executeQuery();
		
			while(rs.next()){			
				JSONObject dishFilter = new JSONObject();
				try{
					dishFilter.put("dishName", rs.getString(1));
					dishFilter.put("dishCat", rs.getString(2));
					dishFilter.put("dishPrice", rs.getFloat(3));
					dishFilter.put("dishId", rs.getInt(4));
					dishFilter.put("dishHealth", rs.getString(5));
					dishFilter.put("dishDesc", rs.getString(6));
					dishFilter.put("dishSides", rs.getString(7));
					dishFilter.put("dishFullPrice", rs.getDouble(8));
					menuFilter.put(dishFilter);					
				}catch(Exception e){
					
				}		
			}
			System.out.println(menuFilter);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return menuFilter;
	}
	
}
