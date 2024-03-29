package com.mooplans.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnThread {
	public static Connection connection;
	public static PreparedStatement pstmt;
	public static CallableStatement cstmt;
	public static ResultSet rs;
	
	public DBConnThread(){}

	public static void getConnection(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			//connection = DriverManager.getConnection("jdbc:mysql://50.62.209.227:3308/moop2823825443","moop2823825443", "U7/I/nddsJ)E");
			connection = DriverManager.getConnection("jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443","moop2823825443", "mooplans2016");
			
		}catch(SQLException sql){
			sql.printStackTrace();
		}catch(ClassNotFoundException c){
			c.printStackTrace();
		}
	}

	public static void release(){
		try{
			if(connection != null){
				connection.close();
			}
			if(pstmt != null){
				pstmt.close();
			}
			if(cstmt != null){
				cstmt.close();
			}
			if(rs != null){
				rs.close();
			}
		}catch(SQLException e){
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
