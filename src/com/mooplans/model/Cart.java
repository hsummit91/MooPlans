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
    private float totalBill;
    PayPalDAO pd;
    
    public Cart(){
     cartItems = new HashMap<>();     
     cartNotes = new HashMap<>(); 
     pd = new PayPalDAO();
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
    public HashMap<Integer, String> getCartNotes(){
        return cartNotes;
    }
    public void addToCart(int id, String itemName, String notes){
        cartItems.put(id, itemName);
        cartNotes.put(id, notes);
    }
    
    public void deleteFromCart(int itemId){
        cartItems.remove(itemId);
        cartNotes.remove(itemId);
    }
	public float getTotalBill() {		
		float totalBill = 0;
		for(Integer key: cartItems.keySet()){
			System.out.println(key +" ---- "+pd.getBill(key));
			totalBill += pd.getBill(key);
		}
		System.out.println("========>"+totalBill);
		return totalBill;
	}
	public void setTotalBill(float totalBill) {
		this.totalBill = totalBill;
	}    
}
