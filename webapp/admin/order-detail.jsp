\
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Detail</title>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body>
        
        <jsp:directive.include file="../admin/header.jsp" />
        
        <div align="center">
            <h2 class="pageHeading">Details of order: ${order.orderID} </h2>
        </div><br />
        
        <c:if test="${message != null}">
            <div align="center">
                <h4 class="message">${message}</h4>
            </div>
        </c:if>
        
        <div align="center">
            <h2>Order Review</h2>
            
            <table>
                <tr>
                    <td>Order by</td>
                    <td>${order.customer.fullname}</td>
                </tr>
                
                <tr>
                    <td>Order Status</td>
                    <td>${order.status}</td>
                </tr>
                
                <tr>
                    <td>Order Date</td>
                    <td>${order.orderDate}</td>
                </tr>
                
                <tr>
                    <td>Number of copies:</td>
                    <td>${order.productCopies}</td>
                </tr>
                
                <tr>
                    <td>Payment Method</td>
                    <td>${order.paymentMethod}</td>
                </tr>
                
                <tr>
                    <td>Total Amount</td>
                    <td><fmt:formatNumber value="${order.total}" type="currency" /></td>
                </tr>
                
            </table>
                
                <h2>Recipient Information</h2>
                
                <table>
                    <tr>
                        <td>Recipient First Name</td>
                        <td>${order.recipientFirstname}</td>
                    </tr>

                    <tr>
                        <td>Recipient Last Name</td>
                        <td>${order.recipientLastname}</td>
                    </tr>

                    <tr>
                        <td>Recipient Phone</td>
                        <td>${order.recipientPhone}</td>
                    </tr>

                    <tr>
                        <td>Recipient Address 1</td>
                        <td>${order.recipientAddress}</td>
                    </tr>

                    <tr>
                        <td>Recipient Address 2</td>
                        <td>${order.recipientAddress2}</td>
                    </tr>
                    
                    <tr>
                        <td>City</td>
                        <td>${order.recipientCity}</td>
                    </tr>
                    
                    <tr>
                        <td>Country</td>
                        <td>${order.recipientCountry}</td>
                    </tr>
                    
                    <tr>
                        <td>State</td>
                        <td>${order.recipientState}</td>
                    </tr>
                    
                    <tr>
                        <td>Zip Code</td>
                        <td>${order.recipientZipcode}</td>
                    </tr>
                </table>
            
        </div>
                
                <div align="center">
                    
                    <h2 class="pageHeading">Ordered products </h2>
                    
                    <table border="1">
                        
                        <tr>
                            <th>Index</th>
                            <th>Product Title</th>
                            <th>Price</th>
                            <th>Subtotal</th>
                            <th>Quantity</th>
                        </tr>
                        
                        <c:forEach var="details" items="${order.productDetails}" varStatus="status">
                            
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <img style="vertical-align: middle;" src="data:image/jpg;base64,${details.product.base64Image}" alt="slika" width="48" height="64"/>
                                    ${details.product.title}
                                </td>
                                <td><fmt:formatNumber value="${details.product.price}" type="currency" /></td>
                                
                                <td><fmt:formatNumber value="${details.subtotal}" type="currency" /></td>
                                <td>${details.quantity}</td>
                            </tr>
                        </c:forEach>
                            
                            <tr>
                                <td colspan="6" align="right">
                                    <b>Subtotal: <fmt:formatNumber value="${order.subtotal}" type="currency" /></b><br />
                                    <b>Tax: <fmt:formatNumber value="${order.tax}" type="currency" /></b><br />
                                    <b>Shipping Fee:<fmt:formatNumber value="${order.shippingFee}" type="currency" /></b><br />
                                    <b>TOTAL:<fmt:formatNumber value="${order.total}" type="currency" /></b>
                                </td>
                            </tr>
                    </table>
                    
                </div>
                            
                <div align="center">
                    <br />

                    <a href="editOrder?orderID=${order.orderID}">Edit this order</a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="url">Delete this order</a>
                </div>
    </body>
</html>
