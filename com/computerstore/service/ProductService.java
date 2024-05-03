package com.computerstore.service;

import com.computerstore.dao.CategoryDAO;
import com.computerstore.dao.ProductDAO;
import com.computerstore.entity.Category;
import com.computerstore.entity.Product;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

public class ProductService {
    
    private HttpServletRequest request;
    private HttpServletResponse response;
    
    private ProductDAO dao;
    private CategoryDAO categoryDAO;
    
    public ProductService(HttpServletRequest request, HttpServletResponse response) {
        super();
        this.request = request;
        this.response = response;
        
        dao = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }
    
    public void productList(String message) throws ServletException, IOException {
        List<Product> products = dao.showAll();
        
        request.setAttribute("products", products);
        
        if(message != null) {
            request.setAttribute("message", message);
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/product-list.jsp");
        rd.forward(request, response);
    }
    
    public void productList() throws ServletException, IOException {
        productList(null);
    }
    
    public void createProduct() throws ServletException, IOException {
        
        String name = request.getParameter("title");
        
        Product product = dao.findProductByTitle(name);
        
        if(product != null) {
            String message = "Could not create product with name " + name + ". A product with name " + name + " already exist";
            
            productList(message);
            return;
        } 
            Product newProduct = new Product(name);
            readProductFields(newProduct);
            
            Product createProduct = dao.create(newProduct);
            
            if(createProduct.getProductID()> 0) {
                String message = "Succesfully created new product";
            
                productList(message);
            }
    }

    

    public void editProduct() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("productID"));
        
        Product product = dao.get(id);
        request.setAttribute("product", product);
        
        List<Category> categorys = categoryDAO.showAll();
        request.setAttribute("categorys", categorys);
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/add-product.jsp");
        rd.forward(request, response);
    }

    public void updateProduct() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("productID"));
        String title = request.getParameter("title");
        Product existProduct = dao.get(id);
        Product productByTitle = dao.findProductByTitle(title);
        
        if(productByTitle != null && !existProduct.equals(productByTitle)) {
            String message = "Could not update product because title " + title + "is already exist";
            
            productList(message);
            return;
        }
        readProductFields(existProduct);
        dao.update(existProduct);
        
        String message = "The product has successfully updated";
        productList(message);
    }

    public void deleteProduct() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("productID"));
        
        dao.delete(id);
        
        String message = "Product has been successfully deleted";
        productList(message);
    }
    
    public void productForm() throws ServletException, IOException {
        List<Category> listCategorys = categoryDAO.showAll();
        request.setAttribute("categorys", listCategorys);
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/add-product.jsp");
        rd.forward(request, response);
    }
    
    public void readProductFields(Product newProduct) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        float price = Float.parseFloat(request.getParameter("price"));
        DateFormat format = new SimpleDateFormat("MM/dd/yyyy");
        Date publishDate = null;
        
        try {
            publishDate = format.parse(request.getParameter("publishDate"));
        } catch(ParseException ex) {
            throw new ServletException("Error parsing publish date(format is MM/DD/YYYY)");
        }
        
        newProduct.setTitle(title);
        newProduct.setDescription(description);
        newProduct.setPrice(price);
        newProduct.setPublishDate(publishDate);
        
        int categoryID = Integer.parseInt(request.getParameter("category"));
        Category category = categoryDAO.get(categoryID);
        newProduct.setCategory(category);
        
        
        Part part = request.getPart("productImage");
        
        if(part != null && part.getSize() > 0) {
            long size = part.getSize();
            byte[] imgBytes = new byte[(int)size];
            
            InputStream is = part.getInputStream();
            is.read(imgBytes);
            is.close();
            newProduct.setImage(imgBytes);
        }
    }

    public void viewProductDetails() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("productID"));
        
        Product product = dao.get(id);
                
        request.setAttribute("product", product);
        
        RequestDispatcher rd = request.getRequestDispatcher("frontend/productDetails.jsp");
        rd.forward(request, response);
    }

    public void viewProductByCategory() throws ServletException, IOException {
        int productID = Integer.parseInt(request.getParameter("id"));
        List<Product> products = dao.productsByCategory(productID);
        
        Category category = categoryDAO.get(productID);
        
        request.setAttribute("products", products);
        request.setAttribute("category", category);
        
        RequestDispatcher rd = request.getRequestDispatcher("frontend/productsByCategory.jsp");
        rd.forward(request, response);
    }

    public void search() throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        List<Product> result = null;
        
        if(keyword.equals("")) {
            result = dao.showAll();
        } else {
            result = dao.search(keyword);
        }
        
        request.setAttribute("result", result);
        request.setAttribute("keyword", keyword);
        
        RequestDispatcher rd = request.getRequestDispatcher("frontend/search.jsp");
        rd.forward(request, response);
    }
}
