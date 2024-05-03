package com.computerstore.frontend.cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/updateCart"})
public class UpdateCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String[] arrayProduct = request.getParameterValues("productID");
        String[] arrayQuantities = new String[arrayProduct.length];
        
        for(int i = 1; i <= arrayQuantities.length; i++) {
            String quantity = request.getParameter("quantity" + i);
            arrayQuantities[i - 1] = quantity;
            
        }
        
        int[] productIDs = Arrays.stream(arrayProduct).mapToInt(Integer::parseInt).toArray();
        int[] quantities = Arrays.stream(arrayQuantities).mapToInt(Integer::parseInt).toArray();
        
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        cart.updateCart(productIDs, quantities);
        
        String cartPage = request.getContextPath().concat("/viewCart");
        
        response.sendRedirect(cartPage);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
