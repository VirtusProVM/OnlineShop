package com.computerstore.admin.servlet;

import com.computerstore.dao.CustomerDAO;
import com.computerstore.dao.ProductDAO;
import com.computerstore.dao.ProductOrderDAO;
import com.computerstore.dao.ReviewDAO;
import com.computerstore.entity.Customer;
import com.computerstore.entity.Product;
import com.computerstore.entity.ProductOrder;
import com.computerstore.entity.Review;
import com.computerstore.service.AdminService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(name = "AdminController", urlPatterns = {"/admin/"})
public class AdminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ProductOrderDAO orderDAO = new ProductOrderDAO();
        List<ProductOrder> orders = orderDAO.latestOrders();
        long countOrders = orderDAO.count();
        request.setAttribute("countOrders", countOrders);
        
        request.setAttribute("orders", orders);
        
        ProductDAO productDAO = new ProductDAO();
        List<Product> products = productDAO.latestProducts();
        long countProduct = productDAO.count();
        request.setAttribute("countProduct", countProduct);
        
        request.setAttribute("products", products);
        
        CustomerDAO customerDAO = new CustomerDAO();
        List<Customer> customers = customerDAO.latestCustomers();
        long countCustomer = customerDAO.count();
        request.setAttribute("countCustomer", countCustomer);
        
        request.setAttribute("customers", customers);
        
        ReviewDAO reviewDAO = new ReviewDAO();
        List<Review> reviews = reviewDAO.latestReviews();
        long countReview = reviewDAO.count();
        request.setAttribute("countReview", countReview);
        request.setAttribute("reviews", reviews);
        
        
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/admin.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
