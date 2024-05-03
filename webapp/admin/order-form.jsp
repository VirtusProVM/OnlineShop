
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Form</title>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
    </head>
    <body>
        
        <jsp:directive.include file="../admin/header.jsp" />
        
        <div align="center">
            <h2 class="pageHeading">Edit order ID: ${order.orderID} </h2>
        </div><br />
        
        <c:if test="${message != null}">
            <div align="center">
                <h4 class="message">${message}</h4>
            </div>
        </c:if>
        
        <form action="updateOrder" method="POST" id="orderForm">
        <div align="center">
            
            <h2>Order Overview</h2>
            <table>
                <tr>
                    <td>Order by</td>
                    <td>${order.customer.fullname}</td>
                </tr>
                
                <tr>
                    <td>Order Status</td>
                    <td>${order.status}</td>
                </tr>
                
                <tr>
                    <td>Order Date</td>
                    <td>${order.orderDate}</td>
                </tr>
                
                <tr>
                    <td>Payment Method</td>
                    <td>
                        <select name="paymentMethod">
                            <option value="Cash on Delivery" <c:if test="${order.paymentMethod eq 'Cash On Delivery'}">selected='selected'</c:if>>Cash on Delivery</option>
                            <option value="paypal" <c:if test="${order.paymentMethod eq 'paypal'}">selected='selected'</c:if>>PayPal or Credit Card</option>
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Order Status</td>
                    <td>
                        <select name="orderStatus">
                            <option value="Processing" <c:if test="${order.status eq 'Processing'}"> selected='selected'</c:if>>Processing</option>
                            <option value="Shipping" <c:if test="${order.status eq 'Shipping'}"> selected='selected'</c:if>>Shipping</option>
                            <option value="Delivered" <c:if test="${order.status eq 'Delivered'}"> selected='selected'</c:if>>Delivered</option>
                            <option value="Completed" <c:if test="${order.status eq 'Completed'}"> selected='selected'</c:if>>Completed</option>
                            <option value="Canceled" <c:if test="${order.status eq 'Canceled'}"> selected='selected'</c:if>>Cancelled</option>
                            
                        </select>
                    </td>
                </tr>
                
            </table>
                            
            <h2>Recipient Information</h2>
            
            <table>
                
                <tr>
                    <td>Recipient First Name</td>
                    <td>
                        <input type="text" name="recipientFirstName" value="${order.recipientFirstname}" size="45" />
                    </td>
                </tr>
                
                <tr>
                    <td>Recipient Last Name</td>
                    <td>
                        <input type="text" name="recipientLastName" value="${order.recipientLastname}" size="45" />
                    </td>
                </tr>
                
                <tr>
                    <td>Recipient Phone</td>
                    <td>
                        <input type="text" name="recipientPhone" value="${order.recipientPhone}" size="45" />
                    </td>
                </tr>
                
                <tr>
                    <td>Recipient Address 1</td>
                    <td>
                        <input type="text" name="recipientAddress" value="${order.recipientAddress}" size="45" />
                    </td>
                </tr>
                
                <tr>
                    <td>Recipient Address 2</td>
                    <td>
                        <input type="text" name="recipientAddress2" value="${order.recipientAddress2}" size="45" />
                    </td>
                </tr>
                
                <tr>
                    <td>City</td>
                    <td>
                        <input type="text" name="recipientCity" value="${order.recipientCity}" size="45" />
                    </td>
                </tr>

                <tr>
                    <td>State</td>
                    <td><input type="text" name="recipientState" value="${order.recipientState}" size="45" /></td>
                </tr>

                <tr>
                    <td>Zip Code</td>
                    <td><input type="text" name="recipientZipcode" value="${order.recipientZipcode}" size="45" /></td>
                </tr>
                
                <tr>
                    <td align="right">Country</td>
                    <td align="left">
                        <select name="country" id="country">
                            <c:forEach var="country" items="${mapCountries}">
                                <option value="${country.value}" <c:if test='${order.recipientCountry eq country.value}'>selected="selected"</c:if>>${country.key}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>

                
            </table>
            
        </div>
    
                
                <div align="center">
                    
                    <h2 class="pageHeading">Ordered products </h2>
                    
                    <table border="1">
                        
                        <tr>
                            <th>Index</th>
                            <th>Product Title</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                            <th>Actions</th>
                        </tr>
                        
                        <c:forEach var="details" items="${order.productDetails}" varStatus="status">
                            
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    ${details.product.title}
                                </td>
                                <td>
                                    <input type="hidden" name="price" value="${details.product.price}" />
                                    <fmt:formatNumber value="${details.product.price}" type="currency" />
                                </td>
                                <td>
                                    <input type="hidden" name="productID" value="${details.product.productID}" />
                                    <input type="text" name="quantity${status.index + 1}" value="${details.quantity}" size="5" />
                                </td>
                                <td><fmt:formatNumber value="${details.subtotal}" type="currency" /></td>
                                <td><a href="removeProductFromOrder?id=${details.product.productID}">Remove</a></td>
                            </tr>
                        </c:forEach>
                            
                            <tr>
                                <td colspan="7" align="right">
                                    <p>Subtotal: <fmt:formatNumber value="${order.subtotal}" type="currency" /></p>
                                    <p>Tax: <input type="text" size="5" name="tax" id="tax" value="${order.tax}" /><p>
                                    <p>Shipping Fee: <input type="text" size="5" name="shippingFee" id="shippingFee" value="${order.shippingFee}" /></p>
                                    <p>TOTAL:<fmt:formatNumber value="${order.total}" type="currency" /></p>
                                </td>
                            </tr>
                    </table>
                    
                </div>
                            
                            <div align="center">
                                <br />
                                
                                <a href="javascript:showProductPopup();"><b>Add Product</b></a>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="submit" value="Save" />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="button" value="Cancel" onclick="javascript:window.location.href=orders;" />
                            </div>
                            
    </form>
        
    </body>
    
    <script>
            
        function showProductPopup() {
            var width = 600;
            var left = (screen.width - width) / 2;
            var height = 250;
            var top = (screen.height - height) / 2;
            window.open('showAddProduct', 'blank', 'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left);
        }

        $(document).ready(function() {
            $("#orderForm").validate({
                rules: {
                    recipientFirstName: "required",
                    recipientLastName: "required",
                    recipientPhone: "required",
                    recipientAddress: "required",
                    recipientAddress2: "required",
                    recipientCity: "required",
                    recipientState: "required",
                    recipientZipcode: "required",
                    recipientCountry: "required",

                <c:forEach items="${order.productDetails}" var="item" varStatus="status">
                    quantity${status.index + 1} : {required: true, number: true, min: 1},
                </c:forEach>

                    shippingFee: {required: true, number: true, min: 0},
                    tax: {required: true, number: true, min: 0}
                },

                messages: {
                    recipientFirstName: "This field can not be empty",
                    recipientLastName: "This field can not be empty",
                    recipientPhone: "This field can not be empty",
                    recipientAddress: "This field can not be empty",
                    recipientAddress2: "This field can not be empty",
                    recipientCity: "This field can not be empty",
                    recipientState: "This field can not be empty",
                    recipientZipcode: "This field can not be empty",
                    recipientCountry: "This field can not be empty",

                    <c:forEach items="${order.productDetails}" var="item" varStatus="status">
                        quantity${status.index + 1} : {required: "Enter quantity", 
                            number: "Quantity must be number", 
                            min: "Quantity must be greater than 0"},
                    </c:forEach>

                    shippingFee: {
                        required: "This field can not be empty",
                        number: "Shipping fee must be a number",
                        min: "Value must be equal or greater than 0"
                    },

                    tax: {
                        required: "This field can not be empty",
                        number: "Tax must be a number",
                        min: "Value must be equal or greater than 0"
                    }
                }
            });
        });

    </script>
</html>
