package com.computerstore.dao;

import com.computerstore.Service;
import com.computerstore.ServiceImpl;
import com.computerstore.entity.Customer;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerDAO extends ServiceImpl<Customer> implements Service<Customer> {
    
    public CustomerDAO() {
        super();
    }

    @Override
    public Customer create(Customer e) {
        e.setRegisterDate(new Date());
        return super.create(e);
    }

    @Override
    public Customer update(Customer e) {
        return super.update(e);
    }
    
    @Override
    public List<Customer> showAll() {
        return super.createNamedQuery("Customer.showAllCustomers");
    }

    @Override
    public Customer get(Object id) {
        return super.get(Customer.class, id);
    }

    @Override
    public void delete(Object id) {
        super.delete(Customer.class, id);
    }

    public Customer findCustomerByEmail(String email) {
        List<Customer> result = super.findWithNamedQueries("Customer.findCustomerByEmail", "em", email);
        
        if(!result.isEmpty()) {
            return result.get(0);
        }
        
        return null;
    }

    public Customer checkLogin(String email, String password) {
        Map<String, Object> parameters = new HashMap<>();
        
        parameters.put("em", email);
        parameters.put("pass", password);
        
        List<Customer> result = super.findWithNamedQueries("Customer.checkLogin", parameters);
        
        if(!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    public List<Customer> latestCustomers() {
        return super.findWithNamedQueries("Customer.showAllCustomers", 0, 3);
    }

    public long count() {
        return super.countWithNamedQuery("Customer.countAll");
    }
    
    
}
