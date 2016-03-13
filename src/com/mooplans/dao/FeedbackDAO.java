package com.mooplans.dao;

import static com.mooplans.dao.DBConnection.connection;
import static com.mooplans.dao.DBConnection.getConnection;
import static com.mooplans.dao.DBConnection.pstmt;
import static com.mooplans.dao.DBConnection.release;

import java.sql.SQLException;

import com.mooplans.model.User;

public class FeedbackDAO {
	
	
	public static int insertFeedback(User user){
		int ID = -1;
		try{
				getConnection();
				String sql = "INSERT INTO user_feedback (user_name, user_email,"
						+ " user_phone, message)"
						+ " VALUES (?, ?, ?, ?)";
				pstmt = connection.prepareStatement(sql);

				pstmt.setString(1, user.getUser_firstname());
				pstmt.setString(2, user.getUser_email());
				pstmt.setString(3, user.getUser_phone());
				pstmt.setString(4, user.getUser_message());
				ID = pstmt.executeUpdate();
				
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return ID;
	}

}
