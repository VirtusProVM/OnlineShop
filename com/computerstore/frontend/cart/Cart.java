package com.computerstore.frontend.cart;

import com.computerstore.entity.Product;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class Cart {
    
    private Map<Product, Integer> cart = new HashMap<>();
    
    public void addProduct(Product product) {
        if(cart.containsKey(product)) {
            Integer quantity = cart.get(product) + 1;
            cart.put(product, quantity);
        } else {
            cart.put(product, 1);
        }
    }
    
    public Map<Product, Integer> getItems() {
        return this.cart;
    }
    
    public int getTotalQuantity() {
        int total = 0;
        Iterator<Product> it = cart.keySet().iterator();
        
        while(it.hasNext()) {
            Product next = it.next();
            Integer quantity = cart.get(next);
            total += quantity;
        }
        return total;
    }

    public float getTotalAmount() {
        float total = 0.0f;
        Iterator<Product> it = cart.keySet().iterator();
        
        while(it.hasNext()) {
            Product product = it.next();
            Integer quantity = cart.get(product);
            double subTotal = quantity * product.getPrice();
            
            total += subTotal;
        }
        return total;
    }
    
    public void updateCart(int[] productIds, int[] quantities) {
        for(int i = 0; i < productIds.length; i++) {
            Product product = new Product(productIds[i]);
            Integer value = quantities[i];
            cart.put(product, value);
        }
    }

    public void clear() {
        cart.clear();
    }
    
    public int getTotalItems() {
        return cart.size();
    }
    
    public void removeItem(Product product) {
        cart.remove(product);
    }
}
