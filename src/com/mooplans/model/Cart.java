package com.mooplans.model;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
/**
 *
 * @author fahad
 */
public class Cart {
    HashMap<Integer, String> cartItems;
    private float totalBill;
    
    public Cart(){
     cartItems = new HashMap<>();     
    }
    
    public JSONArray getCartArray(){
    	JSONArray cartArray = new JSONArray();
    	for(Integer key: cartItems.keySet()){
    		JSONObject cartObject = new JSONObject();
    		try {
				cartObject.put("dishId", key);
				cartObject.put("dishName", cartItems.get(key));
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
    public void addToCart(int id, String itemName){
        cartItems.put(id, itemName);
    }
    
    public void deleteFromCart(int itemId){
        cartItems.remove(itemId);
    }
	public float getTotalBill() {
		return totalBill;
	}
	public void setTotalBill(float totalBill) {
		this.totalBill = totalBill;
	}    
}
