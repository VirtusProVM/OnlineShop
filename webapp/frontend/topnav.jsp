
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<div class="w3-top">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
      
      <a href="${pageContext.request.contextPath}/" class="w3-bar-item w3-button"><b>LOGO</b></a>
    <div class="w3-right w3-hide-small">
        
        <c:if test="${loggedCustomer == null}">
            <a href="${pageContext.request.contextPath}/login" class="w3-bar-item w3-button"><i class="fa fa-sign-in" aria-hidden="true"></i>Sign In</a>
            <a href="${pageContext.request.contextPath}/registerCustomer" class="w3-bar-item w3-button"><i class="fa fa-user-plus" aria-hidden="true"></i></i>Register</a>
        </c:if>
            
            <c:if test="${loggedCustomer != null}">
                <a href="${pageContext.request.contextPath}/myProfile" class="w3-bar-item w3-button"><i class="fa fa-user" aria-hidden="true"></i>${loggedCustomer.fullname}</a>
                <a href="${pageContext.request.contextPath}/viewOrders" class="w3-bar-item w3-button"><i class="fa fa-user-plus" aria-hidden="true"></i></i>My Orders</a>
                <a href="${pageContext.request.contextPath}/logout" class="w3-bar-item w3-button"><i class="fa fa-sign-out" aria-hidden="true"></i></i>Logout</a>
            </c:if>
        
      
      <a href="${pageContext.request.contextPath}/viewCart" class="w3-bar-item w3-button"><i class="fa fa-shopping-cart w3-margin-right"></i></a>
    </div>
    
    <div class="w3-center">
        
        <form action="search" method="GET">
            <input type="text" name="keyword" size="50" />
            <input type="submit" value="Search" />
        </form>
    </div>
  </div><br/>
</div>
    <br/><br/>





