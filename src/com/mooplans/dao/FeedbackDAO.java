package com.mooplans.dao;

import static com.mooplans.dao.DBConnection.connection;
import static com.mooplans.dao.DBConnection.getConnection;
import static com.mooplans.dao.DBConnection.pstmt;
import static com.mooplans.dao.DBConnection.release;

import java.sql.SQLException;

import com.mooplans.model.User;

public class FeedbackDAO {
	
	
	public static int insertFeedback(User user){
		int ID = 0;
		try{
			
			if(user.getUser_id() > 0){
				getConnection();
				String sql = "INSERT INTO user_feedback (user_id, user_name, user_email,"
						+ " user_phone, message)"
						+ " VALUES (?, ?, ?, ?, ?)";
				pstmt = connection.prepareStatement(sql);
				pstmt.setInt(1, user.getUser_id());
				pstmt.setString(2, user.getUser_firstname());
				pstmt.setString(3, user.getUser_email());
				pstmt.setString(4, user.getUser_phone());
				pstmt.setString(5, user.getUser_message());
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

}
