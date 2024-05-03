package com.computerstore.frontend.cart;

import com.computerstore.dao.ProductDAO;
import com.computerstore.entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddProductToCart", urlPatterns = {"/addToCart"})
public class AddProductToCart extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Integer id = Integer.parseInt(request.getParameter("id"));
        
        Object cartObject = request.getSession().getAttribute("cart");
        
        Cart shoppingCart = null;
        
        if(cartObject != null && cartObject instanceof Cart) {
            shoppingCart = (Cart) cartObject;
        } else {
            shoppingCart = new Cart();
            request.getSession().setAttribute("cart", shoppingCart);
        }
        
        ProductDAO dao = new ProductDAO();
        Product product = dao.get(id);
        shoppingCart.addProduct(product);
        
        String redirectURL = request.getContextPath().concat("/viewCart");
        response.sendRedirect(redirectURL);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
