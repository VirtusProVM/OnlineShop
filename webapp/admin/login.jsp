
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        
        
        <style>
            form {
                border: 3px solid #f1f1f1;
            }

            input[type=text], input[type=password] {
                width: 40%;
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                box-sizing: border-box;
              }

            button {
                background-color: #04AA6D;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                cursor: pointer;
                width: 40%;
              }

            button:hover {
                opacity: 0.8;
            }

            .imgcontainer {
                text-align: center;
                margin: 24px 0 12px 0;
            }

            img.avatar {
                width: 20%;
                border-radius: 50%;
            }

            .container {
                padding: 16px;
            }

            span.password {
                float: right;
                padding-top: 16px;
            }

            @media screen and (max-width: 300px) {
                span.password {
                  display: block;
                  float: none;
                }
            }
        </style>
        
    </head>
    <body>
        
        <form action="${pageContext.request.contextPath}/admin/login" method="POST">
            <div class="imgcontainer">
                <img src="../images/logo.png" alt="Avatar" class="avatar">
            </div>

            <div class="container" align="center">
                <b>Email</b><br/>
                <input type="text" placeholder="Enter Email" name="email" required minlength="5" maxlength="30"><br/>

                <b>Password</b><br/>
                <input type="password" placeholder="Enter Password" name="password" required minlength="8" maxlength="32"><br />

                <button type="submit">Login</button>
            </div>
        </form>
    </body>
</html>
