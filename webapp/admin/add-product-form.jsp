
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product To Order</title>
    </head>
    <body>
        
        <div align="center">
            <h2>Add book to order ID: ${order.orderID}</h2>
            
            <form action="addProductToOrder" method="post">
                
                <table>
                    <tr>
                        <td>Select a Product</td>
                        <td><select name="productID">
                                <c:forEach var="product" items="${products}" varStatus="status">
                                    <option value="${product.productID}">
                                        ${product.title}
                                    </option>
                                </c:forEach>
                            </select></td>
                    </tr>
                    
                    <tr>
                        <td>Number Of copies</td>
                        <td><select name="quantity">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select></td>
                    </tr>
                    
                    <td colspan="2" align="center"></td>
                    <input type="submit" value="Add" />
                    <input type="button" value="cancel" onclick="javascript: self.close()" />
                </table>
                
            </form>
        </div>
    </body>
</html>
