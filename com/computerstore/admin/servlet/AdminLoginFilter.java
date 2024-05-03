package com.computerstore.admin.servlet;

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

@WebFilter(filterName = "AdminLoginFilter", urlPatterns = {"/admin/*"})
public class AdminLoginFilter implements Filter {
    
    private RequestDispatcher rd = null;
    
    private static final boolean debug = true;

    private FilterConfig filterConfig = null;
    
    public AdminLoginFilter() {
    }    
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest servletRequest = (HttpServletRequest) request;
        HttpSession session = servletRequest.getSession(false);
        
        boolean isLoggedIn = session != null && session.getAttribute("useremail") != null;
        String loginURI = servletRequest.getContextPath() + "/admin/login";
        boolean isLoginURI = servletRequest.getRequestURI().equals(loginURI);
        boolean isLoginPage = servletRequest.getRequestURI().endsWith("/admin/login.jsp");
        
        if(isLoggedIn && (isLoginURI || isLoginPage)) {
            rd = request.getRequestDispatcher("/admin/");
            rd.forward(request, response);
        }
        else if(isLoggedIn || isLoginURI) {
            chain.doFilter(request, response);
        } else {
            rd = request.getRequestDispatcher("/admin/login.jsp");
            rd.forward(request, response);
        }
    }

    public void destroy() {        
    }

    public void init(FilterConfig filterConfig) {        
        
    }
}
