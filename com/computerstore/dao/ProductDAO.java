
package com.computerstore.dao;

import com.computerstore.Service;
import com.computerstore.ServiceImpl;
import com.computerstore.entity.Product;
import com.computerstore.entity.Review;
import java.util.Date;
import java.util.List;

public class ProductDAO extends ServiceImpl<Product> implements Service<Product> {
    
    public ProductDAO() {
        super();
    }

    @Override
    public Product create(Product e) {
        e.setUpdateProductDate(new Date());
        return super.create(e); 
    }

    @Override
    public Product update(Product e) {
        e.setUpdateProductDate(new Date());
        return super.update(e);
    }

    @Override
    public List<Product> showAll() {
        return super.createNamedQuery("Product.showProducts");
    }

    @Override
    public Product get(Object id) {
        return super.get(Product.class, id);
    }

    @Override
    public void delete(Object id) {
        super.delete(Product.class, id);
    }

    public Product findProductByTitle(String title) {
        List<Product> result = super.findWithNamedQueries("Product.findProductByTitle", "title", title);
        
        if(!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    public List<Product> productsByCategory(int productID) {
        return super.findWithNamedQueries("Product.productByCategory", "productId", productID);
    }

    public List<Product> search(String keyword) {
        return super.findWithNamedQueries("Product.search", "keyword", "%" + keyword + "%");
    }

    public List<Product> latestProducts() {
        return super.findWithNamedQueries("Product.latestProducts", 0, 3);
    }

    public long count() {
        return super.countWithNamedQuery("Product.countAll");
    }
    
    
}
