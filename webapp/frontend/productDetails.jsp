
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${product.title}</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body>
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div class="w3-container w3-bar">
            
            <table>
                
                <tr>
                    <td colspan="3" align="left">
                        <h2>${product.title}</h2>
                        <h4>Product ID: ${product.productID}</h4>
                        <img class="w3-padding-16" src="data:image/jpg;base64,${product.base64Image}" width="550" height="500" alt="slika">
                    </td>
                    
                    <td colspan="3">
                        <c:forTokens var="star" items="${product.ratingStars}" delims=",">
                            <c:if test="${star eq 'on'}">
                                <img src="ratingStars/icons8-star-24.png" alt="starOn" />
                            </c:if>

                            <c:if test="${star eq 'off'}">
                                <img src="ratingStars/icons8-star-24 (2).png" alt="starOff" />
                            </c:if>

                            <c:if test="${star eq 'half'}">
                                <img src="ratingStars/icons8-star-24 (1).png" alt="starHalf" />
                            </c:if>
                        </c:forTokens>
                        <h3>$${product.price}</h3>
                        <button id="addToCart" class="w3-button w3-teal" style="width: 80%;"><i class="fa fa-shopping-cart w3-margin-right"></i>Add to cart</button>
                        <h3>Product Description</h3>
                        <p>${product.description}</p>
                    </td>
                </tr>
                
            </table>
        </div>
        
        <div class="w3-container w3-teal w3-padding-16">
            <h2>Customer Reviews</h2>
            <button id="writeReviewBtn" class="w3-blue" type="submit">Write review</button>
            
            <table>
                <c:forEach items="${product.reviews}" var="review">
                    <tr>
                        <td>
                            <c:forTokens var="star" items="${review.stars}" delims=",">
                                <c:if test="${star eq 'on'}">
                                    <img src="ratingStars/icons8-star-24.png" alt="starOn" />
                                </c:if>

                                <c:if test="${star eq 'off'}">
                                    <img src="ratingStars/icons8-star-24 (2).png" alt="starOff" />
                                </c:if>
                            </c:forTokens>
                            - <b>${review.headline}</b>
                        </td>
                    </tr>

                    <tr>
                        <td>by ${review.customer.fullname} on ${review.reviewTime}</td>
                    </tr>

                    <tr>
                        <td><i>${review.comment}</i></td>
                    </tr>

                    <tr><td>&nbsp;</td></tr>

                </c:forEach>
            </table>
        </div>
            
            
    </body>
    
    <script type="text/javascript">
            
        $(document).ready(function() {
            $("#writeReviewBtn").click(function() {
                window.location = 'writeReview?id=' + ${product.productID};
            });
            
            $("#addToCart").click(function() {
                window.location = 'addToCart?id=' + ${product.productID};
            });
        });
    </script>
</html>
