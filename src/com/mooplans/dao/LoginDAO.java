package com.mooplans.dao;

import java.sql.SQLException;

import com.mooplans.model.User;

import static com.mooplans.dao.DBConnection.*;



public class LoginDAO {
	public static int checkUserDetails(String emailId, String password){

		int ID = 0;
		String role = getUserRole(emailId, password);
		try{

			getConnection();

			String sql = "SELECT user_id FROM user WHERE user_email = ? AND user_password = ? AND user_role = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, emailId);
			pstmt.setString(2, password);
			pstmt.setString(3, role);

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


	public static String getUserRole(String username, String password){

		String role = null;
		try{
			getConnection();
			String sql = "SELECT user_role FROM user WHERE user_email = ? AND user_password = ?";

			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);

			rs = pstmt.executeQuery();

			if(rs.next()){
				role = rs.getString(1);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return role;
	}

	public static User getDetails(int ID){
		User user = null;
		try{
			getConnection();
			String sql = "select user_password, user_firstname, user_lastname, user_email,"
					+ "user_phone, user_university, user_address, user_role, user_points, user_image from user where user_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, ID);
			rs = pstmt.executeQuery();

			if(rs.next()){
				user = new User();
				user.setUser_id(ID);
				user.setUser_password(rs.getString(1));
				user.setUser_firstname(rs.getString(2));
				user.setUser_lastname(rs.getString(3));
				user.setUser_email(rs.getString(4));
				user.setUser_phone(rs.getString(5));
				user.setUser_university(rs.getString(6));
				user.setUser_address(rs.getString(7));
				user.setUser_role(rs.getString(8));
				user.setUser_points(rs.getInt(9));
				user.setUser_image(rs.getString(10));
			}

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return user;
	}



	public static boolean isUserRegistered(String email, String phone){

		boolean isExists = false;

		try{
			getConnection();
			String sql = "SELECT user_id FROM user WHERE user_email = ?"; //AND user_phone = ?"; (future work if required)

			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, email);
			//pstmt.setString(2, phone);

			rs = pstmt.executeQuery();

			if(rs.next()){
				int ID = rs.getInt(1);
				isExists = (ID > 0) ? true : false; 
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return isExists;
	}

	public static int registerUser(User user){
		int ID = 0;
		try{
			// Check if the email and phone number exists
			boolean isExists = isUserRegistered(user.getUser_email(), user.getUser_phone());

			if(!isExists){
				getConnection();
				String sql = "INSERT INTO user (user_password, user_firstname, user_lastname, user_email,"
						+ " user_phone, user_university, user_address, user_role, user_points)"
						+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = connection.prepareStatement(sql);
				pstmt.setString(1, user.getUser_password());
				pstmt.setString(2, user.getUser_firstname());
				pstmt.setString(3, user.getUser_lastname());
				pstmt.setString(4, user.getUser_email());
				pstmt.setString(5, user.getUser_phone());
				pstmt.setString(6, user.getUser_university());
				pstmt.setString(7, user.getUser_address());
				pstmt.setString(8, user.getUser_role());
				pstmt.setInt(9, user.getUser_points());
				ID = pstmt.executeUpdate();
			}
			else return -1;

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return ID;
	}

	public static String retrievePassword(User user){
		String password = null;
		try{
			getConnection();
			String sql = "SELECT user_password FROM user where user_email = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, user.getUser_email());
			rs = pstmt.executeQuery();

			if(rs.next()){
				password = rs.getString(1);
			}

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return password;
	}

	public static void updatePassword(User user){
		try{
			getConnection();
			String sql = "UPDATE user SET user_password = ? where user_email = ?";
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

	public static void updateUserProfile(User user){
		try{
			getConnection();
			String sql = "UPDATE user set user_firstname = ?, user_lastname = ?, "
					+ "user_phone = ?, user_university = ?, user_address = ?, user_role = ?, user_points = ? WHERE user_email = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, user.getUser_firstname());
			pstmt.setString(2, user.getUser_lastname());
			pstmt.setString(3, user.getUser_phone());
			pstmt.setString(4, user.getUser_university());
			pstmt.setString(5, user.getUser_address());
			pstmt.setString(6, user.getUser_role());
			pstmt.setInt(7, user.getUser_points());
			pstmt.setString(8, user.getUser_email());
			pstmt.executeUpdate();

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
	}

	public static int getUserID(User user){
		int ID = 0;
		try{
			getConnection();
			String sql = "SELECT user_id FROM user WHERE user_email = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, user.getUser_email());

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


	public static void updatePoints(int ID, int points){
		try{
			getConnection();
			String sql = "UPDATE user set user_points = ? where user_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, points);
			pstmt.setInt(2, ID);
			pstmt.executeUpdate();

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
	}

	public static boolean addImage(String imagepath, int ID){
		try{
			getConnection();
			String sql = "UPDATE user SET user_image = ? WHERE user_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, imagepath);
			pstmt.setInt(2, ID);
			pstmt.executeUpdate();
			
		}catch(SQLException se){
			System.err.println(se.getMessage());
			se.printStackTrace();
		}finally{
			release();
		}
		return true;
	}
	
	public static String getImagePath(User user){
		String imagePath = null;
		try{
			getConnection();
			String sql = "SELECT user_image FROM user WHERE user_email = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, user.getUser_email());
			
			if(rs.next()){
				imagePath = rs.getString(1);
			}

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return imagePath;
	}

}
