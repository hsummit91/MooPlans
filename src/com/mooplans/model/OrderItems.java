package com.mooplans.model;

public class OrderItems {
	private int order_items_id, order_items_order_id, order_items_qty;
	private String order_items_itemname;
	public int getOrder_items_id() {
		return order_items_id;
	}
	public void setOrder_items_id(int order_items_id) {
		this.order_items_id = order_items_id;
	}
	public int getOrder_items_order_id() {
		return order_items_order_id;
	}
	public void setOrder_items_order_id(int order_items_order_id) {
		this.order_items_order_id = order_items_order_id;
	}
	public int getOrder_items_qty() {
		return order_items_qty;
	}
	public void setOrder_items_qty(int order_items_qty) {
		this.order_items_qty = order_items_qty;
	}
	public String getOrder_items_itemname() {
		return order_items_itemname;
	}
	public void setOrder_items_itemname(String order_items_itemname) {
		this.order_items_itemname = order_items_itemname;
	}
	
	
}
