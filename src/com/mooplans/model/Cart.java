package com.mooplans.model;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mooplans.dao.PayPalDAO;
/**
 *
 * @author fahad
 */
public class Cart {
    HashMap<Integer, String> cartItems;
    HashMap<Integer, String> cartNotes;
    HashMap<Integer, Float> cartPrice;
    HashMap<Integer, Float> cartFullPrice;
    private float totalBill;
    private int dishExtra;
    
    JSONArray priceArray = new JSONArray();
    PayPalDAO pd;
    
    public Cart(){
     cartItems = new HashMap<>();     
     cartNotes = new HashMap<>(); 
     cartFullPrice = new HashMap<Integer, Float>();
     cartPrice = new HashMap<Integer, Float>();
     dishExtra = 0;
     
     pd = new PayPalDAO();
    }
    
    public JSONArray getCartArray(){
    	JSONArray cartArray = new JSONArray();
    	for(Integer key: cartItems.keySet()){
    		JSONObject cartObject = new JSONObject();
    		try {
				cartObject.put("dishId", key);
				cartObject.put("dishName", cartItems.get(key));
				cartObject.put("dishPrice", cartPrice.get(key));
				cartObject.put("dishFullPrice", cartFullPrice.get(key));
				cartArray.put(cartObject);
			} catch (JSONException e) {
				e.printStackTrace();
			}
    	}
    	return cartArray;
    }
    
    public int numberOfItems(){
    	if(cartItems == null){
    		return 0;
    	}else{
    		return cartItems.size();
    	}
    }
    public HashMap<Integer, String> getCartItems(){
        return cartItems;
    }
    public HashMap<Integer, String> getCartNotes(){
        return cartNotes;
    }
    public HashMap<Integer, Float> getCartPrice(){
        return cartPrice;
    }
    public HashMap<Integer, Float> getCartFullPrice(){
        return cartFullPrice;
    }
    public void addToCart(int id, String itemName, String notes, float dishPrice, float dishFullPrice, int dishExtra){
        cartItems.put(id, itemName);
        cartNotes.put(id, notes);
        cartFullPrice.put(id, dishFullPrice);
        cartPrice.put(id,dishPrice);
        this.dishExtra = dishExtra;
    }
    
    public void deleteFromCart(int itemId){
        cartItems.remove(itemId);
        cartNotes.remove(itemId);
        cartPrice.remove(itemId);
        cartFullPrice.remove(itemId);
    }
	public float getTotalBill() {		
		float totalBill = 0;
		for(Integer key: cartItems.keySet()){
			System.out.println(key +" ---- "+pd.getBill(key));
			totalBill += Float.parseFloat(String.format( "%.2f",pd.getBill(key)));
		}
		System.out.println("========>"+totalBill);
		return totalBill;
	}
	
	public float getTotalPriceBill() {		
		float totalBill = 0;
		for(Integer key: cartItems.keySet()){
			System.out.println(key +" ---- "+pd.getPriceBill(key));
			totalBill += Float.parseFloat(String.format( "%.2f",pd.getPriceBill(key)));
		}
		System.out.println("========>"+totalBill);
		return totalBill;
	}
	
	public int getDishExtra() {
		return dishExtra;
	}

	public void setDishExtra(int dishExtra) {
		this.dishExtra = dishExtra;
	}

	public void setTotalBill(float totalBill) {
		this.totalBill = totalBill;
	}    
}
