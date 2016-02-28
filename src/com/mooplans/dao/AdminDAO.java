package com.mooplans.dao;

import static com.mooplans.dao.DBConnection.connection;
import static com.mooplans.dao.DBConnection.getConnection;
import static com.mooplans.dao.DBConnection.pstmt;
import static com.mooplans.dao.DBConnection.release;
import static com.mooplans.dao.DBConnection.rs;

import java.sql.SQLException;
import java.util.ArrayList;

import com.mooplans.model.User;

public class AdminDAO {
	public static boolean verifyRestaurant(int rest_id){
		try{
			getConnection();
			String sql = "UPDATE restaurant SET rest_status = 1 WHERE rest_user_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, rest_id);
			pstmt.executeUpdate();
			
		}catch(SQLException se){
			System.err.println(se.getMessage());
			se.printStackTrace();
		}finally{
			release();
		}
		return true;
	}
	
	public static ArrayList<User> viewAllUsers(){
		ArrayList<User> users = new ArrayList<>();
		try{
			getConnection();
			String sql = "SELECT user_id, user_firstname, user_lastname, user_email,"
					+ " user_phone, user_university, user_address, user_role, user_points, user_image"
					+ " FROM user";
			pstmt = connection.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				User user = new User();
				user.setUser_id(rs.getInt(1));
				user.setUser_firstname(rs.getString(2));
				user.setUser_lastname(rs.getString(3));
				user.setUser_email(rs.getString(4));
				user.setUser_phone(rs.getString(5));
				user.setUser_university(rs.getString(6));
				user.setUser_address(rs.getString(7));
				user.setUser_role(rs.getString(8));
				user.setUser_points(rs.getInt(9));
				user.setUser_image(rs.getString(10));
				users.add(user);
			}

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return users;
	}
	
	
}
