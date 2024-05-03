
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<div class="w3-bar w3-blue-grey w3-margin-top">
  <c:forEach var="category" items="${categorys}" varStatus="status">
      <a href="viewProductByCategory?id=${category.categoryID}" class="w3-bar-item w3-button">
        <font>
            <b><c:out value="${category.name}" /></b>
        </font>

    </a>
            <c:if test="${not status.last}">
                &nbsp;
            </c:if>

    </c:forEach>
</div>
<br/>
