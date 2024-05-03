
package com.computerstore.service;

import com.computerstore.dao.CategoryDAO;
import com.computerstore.entity.Category;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CategoryService {
    
    private HttpServletRequest request;
    private HttpServletResponse response;
    
    private CategoryDAO dao;
    
    public CategoryService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        
        dao = new CategoryDAO();
    }
    
    public void categoryList(String message) throws ServletException, IOException {
        List<Category> categorys = dao.showAll();
        
        request.setAttribute("categories", categorys);
        
        if(message != null) {
            request.setAttribute("message", message);
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/category-list.jsp");
        rd.forward(request, response);
    }
    
    public void categoryList() throws ServletException, IOException {
        categoryList(null);
    }

    public void createCategory() throws ServletException, IOException {
        String name = request.getParameter("name");
        
        Category category = dao.isValidName(name);
        
        if(category != null) {
            String message = "Could not create category with name " + name + ". A category with name " + name + " already exist";
            
            request.setAttribute("message", message);
            
            RequestDispatcher rd = request.getRequestDispatcher("/resources/message.jsp");
            rd.forward(request, response);
        } else {
            Category newCategory = new Category(name);
            dao.create(newCategory);
            String message = "New category created successfully!!!";
            
            categoryList(message);
        }
    }
    
    public void editCategory() throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("categoryID"));
        Category category = dao.get(id);
        
        request.setAttribute("category", category);
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/add-category.jsp");
        rd.forward(request, response);
    }
    
    public void updateCategory() throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("categoryID"));
        String categoryName = request.getParameter("name");
        
        Category categoryById = dao.get(id);
        Category categoryByName = dao.isValidName(categoryName);
        
        if(categoryByName != null && categoryById.getCategoryID() != categoryByName.getCategoryID()) {
            String message = "Could not update category."
                    + "Category with name " + categoryName + " already exist";
            request.setAttribute("message", message);
            
            RequestDispatcher rd = request.getRequestDispatcher("/resources/message.jsp");
            rd.forward(request, response);
        } else {
            categoryById.setName(categoryName);
            dao.update(categoryById);
            String message = "Category has been updated successfully";
            categoryList(message);
        }
    }
    
    /*public void deleteCategory() {
        Integer categoryID = Integer.parseInt(request.getParameter("id"));
        ProductDAO bookDAO = new ProductDAO();
        long numberOfBooks = bookDAO.countByCategory(categoryID);
        String message;
        
        if(numberOfBooks > 0) {
            message = "Could not delete category because it contains some books";
            String.format(message, numberOfBooks);
        } else {
            dao.delete(categoryID);
        
            message = "Category with ID " + categoryID  + " has been successfully deleted";
        }
        
        
        categoryList(message);
    }*/
    
    public void deleteCategory() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("categoryID"));
        
        dao.delete(id);
        
        String message = "Category with ID " + id  + " has been successfully deleted";
        
        categoryList(message);
    }
}
