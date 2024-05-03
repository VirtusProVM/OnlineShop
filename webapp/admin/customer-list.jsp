
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Management</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="../css/product.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body>
        <div class="parent-container">
            
            <div class="child-container">
                <jsp:directive.include file="../admin/header.jsp" />
            </div>
            
            <div class="child2-container">
                <div class="w3-container w3-center w3-display-topmiddle" style="top: 30px; z-index: 1;">
                    <h2 class="w3-green">Customer Management</h2>
                    <a class="w3-button w3-teal w3-round w3-center" href="${pageContext.request.contextPath}/admin/addCustomer">Add New Customer</a>
                </div><hr />

                <c:if test="${message != null}">
                    <div class="w3-container w3-center w3-display-topmiddle w3-panel w3-green" style="top: 130px; z-index: 2;">
                        <h3>Success!</h3>
                        <p>${message}</p>
                    </div>
                </c:if>

                <div class="w3-container w3-display-middle" style="top: 700px; right: 50px; z-index: 3;">
                    <table class="w3-table w3-striped w3-border w3-card-4 w3-centered ">
                        <tr class="w3-grey">
                            <th>Customer ID</th>
                            <th>First Name</th>
                            <th>Las Name</th>
                            <th>Email</th>
                            <th>Address Line 1</th>
                            <th>Phone Number</th>
                            <th>City</th>
                            <th>Country</th>
                            <th>Register Date</th>
                            <th>Actions</th>
                        </tr>

                        <c:forEach var="customer" items="${customers}">

                            <c:url var="updateCustomer" value="/admin/editCustomer">
                                <c:param name="customerID" value="${customer.customerID}" />
                            </c:url>

                            <c:url var="deleteCustomer" value="/admin/deleteCustomer">
                                <c:param name="customerID" value="${customer.customerID}" />
                            </c:url>

                            <tr>
                                <td>${customer.customerID}</td>
                                <td>${customer.firstname}</td>
                                <td>${customer.lastname}</td>
                                <td>${customer.email}</td>
                                <td>${customer.addressLine1}</td>
                                <td>${customer.phoneNumber}</td>
                                <td>${customer.city}</td>
                                <td>${customer.country}</td>
                                <td>${customer.registerDate}</td>
                                <td>
                                    <a class="w3-button w3-green w3-round" href="${updateCustomer}">Edit</a>&nbsp;
                                    <a class="w3-button w3-red w3-round" href="${deleteCustomer}" onclick="if(!(confirm(Are you sure you want to delete this customer?)))">
                                        Delete
                                    </a>&nbsp;
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
        
        
        
    </body>
</html>
