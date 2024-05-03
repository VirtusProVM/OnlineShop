package com.computerstore.product.servlet;

import com.computerstore.service.ProductService;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CreateProductServlet", urlPatterns = {"/admin/createProduct"})
@MultipartConfig(fileSizeThreshold = 1024*10, maxFileSize = 1024*300, maxRequestSize = 1024*1024)
public class CreateProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        ProductService service = new ProductService(request, response);
        service.createProduct();
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
