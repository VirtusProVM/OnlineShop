
package com.computerstore.dao;

import com.computerstore.Service;
import com.computerstore.ServiceImpl;
import com.computerstore.entity.ProductOrder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductOrderDAO extends ServiceImpl<ProductOrder> implements Service<ProductOrder> {

    @Override
    public ProductOrder create(ProductOrder e) {
        e.setOrderDate(new Date());
        e.setStatus("Processing");
        return super.create(e);
    }

    @Override
    public ProductOrder update(ProductOrder e) {
        return super.update(e);
    }
    
    @Override
    public List<ProductOrder> showAll() {
        return super.createNamedQuery("ProductOrder.showAll");
    }

    @Override
    public ProductOrder get(Object id) {
        return super.get(ProductOrder.class, id);
    }
    
    public ProductOrder get(Object orderID, Integer customerID) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("orderId", orderID);
        parameters.put("customerId", customerID);
        List<ProductOrder> result =  super.findWithNamedQuery("ProductOrder.findByIdAndCustomer",parameters);
        if(result.isEmpty()) {
            return result.get(0);
        }

        return null;
    }

    @Override
    public void delete(Object id) {
        super.delete(ProductOrder.class, id);
    }

    public List<ProductOrder> listbyCustomer(Integer customerID) {
        return super.findWithNamedQueries("ProductOrder.findByCustomer", "customerId", customerID);
    }

    public List<ProductOrder> latestOrders() {
        return super.findWithNamedQueries("ProductOrder.showAll", 0, 3);
    }

    public long count() {
        
        return super.countWithNamedQuery("ProductOrder.count");
    }
    
    
}
