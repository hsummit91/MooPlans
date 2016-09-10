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
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			//connection = DriverManager.getConnection("jdbc:mysql://50.62.209.227:3308/moop2823825443","moop2823825443", "U7/I/nddsJ)E");
			connection = DriverManager.getConnection("jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443","moop2823825443", "mooplans2016");
			
		}catch(Exception sql){
			sql.printStackTrace();
			try{
				System.out.println("Trying to connect 1");
				connection = DriverManager.getConnection("jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443","moop2823825443", "mooplans2016");
			}catch(Exception e){
				e.printStackTrace();
				try{
					System.out.println("Trying to connect 2");
					connection = DriverManager.getConnection("jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443","moop2823825443", "mooplans2016");
				}catch(Exception ex){
					ex.printStackTrace();
					try{
						System.out.println("Trying to connect 3");
						connection = DriverManager.getConnection("jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443","moop2823825443", "mooplans2016");
					}catch(Exception ex1){
						ex1.printStackTrace();
						try{
							System.out.println("Trying to connect Final Time!");
							connection = DriverManager.getConnection("jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443","moop2823825443", "mooplans2016");
						}catch(Exception ex2){
							ex2.printStackTrace();
						}
					}
				}
			}
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
