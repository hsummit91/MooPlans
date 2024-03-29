package com.mooplans.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import org.json.JSONException;
import org.json.JSONObject;

import com.mooplans.model.Image;
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

	public static JSONObject getUserDetails(int ID){
		JSONObject userDetails = new JSONObject();
		try{
			getConnection();
			String sql = "select firstTimeData, user_firstname, user_lastname, user_email,"
					+ "user_phone, user_university, user_address, user_role, user_points, user_image, gender, allergies, diet, cuisine "
					+ "from user where user_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, ID);
			rs = pstmt.executeQuery();

			if(rs.next()){
				userDetails.put("userId",ID);
				userDetails.put("firstTimeData", rs.getString(1));
				userDetails.put("firstName", rs.getString(2));
				userDetails.put("lastName", rs.getString(3));
				userDetails.put("email", rs.getString(4));
				userDetails.put("phone", rs.getString(5));
				userDetails.put("university", rs.getString(6));
				userDetails.put("address", rs.getString(7));
				userDetails.put("role", rs.getString(8));
				userDetails.put("points", rs.getString(9));		
				userDetails.put("image", rs.getString(10));
				userDetails.put("gender", rs.getString(11));
				userDetails.put("allergies", rs.getString(12));
				userDetails.put("diet", rs.getString(13));
				userDetails.put("cuisine", rs.getString(14));
			}

		}catch(SQLException e){
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}finally{
			release();
		}
		return userDetails;
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

	public static String updateUserFirstTimeData(String gender, String allergies, String diet, String cuisine, int userId){
		String success = "success";
		try{
			getConnection();
			String sql = "UPDATE user set gender = ?, allergies = ?, "
					+ "diet = ?, cuisine = ?, firstTimeData = 1 WHERE user_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, gender);
			pstmt.setString(2, allergies);
			pstmt.setString(3, diet);
			pstmt.setString(4, cuisine);
			pstmt.setInt(5, userId);

			pstmt.executeUpdate();

		}catch(SQLException e){
			success = "failure";
			e.printStackTrace();
		}finally{
			release();
		}
		return success;
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
	
	
	public static ArrayList<Image> getCodeImages(){
		ArrayList<Image> img = new ArrayList<Image>();
		try{
			getConnection();
			String sql = "SELECT image_id,user_image FROM image_codes";
			pstmt = connection.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()){
				Image i = new Image();
				i.setImageId(rs.getInt(1));
				i.setImagePath(rs.getString(2));
				img.add(i);
			}

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			//release();
		}
		return img;
	}
	
	public static String getCodeImagePath(int imageId){
		String imagePath = null;
		try{
			getConnection();
			String sql = "SELECT user_image FROM image_codes WHERE image_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, imageId);
			rs = pstmt.executeQuery();
			if(rs.next()){
				imagePath = rs.getString(1);
				System.out.println("changed path: " +imagePath);
			}

		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return imagePath;
	}


	public static boolean updateImagePath(User user, int imageId){
		boolean flag = false;
		String imagePath = getCodeImagePath(imageId);
		
		try{
			getConnection();
			String sql = "UPDATE user SET user_image = ? WHERE user_email = ? and user_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setString(1, imagePath);
			pstmt.setString(2, user.getUser_email());
			pstmt.setInt(3, user.getUser_id());
			pstmt.executeUpdate();
			user.setUser_image(imagePath);
			flag = true;
		}catch(SQLException e){
			flag = false;
			e.printStackTrace();
		}finally{
			release();
		}
		return flag;
	}
}
