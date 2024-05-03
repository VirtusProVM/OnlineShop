
package com.computerstore.order.servlet;

import com.computerstore.dao.ProductDAO;
import com.computerstore.entity.Product;
import com.computerstore.entity.ProductDetail;
import com.computerstore.entity.ProductOrder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AddProductToOrderServlet", urlPatterns = {"/admin/addProductToOrder"})
public class AddProductToOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        int productID = Integer.parseInt(request.getParameter("productID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        ProductDAO dao = new ProductDAO();
        Product product = dao.get(productID);
        
        HttpSession session = request.getSession();
        ProductOrder order = (ProductOrder) session.getAttribute("order");
        
        float subtotal = quantity * product.getPrice();
        
        ProductDetail detail = new ProductDetail();
        detail.setProduct(product);
        detail.setQuantity(quantity);
        detail.setSubtotal(subtotal);
        
        float newTotal = order.getTotal() + subtotal;
        order.setTotal(newTotal);
        
        order.getProductDetails().add(detail);
        
        request.setAttribute("product", product);
        session.setAttribute("NewPendingToAddToOrder", true);
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/add-product-result.jsp");
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
