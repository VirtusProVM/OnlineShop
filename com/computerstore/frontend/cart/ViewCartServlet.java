
package com.computerstore.frontend.cart;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ViewCartServlet", urlPatterns = {"/viewCart"})
public class ViewCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Object obj = request.getSession().getAttribute("cart");
        
        if(obj == null) {
            Cart cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("frontend/cart.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
