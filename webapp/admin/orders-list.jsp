
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Order Management</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
    </head>
    <body>
        <jsp:directive.include file="../admin/header.jsp" />
        
        <div class="w3-container w3-center w3-display-topmiddle" style="top: 30px;">
            <h2 class="w3-green">Order Management</h2>
        </div><hr />
        
        <c:if test="${message != null}">
            <div class="w3-container w3-center w3-display-topmiddle w3-panel w3-green" style="top: 130px;">
                <h3>Success!</h3>
                <p>${message}</p>
            </div>
        </c:if>
        
        <div class="w3-container w3-display-middle" style="top: 500px; right: 50px;">
            <table class="w3-table w3-striped w3-border w3-card-4 w3-centered ">
                <tr class="w3-grey">
                    <th>Index</th>
                    <th>Order ID</th>
                    <th>Order By</th>
                    <th>Product copies</th>
                    <th>Total</th>
                    <th>Payment method</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Actions</th>
                </tr>

                <c:forEach var="order" items="${orders}">

                    <c:url var="updateOrder" value="/admin/editOrder">
                        <c:param name="orderID" value="${order.orderID}" />
                    </c:url>

                    <c:url var="deleteOrder" value="/admin/deleteOrder">
                        <c:param name="orderID" value="${order.orderID}" />
                    </c:url>
                    
                    <c:url var="orderInfo" value="/admin/viewOrderDetail">
                        <c:param name="orderID" value="${order.orderID}" />
                    </c:url>

                    <tr>
                    <td>${status.index + 1}</td>
                    <td>${order.orderID}</td>
                    <td>${order.customer.fullname}</td>
                    <td>${order.productCopies}</td>
                    <td><fmt:formatNumber value="${order.total}" type="currency" /></td>
                    <td>${order.paymentMethod}</td>
                    <td>${order.status}</td>
                    <td>${order.orderDate}</td>
                    
                    <td>
                            <a class="w3-button w3-green w3-round" href="${updateOrder}">Edit</a>&nbsp;
                            <a class="w3-button w3-blue w3-round" href="${orderInfo}">Details</a>&nbsp;
                            <a class="w3-button w3-red w3-round" href="${deleteOrder}" onclick="if(!(confirm(Are you sure you want to delete this order?)))">
                                Delete
                            </a>&nbsp;
                        </td>
                </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>
