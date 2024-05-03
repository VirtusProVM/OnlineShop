
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New Admin</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
    </head>
    <body>
        
        <div class="w3-center">
            <h1 class="w3-green">
                <c:if test="${admin != null}">
                    Edit Admin
                </c:if>

                <c:if test="${admin == null}">
                    Create New Admin
                </c:if>
            </h1>
            
        </div>
        
            
            <div class="w3-container w3-centered">
            
            <c:if test="${admin != null}">
                <form action="updateAdmin" method="POST" id="adminForm">
                <input type = "hidden" name = "adminID" value ="${admin.adminID}" />
            </c:if>
            
            <c:if test="${admin == null}">
                <form action="createAdmin" method="POST" id="adminForm">
            </c:if>
                    
                    <table class="w3-table">
                    <tr>
                        <td align="right">Email:</td>
                        <td align="left"><input type="text" id="email" name="email"
                            size="20" value="${admin.email}" class="w3-input" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Full Name:</td>
                        <td align="left"><input type="text" id="fullname"
                            name="fullname" size="20" value="${admin.fullname}" class="w3-input" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Password:</td>
                        <td align="left"><input type="password" id="password"
                            name="password" size="20" value="${admin.password}" class="w3-input" />
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input class="w3-button w3-green w3-round" type="submit" value="Save" /> 
                            <input class="w3-button w3-red w3-round" type="button" value="Cancel" onclick="javascript: history.go(-1)" />
                        </td>
                    </tr>

                </table>
                    
                </form>
        </div>
    </body>
</html>

<script type="text/javascript">
    
    $(document).ready(function() {
        $("#adminForm").validate({
            rules: {
                email: {
                    required: true,
                    email: true
                },
                fullname: "required",
                password: "required"
            },
            
            messages: {
                email: {
                    required: "Please enter email address",
                    email: "Enter valid email address"
                },
                fullname: "Please enter fullname",
                password: "Please enter password"
            }
            
        });
        
        $("#cancelButton").click(function () {
            history.go(-1);
        });
    });
    
</script>
