
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile</title>
    </head>
    <body>
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            <h2 class="pageHeading">
                Edit my Profile
            </h2>
        </div>
        
        <div align="center">
                <form action="updateProfile" method="post" id="customerForm">
                        
                    <table class="form">
                        <tr>
                            <td align="right">E-mail</td>
                            <td align="left"><b>${loggedCustomer.email}</b> (Cannot be changed)</td>
                        </tr>

                        <tr>
                            <td align="right">First name</td>
                            <td align="left"><input type="text" id="firstname" name="firstname" size="45" value="${loggedCustomer.firstname}"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right">Last name</td>
                            <td align="left"><input type="text" id="lastname" name="lastname" size="45" value="${loggedCustomer.lastname}"/></td>
                        </tr>

                        <tr>
                            <td align="right">Phone number</td>
                            <td align="left"><input type="text" id="phone" name="phone" size="45" value="${loggedCustomer.phoneNumber}"/><br />
                        </tr>

                        <tr>
                            <td align="right">Address Line 1</td>
                            <td align="left"><input type="text" id="address" name="addressLine_1" size="45" value="${loggedCustomer.addressLine1}"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right">Address Line 2</td>
                            <td align="left"><input type="text" id="address" name="addressLine_2" size="45" value="${loggedCustomer.addressLine2}"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right">City</td>
                            <td align="left"><input type="text" id="city" name="city" size="45" value="${loggedCustomer.city}"/></td>
                        </tr><!-- comment -->
                        
                        <tr>
                            <td align="right">State</td>
                            <td align="left"><input type="text" id="state" name="state" size="45" value="${loggedCustomer.state}"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right">Zip code</td>
                            <td align="left"><input type="text" id="zipcode" name="zipcode" size="45" value="${loggedCustomer.zipCode}"/></td>
                        </tr>
                        
                        <tr>
                            <td align="right">Country</td>
                            <td align="left">
                                <select name="country" id="country">
                                    <c:forEach var="country" items="${mapCountries}">
                                        <option value="${country.value}" <c:if test='${loggedCustomer.country eq country.value}'>selected="selected"</c:if>>${country.key}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="2" align="center">
                                <i>(Leave password field blank if you don't want to change password.)</i>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right">Password</td>
                            <td align="left"><input type="password" id="password" name="password" size="45"/></td>
                        </tr>

                        <tr>
                            <td align="right">Confirm password</td>
                            <td align="left"><input type="password" id="password2" name="password2" size="45"/></td>
                        </tr>

                        <tr>
                            <td>&nbsp;</td>
                        </tr>

                        <tr>
                            <td colspan="2" align="center">
                                <button type="submit">SAVE</button>
                                <button id="cancelButton">Cancel</button>
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
                    
                    password2: {
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
                    
                    password2: {
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
