package com.mooplans.model;

import java.io.Serializable;

public class Image implements Serializable{
	
	private int imageId;
	private String imagePath;
	
	public int getImageId() {
		return imageId;
	}
	public void setImageId(int imageId) {
		this.imageId = imageId;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
	

}
