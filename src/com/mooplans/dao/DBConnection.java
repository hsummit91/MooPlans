package com.mooplans.dao;


import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnection {

	public static Connection connection;
	public static PreparedStatement pstmt;
	public static ResultSet rs;
	
	public DBConnection(){}

	public static void getConnection(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443","moop2823825443", "mooplans2016");
			//connection = DriverManager.getConnection("jdbc:mysql://50.62.209.227:3308/moop2823825443","moop2823825443", "U7/I/nddsJ)E");
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
			if(rs != null){
				rs.close();
			}
		}catch(SQLException e){
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
	}

}
