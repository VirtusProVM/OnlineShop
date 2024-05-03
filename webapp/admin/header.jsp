
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<nav class="w3-sidebar w3-collapse w3-light-grey w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
    <div class="w3-container w3-row">
      <div class="w3-col s4">
          <img src="${pageContext.request.contextPath}/images/logo.png" class="w3-circle w3-margin-right" style="width:46px">
      </div>
      <div class="w3-col s8 w3-bar">
          <span>Welcome, <strong><c:out value="${sessionScope.useremail}" /></strong></span><br>
          <a href="${pageContext.request.contextPath}/admin/logout" class="w3-bar-item w3-button"><i class="fa fa-sign-out" aria-hidden="true"></i></a>
      </div>
    </div>
    <hr>

    <div class="w3-container">
      <h5>Dashboard</h5>
    </div>
    <div class="w3-bar-block">
      <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>  Close Menu</a>
      <a href="${pageContext.request.contextPath}/admin/" class="w3-bar-item w3-button w3-padding w3-blue"><i class="fa fa-users fa-fw"></i>  Overview</a>
      <a href="${pageContext.request.contextPath}/admin/customers" class="w3-bar-item w3-button w3-padding"><i class="fa fa-eye fa-fw"></i>  Customers</a>
      <a href="${pageContext.request.contextPath}/admin/categories" class="w3-bar-item w3-button w3-padding"><i class="fa fa-users fa-fw"></i>  Category</a>
      <a href="${pageContext.request.contextPath}/admin/products" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bullseye fa-fw"></i>  Product</a>
      <a href="${pageContext.request.contextPath}/admin/reviews" class="w3-bar-item w3-button w3-padding"><i class="fa fa-diamond fa-fw"></i>  Review</a>
      <a href="${pageContext.request.contextPath}/admin/orders" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bell fa-fw"></i>  Orders</a>
      <a href="${pageContext.request.contextPath}/admin/admins" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bank fa-fw"></i>  Admin</a><br><br>
    </div>
</nav>
