
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Management System</title>
        
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <style>
            html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
        </style>
        
    </head>
    <body class="w3-light-grey">
        
        <jsp:directive.include file="../admin/header.jsp" />
        
        <div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" 
             title="close side menu" id="myOverlay"></div>
             
        <div class="w3-main" style="margin-left:300px;margin-top:43px;">

            <header class="w3-container" style="padding-top:22px">
              <h5><b><i class="fa fa-dashboard"></i> Admin Dashboard</b></h5>
            </header>

            <div class="w3-row-padding w3-margin-bottom">
              <div class="w3-quarter">
                <div class="w3-container w3-red w3-padding-16">
                  <div class="w3-left"><i class="fa fa-comment w3-xxxlarge"></i></div>
                  <div class="w3-right">
                    <h3>${countCustomer}</h3>
                  </div>
                  <div class="w3-clear"></div>
                  <h4>Customers</h4>
                </div>
              </div>
                
              <div class="w3-quarter">
                <div class="w3-container w3-blue w3-padding-16">
                  <div class="w3-left"><i class="fa fa-eye w3-xxxlarge"></i></div>
                  <div class="w3-right">
                    <h3>${countProduct}</h3>
                  </div>
                  <div class="w3-clear"></div>
                  <h4>Products</h4>
                </div>
              </div>
                
                
              <div class="w3-quarter">
                <div class="w3-container w3-teal w3-padding-16">
                  <div class="w3-left"><i class="fa fa-share-alt w3-xxxlarge"></i></div>
                  <div class="w3-right">
                    <h3>${countReview}</h3>
                  </div>
                  <div class="w3-clear"></div>
                  <h4>Reviews</h4>
                </div>
              </div>
                
                
              <div class="w3-quarter">
                <div class="w3-container w3-orange w3-text-white w3-padding-16">
                  <div class="w3-left"><i class="fa fa-users w3-xxxlarge"></i></div>
                  <div class="w3-right">
                    <h3>${countOrders}</h3>
                  </div>
                  <div class="w3-clear"></div>
                  <h4>Orders</h4>
                </div>
              </div>
            </div>
            
        <div class="w3-panel">
            <div class="w3-row-padding" style="margin:0 -16px">
              <div class="w3-third">
                <h5>Company</h5>
                <img src="${pageContext.request.contextPath}/images/companyLogo.JPG" style="width:100%" alt="Google Regional Map">
              </div>

            <div class="w3-twothird">
              <h5>Feeds</h5>
              <table class="w3-table w3-striped w3-white">
                <tr>
                  <td><i class="fa fa-user w3-text-blue w3-large"></i></td>
                  <td>New record, over 90 views.</td>
                  <td><i>10 mins</i></td>
                </tr>

                <tr>
                  <td><i class="fa fa-bell w3-text-red w3-large"></i></td>
                  <td>Database error.</td>
                  <td><i>15 mins</i></td>
                </tr>

                <tr>
                  <td><i class="fa fa-users w3-text-yellow w3-large"></i></td>
                  <td>New record, over 40 users.</td>
                  <td><i>17 mins</i></td>
                </tr>

                <tr>
                  <td><i class="fa fa-comment w3-text-red w3-large"></i></td>
                  <td>New comments.</td>
                  <td><i>25 mins</i></td>
                </tr>

                <tr>
                  <td><i class="fa fa-bookmark w3-text-blue w3-large"></i></td>
                  <td>Check transactions.</td>
                  <td><i>28 mins</i></td>
                </tr>

                <tr>
                  <td><i class="fa fa-laptop w3-text-red w3-large"></i></td>
                  <td>CPU overload.</td>
                  <td><i>35 mins</i></td>
                </tr>

                <tr>
                  <td><i class="fa fa-share-alt w3-text-green w3-large"></i></td>
                  <td>New shares.</td>
                  <td><i>39 mins</i></td>
                </tr>

              </table>
            </div>
        </div>
      </div>
    <hr>
    
    <div class="w3-container">
        <h5 class="w3-teal">Latest Orders</h5>
        
        <c:forEach var="order" items="${orders}">
            <ul class="w3-ul w3-card-4 w3-white">
                <span class="w3-xlarge">Product Copies: ${order.productCopies}</span><br>
                <span class="w3-xlarge">Order By: ${order.customer.fullname}</span><br>
            </ul>
        </c:forEach>
  </div>
  <hr>

  <div class="w3-container">
      <h5 class="w3-teal">Latest Products</h5>
      
      <c:forEach var="product" items="${products}">
            <ul class="w3-ul w3-card-4 w3-white">
                <span class="w3-xlarge">Title: ${product.title}</span><br>
                <span class="w3-xlarge">Price: ${product.price}</span><br>
                <span class="w3-xlarge">Publish Date: ${product.publishDate}</span><br>
            </ul>
        </c:forEach>
  </div>
  
  <hr>
  
  <div class="w3-container">
      <h5 class="w3-teal">Latest Customers</h5>
        <c:forEach var="customer" items="${customers}">
            <ul class="w3-ul w3-card-4 w3-white">
                <span class="w3-xlarge">Title: ${customer.fullname}</span><br>
                <span class="w3-xlarge">Price: ${customer.addressLine1}</span><br>
                <span class="w3-xlarge">Publish Date: ${customer.country}</span><br>
            </ul>
        </c:forEach>
  </div>
  <hr>

  <div class="w3-container">
      <h5 class="w3-teal">Recent Comments</h5>
      
      <c:forEach var="review" items="${reviews}">
          <div class="w3-row">
      
            <div class="w3-col m10 w3-container">
              <h4>${review.customer.fullname} <span class="w3-opacity w3-medium">${review.reviewTime}</span></h4>
              <p>${review.comment}</p><br>
            </div>
          </div>
      </c:forEach>
  </div>
  <br>
</div>

        
    </body>
</html>
