
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category - ${category.name}</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
    </head>
    <body>
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div class="w3-container">
            <h2 class="w3-teal">Category: ${category.name}</h2>
        </div>
        
        <div class="w3-row-padding w3-grayscale">
            
            <c:forEach var="product" items="${products}">
                <div class="w3-col l3 m6 w3-margin-bottom w3-border-left">
                    
                    <img src="data:image/jpg;base64,${product.base64Image}" width="128" height="164" alt="slika" />
                    <h3>${product.title}</h3>
                    <h4 class="w3-opacity">Price: $${product.price}</h4>
                    
                    <div class="w3-container">
                        <a class="w3-button w3-light-grey w3-left"><i class="fa fa-shopping-cart w3-margin-right"></i>Add to cart</a>
                        <a href="viewProduct?productID=${product.productID}" class="w3-button w3-light-grey w3-right">More</a>
                    </div>
                </div>
            </c:forEach>
            
        </div>
    </body>
    
</html>
