package com.mooplans.model;

import java.util.ArrayList;

public class Dishes {
	
	//"SELECT dishes.dish_name, dishes.dish_category, restaurant.rest_name, dishes.dish_price "
	//		+ "FROM dishes INNER JOIN restaurant ON dishes.dish_rest_id=restaurant.rest_id";
	
	private int dishId;
	private String dishName;
	private String dishCategory;
	private float dishPrice;
	private int restId;
	private String rest_name;
	private ArrayList<Restaurant> rest_details;
	
	
	public String getRest_name() {
		return rest_name;
	}
	public void setRest_name(String rest_name) {
		this.rest_name = rest_name;
	}
	public int getRestId() {
		return restId;
	}
	public void setRestId(int restId) {
		this.restId = restId;
	}
	public ArrayList<Restaurant> getRest_details() {
		return rest_details;
	}
	public void setRest_details(ArrayList<Restaurant> rest_details) {
		this.rest_details = rest_details;
	}
	public void setDishPrice(float dishPrice) {
		this.dishPrice = dishPrice;
	}
	public int getDishId() {
		return dishId;
	}
	public void setDishId(int dishId) {
		this.dishId = dishId;
	}
	public String getDishName() {
		return dishName;
	}
	public void setDishName(String dishName) {
		this.dishName = dishName;
	}
	public String getDishCategory() {
		return dishCategory;
	}
	public void setDishCategory(String dishCategory) {
		this.dishCategory = dishCategory;
	}
	public float getDishPrice() {
		return dishPrice;
	}
	public void setDishPrice(int dishPrice) {
		this.dishPrice = dishPrice;
	}
	

}
