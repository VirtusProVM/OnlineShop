
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
    </head>
    <body>
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            <h2>Your Cart Details</h2>
            
            <c:if test="${message != null}">
                <div align="center">
                    <h4 class="message">${message}</h4>
                </div>
            </c:if>
            
            <c:set var="cart" value="${sessionScope['cart']}" />
            
            <c:if test="${cart.totalItems == 0}">
                <h2>There's no items in cart</h2>
            </c:if>
                
            <c:if test="${cart.totalItems > 0}">
                
                <div>
                    <h2>Review Your Order Details <a href="viewCart">Edit</a></h2>
                <table border="1">
                    <tr>
                        <th>No</th>
                        <th colspan="2">Product</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Subtotal</th>
                    </tr>

                    <c:forEach items="${cart.items}" var="item" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                                <img style="height: 100px; width: 100px;" src="data:image/jpg;base64,${item.key.base64Image}" />

                            </td>

                            <td>
                                <span id="bookTitle">${item.key.title}</span>
                            </td>
                            

                            <td>
                                <input type="text" name="quantity${status.index + 1}" value="${item.value}" size="5" readonly="readonly" /> 
                            </td>
                            <td><fmt:formatNumber value="${item.key.price}" type="currency" /></td>
                            <td><fmt:formatNumber value="${item.value * item.key.price}" type="currency" /></td>
                            
                        </tr>
                    </c:forEach>

                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b>${cart.totalQuantity} product(s)</b></td>
                            <td>Total:</td>
                            <td colspan="7">
                                <p>Number of copies: ${cart.totalQuantity}</p>
                                <p>Subtotal: <fmt:formatNumber value="${cart.totalAmount}" type="currency" /></p>
                                <p>Shipping Fee: <fmt:formatNumber value="${tax}" type="currency" /></p>
                                <p>Tax: <fmt:formatNumber value="${shippingFee}" type="currency" /></p>
                                <p>TOTAL: <fmt:formatNumber value="${total}" type="currency" /></p>
                            </td>
                        </tr>

                </table>
                        
                        <h2>Recipient Information</h2>
                        
                        <form id="orderForm" action="placeOrder" method="POST">
                            
                            <table>
                                
                                <tr>
                                    <td>Recipient First Name:</td>
                                    <td><input type="text" name="recipientFirstname" value="${loggedCustomer.firstname}" /></td>
                                </tr>
                                
                                <tr>
                                    <td>Recipient Last Name:</td>
                                    <td><input type="text" name="recipientLastname" value="${loggedCustomer.lastname}" /></td>
                                </tr>
                                
                                <tr>
                                    <td>Recipient Phone:</td>
                                    <td><input type="text" name="recipientPhone" value="${loggedCustomer.phoneNumber}" /></td>
                                </tr>
                                
                                <tr>
                                    <td>Address Line 1:</td>
                                    <td><input type="text" name="address1" value="${loggedCustomer.addressLine1}" /></td>
                                </tr>
                                
                                <tr>
                                    <td>Address Line 2:</td>
                                    <td><input type="text" name="address2" value="${loggedCustomer.addressLine2}" /></td>
                                </tr>
                                
                                <tr>
                                    <td>City:</td>
                                    <td><input type="text" name="city" value="${loggedCustomer.city}" /></td>
                                </tr>
                                
                                <tr>
                                    <td>State:</td>
                                    <td><input type="text" name="state" value="${loggedCustomer.state}" /></td>
                                </tr>`
                                
                                <tr>
                                    <td>Zip Code:</td>
                                    <td><input type="text" name="zipcode" value="${loggedCustomer.zipCode}" /></td>
                                </tr>
                                
                                <tr>
                            <td align="left">Country</td>
                            <td align="right">
                                <select name="country" id="country">
                                    <c:forEach var="country" items="${mapCountries}">
                                        <option value="${country.value}" <c:if test='${loggedCustomer.country eq country.value}'>selected="selected"</c:if>>${country.key}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                                
                            </table>
                                
                                <div>
                                    <h2>Payment Method</h2>
                                    &nbsp;&nbsp;&nbsp;
                                    Choose your payment method:
                                    <select name="paymentMethod">
                                        <option value="Cash on Delivery">Cash on Delivery</option>
                                        <option value="paypal">PayPal or Credit Card</option>
                                    </select>
                                </div>
                                
                                <div>
                                    <table>
                                        
                                        <tr><td>&nbsp;</td></tr>

                                        <tr>
                                            <td><button type="submit">Place Order</button></td>
                                            <td><a href="${pageContext.request.contextPath}/">Continue Shopping</a></td>
                                        </tr>
                                    </table>
                                </div>
                
                                
                        </form>
                </div>

                
            </c:if>
            
        </div>
    </body>
    
    <script type="text/javascript">
            
        $(document).ready(function() {
            $("#orderForm").validate({

                rules: {
                    recipientFirstname: "required",
                    recipientLastname: "required",
                    recipientPhone: "required",
                    address1: "required",
                    address2: "required",
                    city: "required",
                    state: "required",
                    zipcode: "required",
                    country: "required"
                },

                messages: {
                    recipientFirstname: "Please enter recipient first name",
                    recipientLastname: "Please enter recipient lastname name",
                    recipientPhone: "Please enter recipient phone",
                    address1: "Please enter recipient address",
                    address2: "Please enter recipient second address",
                    city: "Please enter recipient city",
                    state: "Please enter recipient state",
                    zipcode: "Please enter recipient zipcode",
                    country: "Please enter recipient country"
                }
            });

        });

    </script>
</html>
