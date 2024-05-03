
package com.computerstore.order.servlet;

import com.computerstore.entity.ProductDetail;
import com.computerstore.entity.ProductOrder;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Set;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "RemoveProductFromOrderServlet", urlPatterns = {"/admin/removeProductFromOrder"})
public class RemoveProductFromOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Integer id = Integer.parseInt(request.getParameter("id"));
        
        HttpSession session = request.getSession();
        
        ProductOrder order = (ProductOrder) session.getAttribute("order");
        
        Set<ProductDetail> details = order.getProductDetails();
        
        Iterator<ProductDetail> it = details.iterator();
        
        while(it.hasNext()) {
            ProductDetail detail = it.next();
            
            if(detail.getProduct().getProductID() == id) {
                float newTotal = order.getTotal() - detail.getSubtotal();
                order.setTotal(newTotal);
                it.remove();
            }
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/order-form.jsp");
        rd.forward(request, response);
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
