
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Results for ${keyword}</title>
    </head>
    <body>
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            <c:if test="${fun:length(result) == 0}">
                <h2>No result for "${keyword}"</h2>
            </c:if>
                
            <c:if test="${fun:length(result) > 0}">
                <div align="left" style="width: 80%; margin: 0 auto">
                    <center><h2>Result for "${keyword}"</h2></center>
                <c:forEach items="${result}" var="product">
                    <div>
                    
                    <div style="display: inline-block; margin: 20px; width: 10%" align="left">
                        <div>
                            <a href="viewProduct?productID=${product.productID}">
                                <img src="data:image/jpg;base64,${product.base64Image}" width="128" height="164" alt="slika" />
                            </a>
                            
                        </div>
                    </div>
                    
                        <div style="display: inline-block; margin: 20px; vertical-align: top; width: 70%">
                            <div>
                                <h2><a href="viewProduct?productID=${product.productID}">
                                    <b>${product.title}</b>
                                    </a></h2>
                            </div>

                            <div>
                                <p>${fun:substring(product.description, 0, 100)}...</p>
                            </div>
                            
                            <div style="display: inline-block; margin: 20px;">
                                <h3>$${product.price}</h3>
                                <h3><a href="addToCart" class="w3-teal w3-button"><i class="fa fa-shopping-cart w3-margin-right"></i>Add to cart</a></h3>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            </c:if>
        </div>
    </body>
</html>
