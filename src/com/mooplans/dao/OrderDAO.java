package com.mooplans.dao;

import static com.mooplans.dao.DBConnection.connection;
import static com.mooplans.dao.DBConnection.getConnection;
import static com.mooplans.dao.DBConnection.pstmt;
import static com.mooplans.dao.DBConnection.release;
import static com.mooplans.dao.DBConnection.rs;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mooplans.model.Dishes;
import com.mooplans.model.Order;
import com.mooplans.model.OrderItems;
import com.mooplans.model.StartupData;
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
					   + "FROM orders where order_user_id = ? order by order_date DESC";
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
	
	public static JSONArray getAllOrders(){
		JSONArray userDetailsArr = new JSONArray();
		HashMap<Integer, Dishes> dishData = StartupData.getInstance().getDishData();
		try{
			getConnection();
			String sql = "SELECT order_id, order_total, order_deliverat, order_date, order_ids, order_user_id, "
					   + "order_phone, delivery_time, is_polled, order_notes, payment_mode "
					   + "FROM orders order by order_date DESC LIMIT 20";
			pstmt = connection.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()){
				JSONObject userDetails = new JSONObject();
				userDetails.put("userId",rs.getInt(6));
				userDetails.put("orderId", rs.getString(1));
				userDetails.put("orderTotal", rs.getString(2));
				userDetails.put("deliver", rs.getString(3));
				userDetails.put("orderDate", rs.getString(4));
				userDetails.put("orderPhone", rs.getString(7));
				userDetails.put("time", rs.getString(8));
				userDetails.put("mailSent", rs.getString(9));
				userDetails.put("notes", rs.getString(10));
				userDetails.put("paymentMode", rs.getString(11));
				
				String dishIds = rs.getString(5);
				String[] dishArr = dishIds.split(",");
				System.out.println("--dishID--"+dishIds);
				ArrayList<String> dishes = new ArrayList<String>();
				
				for(int i=0;i<dishArr.length;i++){
					Dishes d = dishData.get(Integer.parseInt(dishArr[i]));
					//System.out.println(d);
					
					dishes.add(d.getDishName() +" - "+d.getRest_name() );
				}
				
				/*String sql2 = "select dish_name, rest_name from dishes join restaurant on rest_id = dish_rest_id where dish_id in ("+rs.getString(5)+")";
				pstmt = connection.prepareStatement(sql2);
				ResultSet rs1 = pstmt.executeQuery();
				ArrayList<String> dishes = new ArrayList<String>();
				while(rs1.next()){
					dishes.add(rs1.getString(1) + " - " + rs1.getString(2));
				}*/
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
