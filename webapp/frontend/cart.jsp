
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
    </head>
    <body>
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            <h2>Your Cart Details</h2>
            
            <c:if test="${message != null}">
                <div align="center">
                    <h4 class="message">${message}</h4>
                </div>
            </c:if>
            
            <c:set var="cart" value="${sessionScope['cart']}" />
            
            <c:if test="${cart.totalItems == 0}">
                <h2>There's no items in cart</h2>
            </c:if>
                
            <c:if test="${cart.totalItems > 0}">
                
                <form action="updateCart" method="POST" id="cartForm">
                    <div>
                    <table border="1">
                        <tr>
                            <th>No</th>
                            <th colspan="2">Product</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Subtotal</th>
                            <th></th>
                        </tr>

                        <c:forEach items="${cart.items}" var="item" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <img style="height: 100px; width: 100px;" src="data:image/jpg;base64,${item.key.base64Image}" />
                                </td>

                                <td>
                                    <span id="productTitle">${item.key.title}</span>
                                </td>

                                <td>
                                    <input type="hidden" name="productID" value="${item.key.productID}" />
                                    <input type="text" name="quantity${status.index + 1}" value="${item.value}" size="5" /> 
                                </td>
                                <td><fmt:formatNumber value="${item.key.price}" type="currency" /></td>
                                <td><fmt:formatNumber value="${item.value * item.key.price}" type="currency" /></td>
                                <td>
                                    <a href="removeProduct?productID=${item.key.productID}">Remove</a>
                                </td>

                            </tr>
                        </c:forEach>

                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><b>${cart.totalQuantity} product(s)</b></td>
                                <td>Total:</td>
                                <td colspan="2"><b><fmt:formatNumber value="${cart.totalAmount}" type="currency" /></b></td>
                            </tr>

                    </table>
                    </div>
                            
                    <div>
                        <table class="normal">

                            <tr>
                                <td></td>
                                <td><button type="submit">Update</button></td>
                                <td><input id="clearCart" type="button" value="Clear cart" /></td>
                                <td><a href="${pageContext.request.contextPath}/">Continue Shopping</a></td>
                                <td><a href="checkoutOrder">Checkout</a></td>
                            </tr>
                        </table>
                    </div>
                </form>
                
            </c:if>
            
        </div>
    </body>
    
    <script type="text/javascript">
    
        $(document).ready(function() {

            $("#clearCart").click(function() {
                window.location = 'clearCart';
            });

            $("#cartForm").validate({
                rules: {
                <c:forEach items="${cart.items}" var="item" varStatus="status">
                    quantity${status.index + 1} : {required: true, number: true, min: 1}
                </c:forEach>
                },

                messages: {
                <c:forEach items="${cart.items}" var="item" varStatus="status">
                    quantity${status.index + 1} : {required: "Enter quantity", 
                        number: "Quantity must be number", 
                        min: "Quantity must be greater than 0"}
                </c:forEach>
                }

            });
        });

    </script>
</html>
