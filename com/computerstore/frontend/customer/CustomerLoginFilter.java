
package com.computerstore.frontend.customer;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "CustomerLoginFilter", urlPatterns = {"/*"})
public class CustomerLoginFilter implements Filter {
    
    private static final String[] requiredURLS = {
        "/myProfile", "/editCustomerProfile", "/updateProfile", "/writeReview", "/checkOutOrder", "/placeOrder",
        "/viewOrder", "/showOrderDetails"
    };
    
    public CustomerLoginFilter() {
    }    
    

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpSession session = httpServletRequest.getSession(false);
        
        String path = httpServletRequest.getRequestURI().substring(httpServletRequest.getContextPath().length());
        
        if(path.startsWith("/admin/")) {
            chain.doFilter(request, response);
            return;
        }
        
        boolean loggedIn = session != null && session.getAttribute("loggedCustomer") != null;
        
        String url = httpServletRequest.getRequestURL().toString();
        
        if(!loggedIn && isLoginRequired(url)) {
            
            String queryString = httpServletRequest.getQueryString();
            String redirectURL = url;
            
            if(queryString != null) {
                redirectURL = redirectURL.concat("?").concat(queryString);
            }
            
            session.setAttribute("redirectURL", redirectURL);
            
            RequestDispatcher rd = request.getRequestDispatcher("frontend/login.jsp");
            rd.forward(request, response);
        } else {
            chain.doFilter(request, response);
        }
    }

    public void destroy() {        
    }

    public void init(FilterConfig filterConfig) {        
        
    }

    private boolean isLoginRequired(String url) {
        for(String loginRequiredURLS : requiredURLS) {
            if(url.contains(loginRequiredURLS)) {
                return true;
            }
        }
        return false;
    }

    
}
