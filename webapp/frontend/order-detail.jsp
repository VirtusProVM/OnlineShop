
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Orders</title>
    </head>
    <body>
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
         <c:if test="${order == null}">
            <h2 class="pageHeading">Sorry, you are not authorized to view this order</h2>
        </c:if>
            
            
        <c:if test="${order != null}">
            <div align="center">
                <h2 class="pageHeading">Your Order ID: ${order.orderId}</h2>
            </div><br />
        
            <div align="center">

                <table>
                    <h2>Order Review</h2>

                    <tr>
                        <td>Order Status: </td>
                        <td>${order.status}</td>
                    </tr>

                    <tr>
                        <td>Order Date: </td>
                        <td>${order.orderDate}</td>
                    </tr>

                    <tr>
                        <td>Number of copies: </td>
                        <td>${order.productCopies}</td>
                    </tr>

                    <tr>
                        <td>Total Amount: </td>
                        <td><fmt:formatNumber value="${detail.total}" type="currency" /></td>
                    </tr>

                    <tr>
                        <td>Payment Method: </td>
                        <td>${order.paymentMethod}</td>
                    </tr>

                </table>

                    <table>

                        <h2>Recipient Information</h2>

                        <tr>
                            <td>Recipient First Name: </td>
                            <td>${order.recipientFirstname}</td>
                        </tr>

                        <tr>
                            <td>Recipient Last Name: </td>
                            <td>${order.recipientLastname}</td>
                        </tr>

                        <tr>
                            <td>Recipient Phone: </td>
                            <td>${order.recipientPhone}</td>
                        </tr>

                        <tr>
                            <td>Recipient Address 1: </td>
                            <td>${order.recipientAddress}</td>
                        </tr>

                        <tr>
                            <td>Recipient Address 2: </td>
                            <td>${order.recipientAddress2}</td>
                        </tr>

                        <tr>
                            <td>City: </td>
                            <td>${order.recipientCity}</td>
                        </tr>

                        <tr>
                            <td>Country: </td>
                            <td>${order.recipientCountry}</td>
                        </tr>

                        <tr>
                            <td>State: </td>
                            <td>${order.recipientState}</td>
                        </tr>

                        <tr>
                            <td>Zip Code: </td>
                            <td>${order.recipientZipcode}</td>
                        </tr>
                    </table>

            </div>
                
                <div align="center">
                    
                    <h2 class="pageHeading">Ordered books </h2>
                    
                    <table border="1">
                        
                        <tr>
                            <th>Index</th>
                            <th>Product Title</th>
                            <th>Author</th>
                            <th>Price</th>
                            <th>Subtotal</th>
                            <th>Quantity</th>
                        </tr>
                        
                        <c:forEach var="details" items="${order.orderDetails}" varStatus="status">
                            
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <img style="vertical-align: middle;" src="data:image/jpg;base64,${details.product.base64Image}" alt="slika" width="48" height="64"/>
                                    ${details.book.title}
                                </td>
                                <td>${details.product.title}</td>
                                <td><fmt:formatNumber value="${details.product.price}" type="currency" /></td>
                                <td>${details.quantity}</td>
                                <td><fmt:formatNumber value="${details.subtotal}" type="currency" /></td>
                            </tr>
                        </c:forEach>
                            
                            <tr>
                                <td colspan="4" align="right"><b>Total</b></td>
                                <td><b>${order.productCopies}</b></td>
                                <td><b>${order.total}</b></td>
                            </tr>
                    </table>
                    
                </div>
        </c:if>
    </body>
</html>
