package com.mooplans.model;

import java.util.ArrayList;

public class Order {
	private int order_id, order_number, order_user_id, order_rest_id;
	private float order_total;
	private String order_deliverat;
	private ArrayList<OrderItems> order_content;
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getOrder_number() {
		return order_number;
	}
	public void setOrder_number(int order_number) {
		this.order_number = order_number;
	}
	public int getOrder_user_id() {
		return order_user_id;
	}
	public void setOrder_user_id(int order_user_id) {
		this.order_user_id = order_user_id;
	}
	public int getOrder_rest_id() {
		return order_rest_id;
	}
	public void setOrder_rest_id(int order_rest_id) {
		this.order_rest_id = order_rest_id;
	}
	public float getOrder_total() {
		return order_total;
	}
	public void setOrder_total(float order_total) {
		this.order_total = order_total;
	}
	public String getOrder_deliverat() {
		return order_deliverat;
	}
	public void setOrder_deliverat(String order_deliverat) {
		this.order_deliverat = order_deliverat;
	}
	public ArrayList<OrderItems> getOrder_content() {
		return order_content;
	}
	public void setOrder_content(ArrayList<OrderItems> order_content) {
		this.order_content = order_content;
	}
	
	

}
