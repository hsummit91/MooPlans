package com.mooplans.model;

import java.util.ArrayList;

public class Dishes {
	
	private int dishId;
	private String dishName;
	private String dishCategory;
	private float dishPrice;
	private int restId;
	private String rest_name;
	private String restEmail;
	private String restPhone;
	private String dishDescription;
	private String dishChoice;
	private String dishSides;
	private String dishHealth;
	private ArrayList<Restaurant> rest_details;
	private float dishFullPrice;
	private int deliveryFee;
	
	private int restaurantType;
	private float dcntPrice;
	private float dcntPoints;
	private float mrktFee;
	private float mrktPoints;
	
	@Override
	public String toString() {
		return "Dishes [dishId=" + dishId + ", dishName=" + dishName
				+ ", dishCategory=" + dishCategory + ", dishPrice=" + dishPrice
				+ ", restId=" + restId + ", rest_name=" + rest_name
				+ ", restEmail=" + restEmail + ", restPhone=" + restPhone
				+ ", dishDescription=" + dishDescription + ", dishChoice="
				+ dishChoice + ", dishSides=" + dishSides + ", dishHealth="
				+ dishHealth + ", rest_details=" + rest_details
				+ ", dishFullPrice=" + dishFullPrice + ", deliveryFee="
				+ deliveryFee + ", restaurantType=" + restaurantType
				+ ", dcntPrice=" + dcntPrice + ", dcntPoints=" + dcntPoints
				+ ", mrktFee=" + mrktFee + ", mrktPoints=" + mrktPoints
				+ ", comments=" + comments + "]";
	}
	private String comments;
	
	
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	
	
	public String getRestPhone() {
		return restPhone;
	}
	public void setRestPhone(String restPhone) {
		this.restPhone = restPhone;
	}
	
	public String getDishDescription() {
		return dishDescription;
	}
	public void setDishDescription(String dishDescription) {
		this.dishDescription = dishDescription;
	}
	public String getDishChoice() {
		return dishChoice;
	}
	public void setDishChoice(String dishChoice) {
		this.dishChoice = dishChoice;
	}
	public String getDishSides() {
		return dishSides;
	}
	public void setDishSides(String dishSides) {
		this.dishSides = dishSides;
	}
	public String getDishHealth() {
		return dishHealth;
	}
	public void setDishHealth(String dishHealth) {
		this.dishHealth = dishHealth;
	}
	public String getRestEmail() {
		return restEmail;
	}
	public void setRestEmail(String restEmail) {
		this.restEmail = restEmail;
	}
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
	public float getDishFullPrice() {
		return dishFullPrice;
	}
	public void setDishFullPrice(float dishFullPrice) {
		this.dishFullPrice = dishFullPrice;
	}
	public int getDeliveryFee() {
		return deliveryFee;
	}
	public void setDeliveryFee(int deliveryFee) {
		this.deliveryFee = deliveryFee;
	}
	public int getRestaurantType() {
		return restaurantType;
	}
	public void setRestaurantType(int restaurantType) {
		this.restaurantType = restaurantType;
	}
	public float getDcntPrice() {
		return dcntPrice;
	}
	public void setDcntPrice(float dcntPrice) {
		this.dcntPrice = dcntPrice;
	}
	public float getDcntPoints() {
		return dcntPoints;
	}
	public void setDcntPoints(float dcntPoints) {
		this.dcntPoints = dcntPoints;
	}
	public float getMrktFee() {
		return mrktFee;
	}
	public void setMrktFee(float mrktFee) {
		this.mrktFee = mrktFee;
	}
	public float getMrktPoints() {
		return mrktPoints;
	}
	public void setMrktPoints(float mrktPoints) {
		this.mrktPoints = mrktPoints;
	}
	

}
