
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Review Management</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
    </head>
    <body>
        <jsp:directive.include file="../admin/header.jsp" />
        
        <div class="w3-container w3-center w3-display-topmiddle" style="top: 30px;">
            <h2 class="w3-green">Review Management</h2>
        </div><hr />
        
        <c:if test="${message != null}">
            <div class="w3-container w3-center w3-display-topmiddle w3-panel w3-green" style="top: 130px;">
                <h3>Success!</h3>
                <p>${message}</p>
            </div>
        </c:if>
        
        <div class="w3-container w3-display-middle" style="top: 500px;">
            <table class="w3-table w3-striped w3-border w3-card-4 w3-centered ">
                <tr>
                    <th>Index</th>
                    <th>Review ID</th>
                    <th>Product</th>
                    <th>Rating</th>
                    <th>Headline</th>
                    <th>Customer</th>
                    <th>Review On</th>
                    <th>Actions</th>
                </tr>

                <c:forEach var="review" items="${reviews}">

                    <c:url var="updateReview" value="/admin/editReview">
                        <c:param name="reviewID" value="${review.reviewID}" />
                    </c:url>

                    <c:url var="deleteReview" value="/admin/deleteReview">
                        <c:param name="reviewID" value="${review.reviewID}" />
                    </c:url>

                <tr>
                    <td>${review.reviewID}</td>
                    <td>${review.product.title}</td>
                    <td>${review.rating}</td>
                    <td>${review.headline}</td>
                    <td>${review.customer.fullname}</td>
                    <td>${review.reviewTime}</td>
                    
                    <td>
                        <a class="w3-button w3-green w3-round" href="${updateReview}">Edit</a>&nbsp;
                        <a class="w3-button w3-red w3-round" href="${deleteReview}" onclick="if(!(confirm(Are you sure you want to delete this product?)))">
                            Delete
                        </a>&nbsp;
                    </td>
                </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>
