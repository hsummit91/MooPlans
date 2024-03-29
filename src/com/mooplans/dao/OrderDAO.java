package com.mooplans.dao;

import static com.mooplans.dao.DBConnection.connection;
import static com.mooplans.dao.DBConnection.getConnection;
import static com.mooplans.dao.DBConnection.pstmt;
import static com.mooplans.dao.DBConnection.release;
import static com.mooplans.dao.DBConnection.rs;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mooplans.model.Order;
import com.mooplans.model.OrderItems;
import com.mooplans.model.User;

import static com.mooplans.dao.LoginDAO.*;

public class OrderDAO {
	
	public static ArrayList<OrderItems> getOrderContent(int order_id){
		ArrayList<OrderItems> items = new ArrayList<OrderItems>();
		try{
			getConnection();
			String sql = "SELECT order_items_id, order_items_itemname, order_items_qty"
					+ " FROM order_items WHERE order_items_order_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, order_id);

			rs = pstmt.executeQuery();
			while(rs.next()){
				OrderItems o = new OrderItems();
				o.setOrder_items_id(rs.getInt(1));
				o.setOrder_items_itemname(rs.getString(2));
				o.setOrder_items_order_id(order_id);
				o.setOrder_items_qty(rs.getInt(3));
				items.add(o);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return items;
	}
	
	public static ArrayList<Order> getOrderDetails(User user){
		ArrayList<Order> userOrders = new ArrayList<Order>();
		
		try{
			getConnection();
			String sql = "SELECT order_id, order_number, order_rest_id, order_total, order_deliverat"
					+ " FROM orders WHERE order_user_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, getUserID(user));

			getConnection(); // connection closed in getUserID(user), hence re-established
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				Order orders = new Order();
				orders.setOrder_id(rs.getInt(1));
				orders.setOrder_number(rs.getInt(2));
				orders.setOrder_rest_id(rs.getInt(3));
				orders.setOrder_total(rs.getInt(4));
				orders.setOrder_deliverat(rs.getString(5));
				orders.setOrder_content(getOrderContent(orders.getOrder_id()));
				userOrders.add(orders);
				getConnection(); // connection closed in getOrderContent(orders.getOrder_id()), hence re-established
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			release();
		}
		return userOrders;
	}
	
	public static JSONArray getPastOrders(int ID){
		JSONArray userDetailsArr = new JSONArray();
		try{
			getConnection();
			String sql = "SELECT order_id, order_total, order_deliverat, order_date, order_ids "
					   + "FROM orders where order_user_id = ?";
			pstmt = connection.prepareStatement(sql);
			pstmt.setInt(1, ID);
			rs = pstmt.executeQuery();

			while(rs.next()){
				JSONObject userDetails = new JSONObject();
				userDetails.put("userId",ID);
				userDetails.put("orderId", rs.getString(1));
				userDetails.put("orderTotal", rs.getString(2));
				userDetails.put("deliver", rs.getString(3));
				userDetails.put("orderDate", rs.getString(4));
				
				String sql2 = "select dish_name from dishes where dish_id in ("+rs.getString(5)+")";
				pstmt = connection.prepareStatement(sql2);
				ResultSet rs1 = pstmt.executeQuery();
				ArrayList<String> dishes = new ArrayList<String>();
				while(rs1.next()){
					dishes.add(rs1.getString(1));
				}
				userDetails.put("orderItems", dishes);
				userDetailsArr.put(userDetails);
			}
			

		}catch(SQLException e){
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}finally{
			release();
		}
		
		System.out.println("ORDERS = "+userDetailsArr);
		
		return userDetailsArr;
	}
}
