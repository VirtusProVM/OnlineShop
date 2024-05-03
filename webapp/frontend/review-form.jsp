
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Write Review</title>
        
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
        
        <div>
            <form id="reviewForm" action="submitReview" method="POST">
                
                <table style="width: 60%;">
                    
                    <tr>
                        <td align="right"><h3>Your reviews</h3></td>
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
                        
                        <td>
                            <div id="rateYo"></div>
                            
                            <input type="hidden" name="rating" id="rating" />
                            
                            <input type="hidden" name="id" value="${product.productID}" />
                            
                            <input type="text" name="headline" size="60" placeholder="Headline for your review" /><br /><br />
                            
                            <textarea name="comment" cols="70" rows="10" placeholder="Write review details"></textarea>
                        </td>
                    </tr>
                    
                    
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <button type="submit">Submit</button>
                            <button id="cancelButton">Cancel</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
    
    <script type="text/javascript">
            
            $("#cancelButton").click(function () {
                history.go(-1);
            });
        
            $(document).ready(function() {
                $("#reviewForm").validate({
                    rules: {
                        headline: "required",
                        comment: "required"
                    },

                    messages: {
                        headline: "Please enter headline description",
                        comment: "Please enter comment"
                    }                    
                });
             
                $("#rateYo").rateYo({
                    starWidth: "40px",
                    fullStar: true,
                    onSet: function(rating, ratingYoInstance) {
                    $("#rating").val(rating);
                }
            });

        });
    </script>
</html>
