
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Product Management</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="../css/product.css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body>
        <div class="parent-container">
            
            <div class="child-container">
                <jsp:directive.include file="../admin/header.jsp" />
            </div>
            
            <div class="child2-container">
                <div class="w3-container w3-center w3-display-topmiddle" style="top: 30px; z-index: 1; position: relative;">
                    <h2 class="w3-green">Product Management</h2>
                    <a class="w3-button w3-teal w3-round w3-center" href="${pageContext.request.contextPath}/admin/newProduct">Add New Product</a>
                </div><hr />


                <c:if test="${message != null}">
                    <div class="w3-container w3-center w3-display-topmiddle w3-panel w3-green" style="top: 130px; z-index: 2; position: relative;">
                        <h3>Success!</h3>
                        <p>${message}</p>
                    </div>
                </c:if>

                <div class="w3-container w3-display-middle" style="top: 700px; z-index: 3; position: relative;">
                    <table class="w3-table w3-striped w3-border w3-card-4 w3-centered ">
                        <tr class="w3-grey">
                            <th>Product ID</th>
                            <th>Category</th>
                            <th>Product Name</th>
                            <th>Product Image</th>
                            <th>Price</th>
                            <th>Publish Date</th>
                            <th>Last Update Date</th>
                            <th>Actions</th>
                        </tr>

                        <c:forEach var="product" items="${products}" varStatus="status">

                            <c:url var="updateProduct" value="/admin/editProduct">
                                <c:param name="productID" value="${product.productID}" />
                            </c:url>

                            <c:url var="deleteProduct" value="/admin/deleteProduct">
                                <c:param name="productID" value="${product.productID}" />
                            </c:url>

                            <tr>
                                <td>${product.productID}</td>
                                <td>${product.category.name}</td>
                                <td>${product.title}</td>
                                <td><img src="data:image/jpg;base64,${product.base64Image}" style="width: 20%; margin-top: 10px;" alt="slika" /></td>
                                <td>$${product.price}</td>
                                <td><fmt:formatDate pattern="MM/dd/yyyy" value="${product.publishDate}" /></td>
                                <td>${product.updateProductDate}</td>
                                <td>
                                    <a class="w3-button w3-green w3-round" href="${updateProduct}">Edit</a>&nbsp;
                                    <a class="w3-button w3-red w3-round" href="${deleteProduct}" onclick="if(!(confirm(Are you sure you want to delete this product?)))">
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
