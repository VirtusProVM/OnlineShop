package com.computerstore.service;

import com.computerstore.dao.ProductDAO;
import com.computerstore.dao.ReviewDAO;
import com.computerstore.entity.Customer;
import com.computerstore.entity.Product;
import com.computerstore.entity.Review;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ReviewService {
    
    private final HttpServletRequest request;
    private final HttpServletResponse response;
    private ReviewDAO dao;

    public ReviewService(HttpServletRequest request, HttpServletResponse response) {
        super();
        this.request = request;
        this.response = response;
        dao = new ReviewDAO();
    }
    
    public void reviewList(String message) throws ServletException, IOException {
        List<Review> reviews = dao.showAll();
        
        request.setAttribute("reviews", reviews);
        
        if(message != null) {
            request.setAttribute("message", message);
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/review-list.jsp");
        rd.forward(request, response);
    }
    
    public void reviewList() throws ServletException, IOException {
        reviewList(null);
    }
    
    public void editReview() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        
        Review review = dao.get(id);
        
        request.setAttribute("review", review);
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/review-form.jsp");
        rd.forward(request, response);
    }
    
    public void updateReview() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("reviewID"));
        String headline = request.getParameter("headline");
        String comment = request.getParameter("comment");
        Review review = dao.get(id);
        review.setHeadline(headline);
        review.setComment(comment);
        
        dao.update(review);
        
        String message = "Review updated successfully";
        
        reviewList(message);
        
    }
    
    public void deleteReview() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        
        dao.delete(id);
        
        String message = "Review successfully deleted";
        
        reviewList(message);
    }

    public void showReviewForm() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.get(id);
        
        HttpSession session = request.getSession();
        
        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        
        request.getSession().setAttribute("product", product);
        
        Review existReview = dao.findByCustomer(customer.getCustomerID(), id);
        
        String page = "frontend/review-form.jsp";
        
        if(existReview != null) {
            request.setAttribute("review", existReview);
            page = "frontend/review-info.jsp";
        }
        
        
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
        
    }

    public void submitReview() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Integer rating = Integer.parseInt(request.getParameter("rating"));
        
        String headline = request.getParameter("headline");
        String comment = request.getParameter("comment");
        
        Review review = new Review();
        review.setHeadline(headline);
        review.setComment(comment);
        review.setRating(rating);
        
        Product book = new Product();
        book.setProductID(id);
        review.setProduct(book);
        
        Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
        
        review.setCustomer(customer);
        
        dao.create(review);
        
        RequestDispatcher rd = request.getRequestDispatcher("frontend/review-done.jsp");
        rd.forward(request, response);
    }
    
}
