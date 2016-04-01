package com.mooplans.model;

public class Restaurant {

	private int restId;
	private String restName, restPhone;
	private boolean restStatus = false;

	public boolean isRestStatus() {
		return restStatus;
	}
	public void setRestStatus(boolean restStatus) {
		this.restStatus = restStatus;
	}
	public int getRestId() {
		return restId;
	}
	public void setRestId(int restId) {
		this.restId = restId;
	}
	public String getRestName() {
		return restName;
	}
	public void setRestName(String restName) {
		this.restName = restName;
	}
	public String getRestPhone() {
		return restPhone;
	}
	public void setRestPhone(String restPhone) {
		this.restPhone = restPhone;
	}

}
