package com.computerstore.service;

import com.computerstore.entity.Customer;
import com.computerstore.entity.Product;
import com.computerstore.entity.ProductDetail;
import com.computerstore.entity.ProductOrder;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaymentService {
    
    private static final String CLIENT_ID = "";
    private static final String CLIENT_SECRET = "";
    
    private String mode = "sandbox";
    
    private HttpServletRequest request;
    private HttpServletResponse response;

    public PaymentService(HttpServletRequest request, HttpServletResponse response) {
        super();
        this.request = request;
        this.response = response;
    }
    
    public void authorizePayment(ProductOrder order) throws IOException {
        
        Payer payer = getPayerInformation(order);
        
        RedirectUrls urls = getRedirectUrls();
        
        //Amount amount = getAmountDetails(order);
        
        List<Transaction> transactions = getTransactionInformation(order);
        
        Payment requestPayment = new Payment();
        requestPayment.setPayer(payer).setRedirectUrls(urls).setIntent("authorize").setTransactions(transactions);
        
        APIContext apic = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
        try {
            Payment authorizePayment = requestPayment.create(apic);
            
            String approvalUrl = getApprovalURL(authorizePayment);
            
            response.sendRedirect(approvalUrl);
                    
        } catch (PayPalRESTException ex) {
            ex.printStackTrace();
        }
    }
    
    public Payer getPayerInformation(ProductOrder order) {
        
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");
        
        Customer customer = order.getCustomer();
        
        PayerInfo info = new PayerInfo();
        info.setFirstName(customer.getFirstname());
        info.setLastName(customer.getLastname());
        info.setEmail(customer.getEmail());
        payer.setPayerInfo(info);
        
        return payer;
    }
    
    public RedirectUrls getRedirectUrls() {
        
        String requestURL = request.getRequestURL().toString();
        String requestURI = request.getRequestURI();
        String mainURL = requestURL.replace(requestURI, "").concat(request.getContextPath());
        
        RedirectUrls urls = new RedirectUrls();
        String cancel = mainURL.concat("/viewCart");
        String returns = mainURL.concat("/reviewPayment");
        urls.setCancelUrl(cancel);
        urls.setReturnUrl(returns);
        
        return urls;
    }
    
    private Amount getAmountDetails(ProductOrder order) {
        
        Details details = new Details();
        details.setShipping(String.format("%.2f", order.getShippingFee()));
        details.setSubtotal(String.format("%.2f", order.getSubtotal()));
        details.setTax(String.format("%.2f", order.getTax()));
        
        Amount amount = new Amount();
        amount.setCurrency("EUR");
        amount.setDetails(details);
        amount.setTotal(String.format("%.2f", order.getTotal()));
        
        return amount;
    }
    
    private ShippingAddress getShippingAddress(ProductOrder order) {
        
        ShippingAddress address = new ShippingAddress();
        String fullname = order.getRecipientFirstname() + " " + order.getRecipientLastname();
        address.setRecipientName(fullname).setPhone(order.getRecipientPhone()).setLine1(order.getRecipientAddress()).setLine2(order.getRecipientAddress2())
                .setCity(order.getRecipientCity()).setCity(order.getRecipientCity()).setCountryCode(order.getRecipientCountry())
                .setPostalCode(order.getRecipientZipcode());
        
        
        return address;
    }
    
    private List<Transaction> getTransactionInformation(ProductOrder order) {
        Transaction transaction = new Transaction();
        transaction.setDescription("Product ordered to company");
        
        Amount amount = getAmountDetails(order);
        transaction.setAmount(amount);
        
        ItemList list = new ItemList();
        ShippingAddress address = getShippingAddress(order);
        list.setShippingAddress(address);
        
        List<Item> is = new ArrayList<>();
        Iterator<ProductDetail> it = order.getProductDetails().iterator();
        
        while(it.hasNext()) {
            
            ProductDetail pd = it.next();
            
            Product product = pd.getProduct();
            Integer quantity = pd.getQuantity();
            
            Item paypalItem = new Item();
            paypalItem.setCurrency("EUR").setName(product.getTitle())
                    .setQuantity(String.valueOf(quantity)).setPrice(String.format("%.2f", product.getPrice()));
            
            is.add(paypalItem);
        }
        
        list.setItems(is);
        transaction.setItemList(list);
        
        List<Transaction> transactions = new ArrayList<>();
        transactions.add(transaction);
        
        return transactions;
    }

    private String getApprovalURL(Payment authorizePayment) {
        String url = null;
        
        List<Links> list = authorizePayment.getLinks();
        
        for(Links l : list) {
            if(l.getRel().equalsIgnoreCase("approval_url")) {
                url = l.getHref();
                break;
            }
        }
        
        return url;
    }

    public void reviewPayment() throws ServletException, IOException {
        String paymentID = request.getParameter("paymentId");
        String payerID = request.getParameter("payerId");
        
        if(paymentID == null || payerID == null) {
            throw new ServletException("ERROR!!!!!");
        }
        
        APIContext apic = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
        
        try {
            Payment payment = Payment.get(apic, paymentID);
            
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            
            Transaction tr = payment.getTransactions().get(0);
            ShippingAddress address = tr.getItemList().getShippingAddress();
            
            request.setAttribute("payer", payerInfo);
            request.setAttribute("address", address);
            request.setAttribute("transaction", tr);
            
            RequestDispatcher rd = request.getRequestDispatcher("frontend/reviewPayment.jsp?paymentId=" + paymentID + "&payerId=" + payerID);
            rd.forward(request, response);
            
        } catch (PayPalRESTException ex) {
            ex.printStackTrace();
        }
        
        
    }

    public Payment executeService() throws PayPalRESTException {
        String paymentID = request.getParameter("paymentId");
        String payerID = request.getParameter("payerId");
        
        PaymentExecution execution = new PaymentExecution();
        execution.setPayerId(payerID);
        
        Payment payment = new Payment();
        payment.setId(paymentID);
        
        APIContext context = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
        
        return payment.execute(context, execution);
        
        
    }
    
    
}
