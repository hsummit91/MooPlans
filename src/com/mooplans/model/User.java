package com.mooplans.model;

import java.util.Date;

public class User{

	private static final long serialVersionUID = 1L;
	
	private String user_password, user_firstname,user_lastname,user_email,delivery_time;
	private String user_phone,user_university, user_address, user_role, user_image,user_message;
	private int user_id;
	private float user_points;
	private Date orderTimestamp;
	
	public User(){
		// Default constructor
	}
	
	public String getDelivery_time() {
		return delivery_time;
	}

	public void setDelivery_time(String delivery_time) {
		this.delivery_time = delivery_time;
	}

	public User(String user_password, String user_firstname,
			String user_lastname, String user_email, String user_phone,
			String user_university, String user_address, String user_role,
			int user_id, float user_points) {
		this.user_password = user_password;
		this.user_firstname = user_firstname;
		this.user_lastname = user_lastname;
		this.user_email = user_email;
		this.user_phone = user_phone;
		this.user_university = user_university;
		this.user_address = user_address;
		this.user_role = user_role;
		this.user_id = user_id;
		this.user_points = user_points;
	}
	
	// Constructor for getting User feedback
	public User(String user_firstname,String user_email, String user_phone,String user_message) {
		this.user_firstname = user_firstname;
		this.user_email = user_email;
		this.user_phone = user_phone;
		this.user_message = user_message;
	}
	

	public String getUser_message() {
		return user_message;
	}

	public void setUser_message(String user_message) {
		this.user_message = user_message;
	}

	public String getUser_image() {
		return user_image;
	}
	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}
	
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_firstname() {
		return user_firstname;
	}
	public void setUser_firstname(String user_firstname) {
		this.user_firstname = user_firstname;
	}
	public String getUser_lastname() {
		return user_lastname;
	}
	public void setUser_lastname(String user_lastname) {
		this.user_lastname = user_lastname;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_university() {
		return user_university;
	}
	public void setUser_university(String user_university) {
		this.user_university = user_university;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_role() {
		return user_role;
	}
	public void setUser_role(String user_role) {
		this.user_role = user_role;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public float getUser_points() {
		return Float.parseFloat(String.format( "%.2f",user_points));
	}
	public void setUser_points(float user_points) {
		this.user_points = user_points;
	}

	public Date getOrderTime() {
		return orderTimestamp;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTimestamp = orderTime;
	}
	
}
