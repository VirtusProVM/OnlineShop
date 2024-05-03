
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Computer Store</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        
        <style>
        .w3-sidebar a {font-family: "Roboto", sans-serif}
        body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
        </style>
    </head>
    <body>
        <jsp:directive.include file="frontend/topnav.jsp" />
        <jsp:directive.include file="frontend/navbar.jsp" />
                
        <div class="w3-row-padding w3-grayscale">
            
            <c:forEach var="product" items="${products}">
                <div class="w3-col l3 m6 w3-margin-bottom w3-border-left">
                    
                    <img src="data:image/jpg;base64,${product.base64Image}" width="128" height="164" alt="slika" />
                    <h3>${product.title}</h3>
                    <h4 class="w3-opacity">Price: $${product.price}</h4>
                    
                    <div class="w3-container">
                        
                        <a href="viewProduct?productID=${product.productID}" class="w3-button w3-light-grey" style="width: 100%;">More</a>
                    </div>
                </div>
            </c:forEach>
            
        </div>
    </body>
</html>
