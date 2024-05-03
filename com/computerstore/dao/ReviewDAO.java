package com.computerstore.dao;

import com.computerstore.Service;
import com.computerstore.ServiceImpl;
import com.computerstore.entity.Review;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewDAO extends ServiceImpl<Review> implements Service<Review> {
    
    public ReviewDAO() {
        super();
    }

    @Override
    public Review create(Review e) {
        e.setReviewTime(new Date());
        return super.create(e); 
    }

    @Override
    public Review update(Review e) {
        return super.update(e);
    }

    @Override
    public List<Review> showAll() {
        return super.createNamedQuery("Review.listAll");
    }

    @Override
    public Review get(Object id) {
        return super.get(Review.class, id);
    }

    @Override
    public void delete(Object id) {
        super.delete(Review.class, id);
    }

    public Review findByCustomer(Integer customerID, Integer id) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("customerID", customerID);
        parameters.put("productID", id);
        
        List<Review> reviews = super.findWithNamedQueries("Review.findByCustomerAndProduct", parameters);
        
        if(!reviews.isEmpty()) {
            reviews.get(0);
        }
        
        return null;
    }

    public List<Review> latestReviews() {
        return super.findWithNamedQueries("Review.listAll", 0, 5);
    }

    public long count() {
        return super.countWithNamedQuery("Review.countAll");
    }
    
    
}
