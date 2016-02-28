package com.mooplans.dao;
import static com.mooplans.dao.DBConnection.connection;
import static com.mooplans.dao.DBConnection.getConnection;
import static com.mooplans.dao.DBConnection.pstmt;
import static com.mooplans.dao.DBConnection.release;
import static com.mooplans.dao.DBConnection.rs;

import java.sql.SQLException;
import java.util.ArrayList;

import com.mooplans.model.Dishes;
import com.mooplans.model.User;
public class RestaurantDAO {

	public static void deleteDish(User user, int dish_id){
		try{
			getConnection();
			String sql = "DELETE FROM dishes WHERE dish_rest_id = ? AND dish_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, user.getUser_id());
			pstmt.setInt(2, dish_id);
			pstmt.executeUpdate();
		}catch(SQLException se){
			System.err.println(se.getMessage());
			se.printStackTrace();
		}finally{
			release();
		}
	}

	public static int addDish(User user, Dishes dish){
		int ID = 0;
		try{
			getConnection();
			String sql = "INSERT INTO dishes (dish_name, dish_price, dish_rest_id, dish_category)"
					+ " VALUES (?, ?, ?, ?)";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, dish.getDishName());
			pstmt.setFloat(2, dish.getDishPrice());
			pstmt.setInt(3, user.getUser_id());
			pstmt.setString(4, dish.getDishCategory());
			pstmt.executeUpdate();
			
			sql = "SELECT dish_id FROM dishes WHERE dish_rest_id = ? dish_name = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, user.getUser_id());
			pstmt.setString(2, dish.getDishName());
			rs = pstmt.executeQuery();

			if(rs.next()){
				ID = rs.getInt(1);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return ID;
	}

	public static ArrayList<Dishes> viewAllDishes(User user){
		ArrayList<Dishes> menu = new ArrayList<>();
		try{
			getConnection();
			String sql = "SELECT dish_id, dish_name, dish_price, dish_category FROM dishes"
					+ " WHERE dish_rest_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, user.getUser_id());
			rs = pstmt.executeQuery();

			while(rs.next()){
				Dishes dishes = new Dishes();
				dishes.setDishId(rs.getInt(1));
				dishes.setDishName(rs.getString(2));
				dishes.setDishPrice(rs.getFloat(3)); 
				dishes.setDishCategory(rs.getString(4));
				menu.add(dishes);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}

		return menu;
	}

}