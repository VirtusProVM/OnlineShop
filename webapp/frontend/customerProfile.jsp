<%-- 
    Document   : customerProfile
    Created on : 11 Apr 2024, 19:03:14
    Author     : vrle9
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${loggedCustomer.fullname}</title>
    </head>
    <body>
        
        <jsp:directive.include file="../frontend/topnav.jsp" />
        <jsp:directive.include file="../frontend/navbar.jsp" />
        
        <div align="center">
            <h3>Welcome ${loggedCustomer.fullname}</h3>
        
        
            <table class="customer">
                <tr>
                    <td><b>E-mail Address: </b></td>
                    <td>${loggedCustomer.email}</td>
                </tr>
                
                <tr>
                    <td><b>First name: </b></td>
                    <td>${loggedCustomer.firstname}</td>
                </tr><!-- comment -->
                
                <tr>
                    <td><b>Last name: </b></td>
                    <td>${loggedCustomer.lastname}</td>
                </tr>
                
                <tr>
                    <td><b>Phone number: </b></td>
                    <td>${loggedCustomer.phoneNumber}</td>
                </tr><!-- comment -->
                
                <tr>
                    <td><b>Zip-code: </b></td>
                    <td>${loggedCustomer.zipCode}</td>
                </tr>
                
                <tr>
                    <td><b>Address Line 1: </b></td>
                    <td>${loggedCustomer.addressLine1}</td>
                </tr>
                
                <tr>
                    <td><b>Address Line 2: </b></td>
                    <td>${loggedCustomer.addressLine2}</td>
                </tr>
                
                <tr>
                    <td><b>City: </b></td>
                    <td>${loggedCustomer.city}</td>
                </tr>
                
                <tr>
                    <td><b>State </b></td>
                    <td>${loggedCustomer.state}</td>
                </tr>
                
                <tr>
                    <td><b>Country: </b></td>
                    <td>${loggedCustomer.country}</td>
                </tr>
                
                <tr>
                    <td>&nbsp;</td>
                </tr>
                
                <tr>
                    <td colspan="2" align="center"><b><a href="editCustomerProfile">Edit Profile</a></b></td>
                </tr>
            </table>
        </div>
    </body>
</html>
