
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Review Payment</title>
    </head>
    <body>
        
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            <h3>Review Your Payment</h3>
            <h2>Payer Information</h2>
            
            <table>
                <tr>
                    <td><b>First Name</b></td>
                    <td>${payer.firstName}</td>
                </tr>
                
                <tr>
                    <td><b>Last Name</b></td>
                    <td>${payer.lastName}</td>
                </tr>
                
                <tr>
                    <td><b>Email</b></td>
                    <td>${payer.email}</td>
                </tr>
            </table>
                
            <h2>Recipient Information</h2>
            
            <table>
                <tr>
                    <td><b>Recipient Name</b></td>
                    <td>${address.recipientName}</td>
                </tr>

                <tr>
                    <td><b>Address Line 1</b></td>
                    <td>${address.line1}</td>
                </tr>

                <tr>
                    <td><b>Address Line 2</b></td>
                    <td>${address.line2}</td>
                </tr>
                
                <tr>
                    <td><b>City</b></td>
                    <td>${address.city}</td>
                </tr>
                
                <tr>
                    <td><b>State</b></td>
                    <td>${address.state}</td>
                </tr>
                
                <tr>
                    <td><b>Country Code</b></td>
                    <td>${address.countryCode}</td>
                </tr>
                
                <tr>
                    <td><b>Postal Code</b></td>
                    <td>${address.postalCode}</td>
                </tr>
            </table>
                
            <h2>Transaction Details</h2>

            <table>
                
                <tr>
                    <td><b>Transaction Description</b></td>
                    <td>${transaction.description}</td>
                </tr>
                
                <tr>
                    <td><b>Item List</b></td>
                </tr>
                
                <tr>
                    <td colspan="2">
                        <table>
                            <tr>
                                <th>No</th>
                                <th>Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Subtotal</th>
                            </tr>

                            <c:forEach var="item" items="${transaction.itemList.items}" varStatus="var">
                                <tr>
                                    <td>${var.index + 1}</td>
                                    <td>${item.name}</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.price}" type="currency" /> </td>
                                    <td><fmt:formatNumber value="${item.subtotal}" type="currency" /></td>
                                </tr>
                            </c:forEach>

                            <tr>
                                <td colspan="5" align="right">
                                    <p>Subtotal: <fmt:formatNumber value="${transaction.amount.details.subtotal}" type="currency" /></p>
                                    <p>Tax: <fmt:formatNumber value="${transaction.amount.details.tax}" type="currency" /></p>
                                    <p>Shipping Fee: <fmt:formatNumber value="${transaction.amount.details.shipping}" type="currency" /></p>
                                    <p>Total: <fmt:formatNumber value="${transaction.amount.total}" type="currency" /></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
                                
            <div>
                <form action="executePayment" method="POST">
                    <input type="submit" value="Pay Now" />
                </form>
            </div>
        </div>
    </body>
</html>
