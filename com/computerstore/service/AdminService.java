package com.computerstore.service;

import com.computerstore.dao.AdminDAO;
import com.computerstore.entity.Admin;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminService {
    
    private HttpServletRequest request;
    private HttpServletResponse response;
    
    private AdminDAO dao;
    
    public AdminService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        
        dao = new AdminDAO();
    }

    public void showAll(String message) throws ServletException, IOException {
        List<Admin> admins = dao.showAll();
        
        request.setAttribute("admins", admins);
        
        if(message != null) {
            request.setAttribute("message", message);
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/listAdmins.jsp");
        rd.forward(request, response);
    }
    
    public void showAll() throws ServletException, IOException {
        showAll(null);
    }
    
    public void createAdmin() throws ServletException, IOException {
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullname");
        String password = request.getParameter("password");
        
        Admin existeAdmin = dao.findByEmail(email);
        
        if(existeAdmin != null) {
            String message = "Could not create admin with email " + email + ".This emai is already in use";
            request.setAttribute("message", message);
            RequestDispatcher rd = request.getRequestDispatcher("/resources/message.jsp");
            rd.forward(request, response);
        } else {
            Admin users = new Admin(email, fullname, password);
            dao.create(users);
            showAll("New Admin created succesfully!!!");
        }
    }
    
    public void editAdmin() throws ServletException, IOException{
        Integer id = Integer.parseInt(request.getParameter("adminID"));
        Admin admin = dao.get(id);

        request.setAttribute("admin", admin);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/admin/add-admin.jsp");
        requestDispatcher.forward(request, response);
    }
    
    public void updateAdmin() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("adminID"));
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullname");
        String password = request.getParameter("password");
        
        Admin adminById = dao.get(id);
        
        Admin adminByEmail = dao.findByEmail(email);
        
        if(adminByEmail != null && adminByEmail.getAdminID() != adminById.getAdminID()) {
            String message = "Could not update admin.Admin with email " + email + " already exist!!!";
            request.setAttribute("message", message);
            
            RequestDispatcher rd = request.getRequestDispatcher("/resources/message.jsp");
            rd.forward(request, response);
        } else {
            Admin admin = new Admin(id, email, password, fullname);
            dao.update(admin);

            String message = "Admin updated succesfully";
            showAll(message);
        }
        
        
    }

    public void deleteAdmin() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("adminID"));
        
        dao.delete(id);
        
        String message = "Admin has been deleted succesfully";
        showAll(message);
    }
    
    public void login() throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        boolean isLoginSuccessfully = dao.checkLogin(email, password);
        
        if(isLoginSuccessfully) {
            request.getSession().setAttribute("useremail", email);
            
            RequestDispatcher rd = request.getRequestDispatcher("/admin");
            rd.forward(request, response);
        } else {
            String message = "Login failed!!!";
            request.setAttribute("message", message);
            
            RequestDispatcher rd = request.getRequestDispatcher("/admin/login.jsp");
            rd.forward(request, response);
        }
        
    }
}
