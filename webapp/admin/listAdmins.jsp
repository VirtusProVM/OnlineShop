
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin List</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    </head>
    <body>
        
        <jsp:directive.include file="../admin/header.jsp" />
        
        <div class="w3-container w3-center w3-display-topmiddle" style="top: 30px;">
            <h2 class="w3-green">Admin Management</h2>
            <a class="w3-button w3-teal w3-round w3-center" href="../admin/add-admin.jsp">Add New Admin</a>
        </div><hr />
        
        <c:if test="${message != null}">
            <div class="w3-container w3-center w3-display-topmiddle w3-panel w3-green" style="top: 130px;">
                <h3>Success!</h3>
                <p>${message}</p>
            </div>
        </c:if>
            
        <div class="w3-container w3-display-middle" style="top: 500px;">
            <table class="w3-table w3-striped w3-border w3-card-4 w3-centered ">
                <tr class="w3-red">
                        <th>Admin ID</th>
                        <th>Full name</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>

                    <c:forEach var="admin" items="${admins}" varStatus="status">

                        <c:url var="updateAdmin" value="/admin/editAdmin">
                            <c:param name="adminID" value="${admin.adminID}" />
                        </c:url>

                        <c:url var="deleteAdmin" value="/admin/deleteAdmin">
                            <c:param name="adminID" value="${admin.adminID}" />
                        </c:url>

                        <tr>
                            <td>${admin.adminID}</td>
                            <td>${admin.fullname}</td>
                            <td>${admin.email}</td>
                            <td>
                                <a class="w3-button w3-green w3-round" href="${updateAdmin}">Edit</a>&nbsp;
                                <a class="w3-button w3-red w3-round" href="${deleteAdmin}" onclick="if(!(confirm(Are you sure you want to delete this user?)))">
                                    Delete
                                </a>&nbsp;
                            </td>
                        </tr>
                    </c:forEach>
                </table>
        </div>
    </body>
</html>
