package com.computerstore.service;

import com.computerstore.MyUtilities;
import com.computerstore.dao.ProductOrderDAO;
import com.computerstore.entity.Customer;
import com.computerstore.entity.Product;
import com.computerstore.entity.ProductDetail;
import com.computerstore.entity.ProductOrder;
import com.computerstore.frontend.cart.Cart;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;
import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProductOrderService {
    
    private final HttpServletRequest request;
    private final HttpServletResponse response;
    private ProductOrderDAO dao;

    public ProductOrderService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        
        dao = new ProductOrderDAO();
    }
    
    public void ordersList(String message) throws ServletException, IOException {
        List<ProductOrder> orders = dao.showAll();
        
        request.setAttribute("orders", orders);
        
        if(message != null) {
            request.setAttribute("message", message);
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/orders-list.jsp");
        rd.forward(request, response);
    }
    
    public void ordersList() throws ServletException, IOException {
        ordersList(null);
    }
    
    public void showEditOrderForm() throws ServletException, IOException {
        Integer orderId = Integer.parseInt(request.getParameter("orderID"));
               
        HttpSession session = request.getSession();
        Object isPendingProduct = session.getAttribute("NewPendingToAddToOrder");
        if(isPendingProduct == null) {
            ProductOrder order = dao.get(orderId);
            session.setAttribute("order", order);
        } else {
            session.removeAttribute("NewPendingToAddToOrder");
        }

        MyUtilities.loadCountries(request);
        String editPage = "/admin/order-form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
        dispatcher.forward(request, response);
    }

    public void deleteOrder() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("orderID"));
        
        dao.delete(id);
        
        String msg = "Order deleted successfully";
        
        
        ordersList(msg);
    }
    
    private Integer saveOrder(ProductOrder order) {
        ProductOrder save = dao.create(order);
        
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        cart.clear();
        
        return save.getOrderID();
    }

    public void updateOrder() throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        ProductOrder order = (ProductOrder) session.getAttribute("order");
        String firstname = request.getParameter("recipientFirstName");
        String lastname = request.getParameter("recipientLastName");
        String recipientPhone = request.getParameter("recipientPhone");
        String address1 = request.getParameter("recipientAddress");
        String address2 = request.getParameter("recipientAddress2");
        String city = request.getParameter("recipientCity");
        String state = request.getParameter("recipientState");
        String zipcode = request.getParameter("recipientZipcode");
        String country = request.getParameter("country");
        
        float shippingFee = Float.parseFloat(request.getParameter("shippingFee"));
        float tax = Float.parseFloat(request.getParameter("tax"));
        
        String paymentMethod = request.getParameter("paymentMethod");
        String orderStatus = request.getParameter("orderStatus");

        order.setRecipientFirstname(firstname);
        order.setRecipientLastname(lastname);
        order.setRecipientPhone(recipientPhone);
        order.setRecipientAddress(address1);
        order.setRecipientAddress2(address2);
        order.setRecipientCity(city);
        order.setRecipientState(state);
        order.setRecipientZipcode(zipcode);
        order.setRecipientCountry(country);
        order.setShippingFee(shippingFee);
        order.setTax(tax);
        order.setPaymentMethod(paymentMethod);
        order.setStatus(orderStatus);
        
        String[] arrayProductId = request.getParameterValues("productID");
        String[] arrayPrice = request.getParameterValues("price");
        String[] arrayQuantity = new String[arrayProductId.length];
        
        for(int i = 1; i <= arrayQuantity.length; i++) {
            arrayQuantity[i - 1] = request.getParameter("quantity" + i);
            
        }
        
        Set<ProductDetail> details = order.getProductDetails();
        details.clear();
        
        float totalAmount = 0.0f;
        
        for(int i = 0; i < arrayProductId.length; i++) {
            int productID = Integer.parseInt(arrayProductId[i]);
            int quantity = Integer.parseInt(arrayQuantity[i]);
            float price = Float.parseFloat(arrayPrice[i]);
            
            float subtotal = price * quantity;
            
            ProductDetail pd = new ProductDetail();
            pd.setProduct(new Product(productID));
            pd.setProductOrder(order);
            pd.setQuantity(quantity);
            pd.setSubtotal(subtotal);
            
            details.add(pd);
            
            totalAmount += subtotal;
        }
        
        order.setSubtotal(totalAmount);
        totalAmount += shippingFee;
        totalAmount += tax;
        
        order.setTotal(totalAmount);
        
        dao.update(order);
        
        String msg = "The order " + order.getOrderID() + " has been updated successfully";
        
        ordersList(msg);
    }

    public void viewOrderDetailForAdmin() throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("orderID"));
        
        ProductOrder order = dao.get(id);
        
        request.setAttribute("order", order);
        
        RequestDispatcher rd = request.getRequestDispatcher("/admin/order-detail.jsp");
        rd.forward(request, response);
    }

    public void checkoutForm() throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        Cart cart = (Cart) session.getAttribute("cart");
        
        float tax = cart.getTotalAmount() * 0.1f;
        float shippingFee = cart.getTotalQuantity() * 1.0f;
        float total = cart.getTotalAmount() + tax + shippingFee;
        
        session.setAttribute("tax", tax);
        session.setAttribute("shippingFee", shippingFee);
        session.setAttribute("total", total);
        
        MyUtilities.loadCountries(request);
        
        RequestDispatcher rd = request.getRequestDispatcher("/frontend/checkout.jsp");
        rd.forward(request, response);
    }

    public void placeOrder() throws ServletException, IOException {
        
        String paymentMethod = request.getParameter("paymentMethod");
        
        ProductOrder order = getOrderInformation();
        
        if(paymentMethod.equals("paypal")) {
            PaymentService service = new PaymentService(request, response);
            request.getSession().setAttribute("paypalOrder", order);
            service.authorizePayment(order);
        } else {
            placeCashOnDeliveryOrder(order);
        }
        
    }

    public void showOrderDetailForCustomer() throws ServletException, IOException {
        
        Integer orderId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        ProductOrder order = dao.get(orderId,customer.getCustomerID());
        request.setAttribute("order", order);
        String detailPage = "/frontend/order-detail.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
        dispatcher.forward(request, response);
    }

    public void listOrderByCustomer() throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute("loggedCustomer");
        List<ProductOrder> listOrders = dao.listbyCustomer(customer.getCustomerID());
        request.setAttribute("listOrders", listOrders);
        String historyPage = "/frontend/order-list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(historyPage);
        dispatcher.forward(request, response);
    }

    private void placeCashOnDeliveryOrder(ProductOrder order) throws ServletException, IOException {
        
        saveOrder(order);
        
        Cart sc = (Cart) request.getSession().getAttribute("cart");
        
        sc.clear();
        
        String msg = "Thank you.Your order has been recived."
                + "We will deliver your products in few days";
        
        request.setAttribute("message", msg);
        
        RequestDispatcher rd = request.getRequestDispatcher("/resources/message.jsp");
        rd.forward(request, response);
    }
    
    private ProductOrder getOrderInformation() {
        String firstname = request.getParameter("recipientFirstname");
        String lastname = request.getParameter("recipientLastname");
        String recipientPhone = request.getParameter("recipientPhone");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zipcode");
        String country = request.getParameter("country");
        String paymentMethod = request.getParameter("paymentMethod");
        
        ProductOrder order = new ProductOrder();
        order.setRecipientFirstname(firstname);
        order.setRecipientLastname(lastname);
        order.setRecipientPhone(recipientPhone);
        order.setRecipientAddress(address1);
        order.setRecipientAddress2(address2);
        order.setRecipientCity(city);
        order.setRecipientState(state);
        order.setRecipientZipcode(zipcode);
        order.setRecipientCountry(country);
        order.setPaymentMethod(paymentMethod);
        
        HttpSession session = request.getSession();
        
        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        
        order.setCustomer(customer);
        
        Cart sc = (Cart) session.getAttribute("cart");
        
        Map<Product, Integer> items = sc.getItems();
        
        Iterator<Product> iterator = items.keySet().iterator();
        
        Set<ProductDetail> details = new HashSet<>();
        
        while(iterator.hasNext()) {
            Product product = iterator.next();
            Integer quantity = items.get(product);
            float subtotal = quantity * product.getPrice();
            
            ProductDetail od = new ProductDetail();
            od.setProduct(product);
            od.setProductOrder(order);
            od.setQuantity(quantity);
            od.setSubtotal(subtotal);
            
            details.add(od);
        }
        
        order.setProductDetails(details);
        
        float tax = (Float) session.getAttribute("tax");
        float shippingFee = (Float) session.getAttribute("shippingFee");
        float total = (Float) session.getAttribute("total");
        
        
        order.setSubtotal(sc.getTotalAmount());
        order.setTax(tax);
        order.setShippingFee(shippingFee);
        order.setTotal(total);
        
        return order;
    }

    public Integer placePayPalOrder(Payment payment) {
        ProductOrder order = (ProductOrder) request.getSession().getAttribute("paypalOrder");
        
        ItemList list = payment.getTransactions().get(0).getItemList();
        
        ShippingAddress address = list.getShippingAddress();
        
        String shippingPhoneNumber = list.getShippingPhoneNumber();
        
        String recipientName = address.getRecipientName();
        
        String[] names = recipientName.split(" ");
        
        order.setRecipientFirstname(names[0]);
        order.setRecipientLastname(names[1]);
        order.setRecipientAddress(address.getLine1());
        order.setRecipientAddress2(address.getLine2());
        order.setRecipientCity(address.getCity());
        order.setRecipientState(address.getState());
        order.setRecipientCountry(address.getCountryCode());
        order.setRecipientPhone(shippingPhoneNumber);
        
        return saveOrder(order);
        
    }
    
    
}
