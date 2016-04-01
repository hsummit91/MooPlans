package com.mooplans.model;

import java.util.HashMap;
/**
 *
 * @author fahad
 */
public class Cart {
    HashMap<Integer, String> cartItems;
    public Cart(){
     cartItems = new HashMap<>();
      
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
     
}
