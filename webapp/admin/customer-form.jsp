
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
            <c:if test="${customer != null}">Edit Customer</c:if>
            <c:if test="${customer == null}">Create New Customer</c:if>
        </title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css"/>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.20.0/jquery.validate.min.js"></script>
    </head>
    <body>
        <div class="w3-center">
            <h1 class="w3-green">
                <c:if test="${customer != null}">
                    Edit Customer
                </c:if>

                <c:if test="${customer == null}">
                    Create New Customer
                </c:if>
            </h1>
            
        </div>
        
        <div class="w3-container w3-centered">
            
            <c:if test="${customer != null}">
                <form action="updateCustomer" method="POST" id="customerForm">
                <input type="hidden" name="customerID" value="${customer.customerID}" />
            </c:if>
            
            <c:if test="${customer == null}">
                <form action="createCustomer" method="POST" id="customerForm">
            </c:if>
                
            <table class="w3-table">
                
                <tr>
                    <td align="right">E-mail</td>
                    <td align="left"><input type="text" id="email" name="email" size="45" value="${customer.email}"/></td>
                </tr>

                <tr>
                    <td align="right">First Name</td>
                    <td align="left"><input type="text" id="firstname" name="firstname" size="45" value="${customer.firstname}"/></td>
                </tr>

                <tr>
                    <td align="right">Last Name</td>
                    <td align="left"><input type="text" id="lastname" name="lastname" size="45" value="${customer.lastname}"/></td>
                </tr>

                <tr>
                    <td align="right">Password</td>
                    <td align="left"><input type="password" id="password" name="password" size="45" value="${customer.password}"/></td>
                </tr>

                <tr>
                    <td align="right">Confirm password</td>
                    <td align="left"><input type="password" id="password2" name="password2" size="45" value="${customer.password}"/></td>
                </tr>

                <tr>
                    <td align="right">Phone number</td>
                    <td align="left"><input type="text" id="phone" name="phone" size="45" value="${customer.phoneNumber}"/><br />
                </tr>

                <tr>
                    <td align="right">Address Line 1</td>
                    <td align="left"><input type="text" id="addressLine_1" name="addressLine_1" size="45" value="${customer.addressLine1}"/></td>
                </tr>

                <tr>
                    <td align="right">Address Line 2</td>
                    <td align="left"><input type="text" id="addressLine_2" name="addressLine_2" size="45" value="${customer.addressLine2}"/></td>
                </tr>

                <tr>
                    <td align="right">City</td>
                    <td align="left"><input type="text" id="city" name="city" size="45" value="${customer.city}" /></td>
                </tr>

                <tr>
                    <td align="right">State</td>
                    <td align="left"><input type="text" id="state" name="state" size="45" value="${customer.state}"/></td>
                </tr>

                <tr>
                    <td align="right">Zip code</td>
                    <td align="left"><input type="text" id="zipcode" name="zipcode" size="45" value="${customer.zipCode}" /></td>
                </tr>

                <tr>
                    <td align="right">Country</td>
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
                        <input class="w3-button w3-green w3-round" type="submit" value="Save" /> 
                        <input class="w3-button w3-red w3-round" type="button" value="Cancel" onclick="javascript: history.go(-1)" />
                    </td>
                </tr>

            </table>
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
