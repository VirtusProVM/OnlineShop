<%-- 
    Document   : review-done
    Created on : 9 Apr 2024, 17:53:05
    Author     : vrle9
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Review Done</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    </head>
    <body>
        
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
                

            <table class="normal" width="60%">


                <tr>
                    <td align="right">Your reviews</td>
                    <td>&nbsp;</td>
                    <td align="left"><h2>${loggedCustomer.fullname}</h2></td>
                </tr>

                <tr>
                    <td colspan="3"><hr /></td>
                </tr>

                <tr>
                    <td>
                        <span id="bookTitle">${product.title}</span><br />
                        <img class="book-large" src="data:image/jpg;base64,${product.base64Image}" width="240" height="300" alt="slika" />
                    </td>
                    
                    <td colspan="2">
                        <h3>Your review has been posted.Thank you</h3>
                    </td>
                </tr>
            </table>
            
        </div>
    </body>
</html>
