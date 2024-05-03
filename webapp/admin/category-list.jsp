
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Category Management</title>
    </head>
    <body>
        <jsp:directive.include file="../admin/header.jsp" />
        
        <div class="w3-container w3-center w3-display-topmiddle" style="top: 30px;">
            <h2 class="w3-green">Category Management</h2>
            <a class="w3-button w3-teal w3-round w3-center" href="../admin/add-category.jsp">Add New Category</a>
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
                    <th>Category ID</th>
                    <th>Category name</th>
                    <th>Actions</th>
                </tr>

                <c:forEach var="cat" items="${categories}" varStatus="status">

                    <c:url var="updateCategory" value="/admin/editCategory">
                        <c:param name="categoryID" value="${cat.categoryID}" />
                    </c:url>

                    <c:url var="deleteCategory" value="/admin/deleteCategory">
                        <c:param name="categoryID" value="${cat.categoryID}" />
                    </c:url>

                    <tr>
                        <td>${cat.categoryID}</td>
                        <td>${cat.name}</td>
                        <td>
                            <a class="w3-button w3-green w3-round" href="${updateCategory}">Edit</a>&nbsp;
                            <a class="w3-button w3-red w3-round" href="${deleteCategory}" onclick="if(!(confirm(Are you sure you want to delete this category?)))">
                                Delete
                            </a>&nbsp;
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        
    </body>
</html>
