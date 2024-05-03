
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Review Management</title>
        
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
    </head>
    <body>
        <jsp:directive.include file="../admin/header.jsp" />
        
        <div align="center">
            <h3>Edit Category</h3>
        </div>
        
        <div align="center">
            <form action="updateReview" method="POST" id="reviewForm">
                <input type="hidden" name="reviewID" value="${review.reviewID}" />

                <table>
                    <tr>
                        <td align="right">Product</td>
                        <td align="left">${review.product.title}</td>
                    </tr>
                    
                    <tr>
                        <td align="right">Rating</td>
                        <td align="left">${review.rating}</td>
                    </tr><!-- comment -->
                    
                    <tr>
                        <td align="right">Customer</td>
                        <td align="left">${review.customer.fullname}</td>
                    </tr>
                    
                    <tr>
                        <td align="right">Headline</td>
                        <td align="left"><input type="text" id="headline" size="60" value="${review.headline}" name="headline" /></td>
                    </tr>
                    
                    <tr>
                        <td align="right">Comment</td>
                        <td align="left">
                            <textarea cols="70" rows="5" name="comment">${review.comment}</textarea>
                        </td>
                    </tr>
                    
                    
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <button type="submit">Save</button>
                            <input type="button" id="cancelButton" value="Cancel" />
                        </td>
                    </tr>
                </table>
            </form>
            
        </div>
    </body>
</html>
