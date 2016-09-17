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
    HashMap<Integer, Float> cartDcntPrice;
    HashMap<Integer, Float> cartDcntPoints;
    HashMap<Integer, Integer> cartQty;
    
    private float totalBill;
    private float dishExtra;
    
    JSONArray cartJSONArray;
    
    int qty = 1;
    
    JSONArray priceArray = new JSONArray();
    PayPalDAO pd;
    HashMap<Integer, Dishes> dishData;
    
    public Cart(){
     cartItems = new HashMap<>();     
     cartNotes = new HashMap<>(); 
     cartFullPrice = new HashMap<Integer, Float>();
     cartPrice = new HashMap<Integer, Float>();
     cartDcntPrice = new HashMap<Integer, Float>();
     cartDcntPoints = new HashMap<Integer, Float>();
     
     cartQty = new HashMap<Integer, Integer>();
     dishExtra = 0;
     
     cartJSONArray = new JSONArray();
     
     dishData = StartupData.getInstance().dishData;
     
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
    public void addToCart(int id, String itemName, String notes, float dishPrice, float dishFullPrice, float dishExtra){
/*    	if(cartItems.containsKey(id)){
    		int newQty = cartQty.get(id);
    		newQty++;
    		cartQty.put(id, newQty);
    		System.out.println("-qty-"+newQty);
    	}else{*/
	        cartItems.put(id, itemName);
	        cartNotes.put(id, notes);
	        cartFullPrice.put(id, dishFullPrice);
	        cartPrice.put(id,dishPrice);
	        cartDcntPrice.put(id,dishData.get(id).getDcntPrice());
	        cartDcntPoints.put(id,dishData.get(id).getDcntPoints());
	        
	        cartQty.put(id,qty);
	        this.dishExtra += dishExtra;
 //   	}
        
/*        JSONObject item = new JSONObject();
        try {
			item.put("id", id);
			item.put("restEmail", dishData.get(id).getRestEmail());
			item.put("price", dishPrice);
			item.put("fullPrice", dishFullPrice);
			item.put("notes", notes);
			item.put("addOn", dishExtra);
		} catch (JSONException e) {
			e.printStackTrace();
		}
        cartJSONArray.put(item);
        
        System.out.println(cartJSONArray);*/
        
    }
    
    public void deleteFromCart(int itemId){
    	
/*    	int qty = cartQty.get(itemId);
    	if(qty > 1){
    		qty--;
    		cartQty.put(itemId, qty);
    	}else{*/
            cartItems.remove(itemId);
            cartNotes.remove(itemId);
            cartPrice.remove(itemId);
            cartFullPrice.remove(itemId);	
 //   	}
    }
	public float getTotalBill() {		
		float totalBill = 0;
		for(Integer key: cartItems.keySet()){
			System.out.println(key +" ---- "+PayPalDAO.getBill(key));
			totalBill += Float.parseFloat(String.format( "%.2f",PayPalDAO.getBill(key)));
		}
		System.out.println("====getTotalBill====>"+totalBill);
		return totalBill;
	}
	
	public float getDiscountedPointsBill() {		
		float totalBill = 0;
		for(Integer key: cartItems.keySet()){
			System.out.println(key +" ---- "+PayPalDAO.getDiscountedPointsBill(key));
			totalBill += Float.parseFloat(String.format( "%.2f",PayPalDAO.getDiscountedPointsBill(key)));
		}
		System.out.println("====getDiscountedPointsBill====>"+totalBill);
		return totalBill;
	}
	
	public float getDiscountedBill() {		
		float totalBill = 0;
		for(Integer key: cartItems.keySet()){
			System.out.println(key +" ---- "+PayPalDAO.getDiscountedBill(key));
			totalBill += Float.parseFloat(String.format( "%.2f",PayPalDAO.getDiscountedBill(key)));
		}
		System.out.println("====getDiscountedBill====>"+totalBill);
		return totalBill;
	}	
	
	public float getTotalPriceBill() {		
		float totalBill = 0;
		for(Integer key: cartItems.keySet()){
			System.out.println(key +" ---- "+PayPalDAO.getPriceBill(key));
			totalBill += Float.parseFloat(String.format( "%.2f",PayPalDAO.getPriceBill(key)));
		}
		System.out.println("====getTotalPriceBill====>"+totalBill);
		return totalBill;
	}
	
	public float getDishExtra() {
		return dishExtra;
	}

	public void setDishExtra(int dishExtra) {
		this.dishExtra = dishExtra;
	}

	public void setTotalBill(float totalBill) {
		this.totalBill = totalBill;
	}

	public HashMap<Integer, Float> getCartDcntPrice() {
		return cartDcntPrice;
	}

	public void setCartDcntPrice(HashMap<Integer, Float> cartDcntPrice) {
		this.cartDcntPrice = cartDcntPrice;
	}

	public HashMap<Integer, Float> getCartDcntPoints() {
		return cartDcntPoints;
	}

	public void setCartDcntPoints(HashMap<Integer, Float> cartDcntPoints) {
		this.cartDcntPoints = cartDcntPoints;
	}

	public void setCartFullPrice(HashMap<Integer, Float> cartFullPrice) {
		this.cartFullPrice = cartFullPrice;
	}    
}
