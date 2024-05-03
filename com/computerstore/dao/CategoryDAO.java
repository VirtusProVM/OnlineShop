package com.computerstore.dao;

import com.computerstore.Service;
import com.computerstore.ServiceImpl;
import com.computerstore.entity.Category;
import java.util.List;

public class CategoryDAO extends ServiceImpl<Category> implements Service<Category> {
    
    public CategoryDAO() {
        super();
    }

    @Override
    public Category create(Category e) {
        return super.create(e);
    }

    @Override
    public Category update(Category e) {
        return super.update(e);
    }

    @Override
    public List<Category> showAll() {
        return super.createNamedQuery("Category.showAll");
    }

    @Override
    public Category get(Object id) {
        return super.get(Category.class, id);
    }

    @Override
    public void delete(Object id) {
        super.delete(Category.class, id);
    }

    public Category isValidName(String name) {
        List<Category> categorys = super.findWithNamedQueries("Category.isValidName", "name", name);
        
        if(categorys != null && categorys.size() > 0) {
            return categorys.get(0);
        }
        return null;
    }
    
    
}
