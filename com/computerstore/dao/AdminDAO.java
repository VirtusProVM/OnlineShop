package com.computerstore.dao;

import com.computerstore.Service;
import com.computerstore.ServiceImpl;
import com.computerstore.entity.Admin;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDAO extends ServiceImpl<Admin> implements Service<Admin> {
    
    public AdminDAO() {
        super();
    }

    @Override
    public List<Admin> showAll() {
        return super.createNamedQuery("Admin.showAll");
    }

    @Override
    public Admin create(Admin e) {
        return super.create(e);
    }

    @Override
    public Admin update(Admin e) {
        return super.update(e);
    }

    @Override
    public Admin get(Object id) {
        return super.get(Admin.class, id);
    }

    @Override
    public void delete(Object id) {
        super.delete(Admin.class, id);
    }

    public Admin findByEmail(String email) {
        List<Admin> admins = super.findWithNamedQueries("Admin.findByEmail", "email", email);
        
        if(admins != null && admins.size() > 1) {
            return admins.get(0);
        }
        
        return null;
    }

    public boolean checkLogin(String email, String password) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("email", email);
        parameters.put("password", password);
        
        List<Admin> lists = super.adminLogin("Admin.adminLogin", parameters);
        
        if(lists.size() == 1) {
            return true;
        }
        return false;
    }
    
    
}
