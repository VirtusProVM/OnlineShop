
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Form</title>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <style>
            .icon {
                padding: 10px;
                background: dodgerblue;
                color: white;
                min-width: 50px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            <h2 class="w3-teal">Register Customer</h2>
        </div>
        
        <div align="center">
            
            <form action="register" method="POST" id="customerForm">
                
                <table class="form">
                        <tr>
                            <td align="right"><i class="fa fa-envelope icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="text" id="email" name="email" size="45" placeholder="E-mail"/></td>
                        </tr>

                        <tr>
                            <td align="right"><i class="fa fa-user icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="text" id="firstname" name="firstname" size="45" placeholder="First name"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right"><i class="fa fa-user icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="text" id="lastname" name="lastname" size="45" placeholder="Last name"/></td>
                        </tr>

                        <tr>
                            <td align="right"><i class="fa fa-key icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="password" id="password" name="password" size="45" placeholder="Password"/></td>
                        </tr>

                        <tr>
                            <td align="right"><i class="fa fa-key icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="password" id="password2" name="password2" size="45" placeholder="Confirm password"/></td>
                        </tr>

                        <tr>
                            <td align="right"><i class="fa fa-phone icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="text" id="phone" name="phone" size="45" placeholder="Phone number"/><br />
                        </tr>

                        <tr>
                            <td align="right"><i class="fa fa-address-card-o icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="text" id="addressLine_1" name="addressLine_1" size="45" placeholder="Address Line 1"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right"><i class="fa fa-address-card-o icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="text" id="addressLine_2" name="addressLine_2" size="45" placeholder="Address Line 2"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right"><i class="fa fa-globe icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="text" id="city" name="city" size="45" placeholder="City"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right"><i class="fa fa-globe icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="text" id="state" name="state" size="45" placeholder="State"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right"><i class="fa fa-address-card-o icon" aria-hidden="true"></i></td>
                            <td align="left"><input type="text" id="zipcode" name="zipcode" size="45" placeholder="Zip-code"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right"><i class="fa fa-globe icon" aria-hidden="true"></i></td>
                            <td align="left">
                                <select name="country" id="country">
                                    <c:forEach var="country" items="${mapCountries}">
                                        <option value="${country.value}" <c:if test='${customer.country eq country.value}'>selected="selected"</c:if>>${country.key}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td>&nbsp;</td>
                        </tr>

                        <tr>
                            <td colspan="2" align="center">
                                <button class="w3-button w3-green" type="submit">SAVE</button>
                                <button class="w3-button w3-red" id="cancelButton">Cancel</button>
                            </td>
                        </tr>
                    </table>
            </form>
            
            
        </div>
    </body>
    
    <script type="text/javascript">
            
        $(document).ready(function() {
            

            $("#customerForm").validate({
                rules: {
                    email: {
                        required: true,
                        email: true
                    },
                    firstname: "required",
                    lastname: "required",
                    password: "required",
                    
                    password2: {
                        required: true,
                        equalTo: "#password"
                    },
                    
                    phone: "required",
                    addressLine_1: "required",
                    addressLine_2: "required",
                    city: "required",
                    state: "required",
                    country: "required",
                    zipcode: "required"
                },
                messages: {
                    email: {
                        required: "Please enter email address",
                        email: "Please enter a valid email address"
                    },
                    firstname: "Please enter your first name",
                    lastname: "Please enter your last name",
                    password: "Please enter password",
                    
                    password2: {
                        required: "Confirm your password",
                        equalTo: "Confirm password does't match password"
                    }, 
                    phone: "Please enter your phone number",
                    addressLine_1: "Please enter your street address",
                    addressLine_2: "Please enter your second address",
                    city: "Please enter your city",
                    state: "Please enter your state",
                    country: "Please enter your country",
                    zipcode: "Please enter your zip code"
                }
            });

                $("#cancelButton").click(function() {
                history.go(-1);
            });
        });
    </script>
</html>
