
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
        
        <div align="center">
            <h2 class="pageHeading">My Order History</h2>
        </div><br />
        
        <c:if test="${fn:length(listOrders) == 0}">
            <h3>You have not placed any orders</h3>
        </c:if>
        
        <c:if test="${fn:length(listOrders) > 0}">
            <div align="center">
            <table border="1" cellpadding="5">
                <tr>
                    <th>Index</th>
                    <th>Order ID</th>
                    <th>Quantity</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Actions</th>
                </tr>
                
            <c:forEach var="detail" items="${listOrders}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${detail.orderID}</td>
                    <td>${detail.productCopies}</td>
                    <td><fmt:formatNumber value="${detail.total}" type="currency" /></td>
                    <td>${detail.status}</td>
                    <td>${detail.orderDate}</td>
                    
                    <td>
                        <a href="viewOrderDetail?id=${detail.orderID}">Details</a>
                    </td>
                </tr>
            </c:forEach>
            </table>
        </div>
        </c:if>
    </body>
</html>
