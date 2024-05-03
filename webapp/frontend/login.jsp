
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    
    <style>
        .icon {
            padding: 10px;
            background: dodgerblue;
            color: white;
            min-width: 50px;
            text-align: center;
            }
    </style>
    
    <body>
        
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            <h1 class="w3-teal">Computer Store</h1>
            <h2 class="w3-teal">Customer Login</h2>
            
            <c:if test="${message != null}">
                <div align="center">
                    <h4 class="message">${message}</h4>
                </div>
            </c:if>
            
            <form action="login" method="POST" id="formLogin">
                
                <table>
                    <tr>
                        <td><i class="fa fa-envelope icon" aria-hidden="true"></i></td>
                        <td><input type="text" name="email" id="email" size="20" placeholder="E-mail"/></td>
                    </tr>
                    
                    <tr>
                        <td><i class="fa fa-key icon" aria-hidden="true"></i></td>
                        <td><input type="password" name="password" id="password" size="20"placeholder="Password"/></td>
                    </tr>
                    
                    <tr>
                        <td colspan="2" align="center">
                            <button class="w3-button w3-teal" type="submit" name="loginBtn">Login</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
    
    <script type="text/javascript">
    
            $(document).ready(function() {
                $("#formLogin").validate({
                    rules: {
                        email: {
                            required: "true",
                            email: true
                        },
                        password: "required"
                    },

                    messages: {
                        email: {
                            required: "Please enter email address",
                            email: "Enter valid email address"
                        },
                        password: "Please enter password"
                    }

                });
            });

        </script>
</html>
