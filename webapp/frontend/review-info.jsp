<%-- 
    Document   : review-info
    Created on : 8 Apr 2024, 19:57:43
    Author     : vrle9
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Review Info</title>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            <form id="reviewForm">
                

                <table class="normal" width="60%">
                    
                    
                    <tr>
                        <td align="right">You already wrote review for this book</td>
                        <td>&nbsp;</td>
                        <td align="left"><h2>${loggedCustomer.fullname}</h2></td>
                    </tr>
                    
                    <tr>
                        <td colspan="3"><hr /></td>
                    </tr>
                    
                    <tr>
                        <td>
                            <span id="bookTitle">${book.title}</span><br />
                            <img class="book-large" src="data:image/jpg;base64,${book.base64Image}" width="240" height="300" alt="slika" />
                        </td>
                        
                        <td>
                            <div id="rateYo"></div>
                            
                            <input type="text" name="headline" size="60" readonly="readonly" value="${review.headline}" /><br />
                            
                            <textarea name="comment" cols="70" rows="10" readonly="readonly" >${review.comment}</textarea>
                        </td>
                    </tr>
                    
                    
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <button type="submit">Submit</button>
                            <button id="cancelButton"></button>
                        </td>
                    </tr>
                </table>
            </form>
            
        </div>
    </body>
    
    <script>
        
        $(document).ready(function() {
            $("#rateYo").rateYo({
              starWidth: "40px",
              fullStar: true,
              rating: ${review.rating},
              readOnly: true
            });
        });
        
        
    </script>
</html>
