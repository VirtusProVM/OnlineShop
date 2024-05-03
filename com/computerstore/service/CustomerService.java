
package com.computerstore.service;

import com.computerstore.MyUtilities;
import com.computerstore.dao.CustomerDAO;
import com.computerstore.entity.Customer;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CustomerService {
    
    private final HttpServletRequest request;
    private final HttpServletResponse response;
    private CustomerDAO customerDAO;

    public CustomerService(HttpServletRequest request, HttpServletResponse response) {
        super();
        this.request = request;
        this.response = response;
        customerDAO = new CustomerDAO();
    }
    
    public void customerList(String message) throws ServletException, IOException {
        List<Customer> customers = customerDAO.showAll();
        
        request.setAttribute("customers", customers);
        
        if(message != null) {
            request.setAttribute("message", message);
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/customer-list.jsp");
        rd.forward(request, response);
    }
    
    public void customerList() throws ServletException, IOException {
        customerList(null);
    }

    public void customerForm() throws ServletException, IOException {
        MyUtilities.loadCountries(request);
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/customer-form.jsp");
        rd.forward(request, response);
    }

    public void createCustomer() throws ServletException, IOException {
        String email = request.getParameter("email");
        
        Customer exist = customerDAO.findCustomerByEmail(email);
        
        if(exist != null) {
            String message = "Could not create customer because email already registered for another customer";
            customerList(message);
        } else {
            Customer newCustomer = new Customer();
            updateCustomerFieldsFromForm(newCustomer);
            customerDAO.create(newCustomer);
                        
            String message = "Customer successfully created";
            customerList(message);
        }
    }

    private void updateCustomerFieldsFromForm(Customer customer) {
        String email = request.getParameter("email");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address1 = request.getParameter("addressLine_1");
        String address2 = request.getParameter("addressLine_2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zipcode");
        String country = request.getParameter("country");
        
        if(email != null && !email.equals("")) {
            customer.setEmail(email);
        }

        customer.setFirstname(firstname);
        customer.setLastname(lastname);
        
        if(password != null && !password.equals("")) {
            customer.setPassword(password);
        }
        
        customer.setPhoneNumber(phone);
        customer.setAddressLine1(address1);
        customer.setAddressLine2(address2);
        customer.setCity(city);
        customer.setState(state);
        customer.setZipCode(zipcode);
        customer.setCountry(country);
    }

    public void editCustomer() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("customerID"));
        
        Customer customer = customerDAO.get(id);
        
        request.setAttribute("customer", customer);
        
        MyUtilities.loadCountries(request);
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/customer-form.jsp");
        rd.forward(request, response);
    }

    public void updateCustomer() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("customerID"));
        String email = request.getParameter("email");
        Customer customerByEmail = customerDAO.findCustomerByEmail(email);
        String message = null;
        if(customerByEmail != null && customerByEmail.getCustomerID() != id) {
            message = "Could not update customer with id " + id + " because there is an existing customer having same email"; 
        } else {
            Customer customer = customerDAO.get(id);
            updateCustomerFieldsFromForm(customer);
            
            customerDAO.update(customer);
            
            message = "The customer has been successfully updated";
            
        }
        customerList(message);

    }
    
    public void deleteCustomer() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("customerID"));
        customerDAO.delete(id);
        
        String message = "Customer deleted successfully";
        customerList(message);
    }

    public void register() throws ServletException, IOException {
        String email = request.getParameter("email");
        
        Customer exist = customerDAO.findCustomerByEmail(email);
        
        String message = "";
        if(exist != null) {
            message = "This email is already taken.The email " + email + " is already registered by another customer";
        } else {
            
            Customer newCustomer = new Customer();
            updateCustomerFieldsFromForm(newCustomer);
            customerDAO.create(newCustomer);
            
            message = "New Customer registered successfully.Thank you! <br />"
                    + "<a href='login'>Click here to login</a>";
        }
        request.setAttribute("msg", message);
        
        RequestDispatcher rd = request.getRequestDispatcher("resources/message.jsp");
        rd.forward(request, response);
    }

    public void showRegisterForm() throws ServletException, IOException {
        MyUtilities.loadCountries(request);
        RequestDispatcher rd = request.getRequestDispatcher("frontend/register-form.jsp");
        rd.forward(request, response);
    }

    public void login() throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Customer customer = customerDAO.checkLogin(email, password);
        
        if(customer == null) {
            String message = "Login failed.Please check your email and password";
            request.setAttribute("msg", message);
            showLogin();
        } else {
            
            HttpSession session = request.getSession();
            
            session.setAttribute("loggedCustomer", customer);
            
            Object objRedirectUrl = session.getAttribute("redirectURL");
            
            if(objRedirectUrl != null) {
                String redirectURL = (String) objRedirectUrl;
                session.removeAttribute(redirectURL);
                response.sendRedirect(redirectURL);
            } else {
                showCustomerProfile();
            }
            
            
        }
    }

    private void showLogin() throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("frontend/login.jsp");
        rd.forward(request, response);
    }

    public void showCustomerProfile() throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("frontend/customerProfile.jsp");
        rd.forward(request, response);
    }

    public void editCustomerProfile() throws ServletException, IOException {
        MyUtilities.loadCountries(request);
        RequestDispatcher rd = request.getRequestDispatcher("frontend/editCustomerProfile.jsp");
        rd.forward(request, response);
    }

    public void updateProfile() throws ServletException, IOException {
        MyUtilities.loadCountries(request);
        Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
        
        updateCustomerFieldsFromForm(customer);
        
        customerDAO.update(customer);
        
        showCustomerProfile();
    }
}
