package com.computerstore.payment.servlet;

import com.computerstore.service.PaymentService;
import com.computerstore.service.ProductOrderService;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ExecutePaymentServlet", urlPatterns = {"/executePayment"})
public class ExecutePaymentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, PayPalRESTException {
        response.setContentType("text/html;charset=UTF-8");
        
        PaymentService service = new PaymentService(request, response);
        Payment payment = service.executeService();
        
        ProductOrderService pos = new ProductOrderService(request, response);
        Integer orderID = pos.placePayPalOrder(payment);
        
        HttpSession session = request.getSession();
        session.setAttribute("orderID", orderID);
        
        PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            
        Transaction tr = payment.getTransactions().get(0);

        request.setAttribute("payer", payerInfo);
        request.setAttribute("transaction", tr);

        RequestDispatcher rd = request.getRequestDispatcher("frontend/payment-recipient.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (PayPalRESTException ex) {
            ex.printStackTrace();
        }
    }

}
