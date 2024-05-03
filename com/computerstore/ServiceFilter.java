package com.computerstore;

import com.computerstore.dao.CategoryDAO;
import com.computerstore.entity.Category;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

@WebFilter(filterName = "ServiceFilter", urlPatterns = {"/*"})
public class ServiceFilter implements Filter {
    
    private final CategoryDAO categoryDAO;
    
    public ServiceFilter() {
        categoryDAO = new CategoryDAO();
    }    
       
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest servletRequest = (HttpServletRequest) request;
        
        String path = servletRequest.getRequestURI().substring(servletRequest.getContextPath().length());
        
        if(!path.startsWith("/admin/")) {
            List<Category> categorys = categoryDAO.showAll();
            
            request.setAttribute("categorys", categorys);
        }
        chain.doFilter(request, response);
    }


    public void destroy() {        
    }

    public void init(FilterConfig filterConfig) {        
        
    }

}
